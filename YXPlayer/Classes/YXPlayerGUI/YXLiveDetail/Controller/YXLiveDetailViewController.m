//
//  YXLiveDetailViewController.m
//  YXiOSPlayerTest
//
//  Created by 丁彦鹏 on 16/9/12.
//  Copyright © 2016年 YunXi. All rights reserved.
//

#import "YXLiveDetailViewController.h"
#import "YXGlobalDefine.h"
#import "YXPlayView.h"
#import "YXCommentView.h"
#import "YXTitleBar.h"
#import "YXCommentTableView.h"
#import "YXWebView.h"

#import "YXLiveModel.h"
#import "YXNetWorking.h"
#import "YXModule.h"
#import "YXCommentModel.h"
#import "UIColor+YXExtension.h"
#import "WilddogSync.h"


@interface YXLiveDetailViewController ()

@property (nonatomic, weak) YXPlayView *playView;
@property (nonatomic, weak) YXTitleBar *titleBar;
@property (nonatomic, weak) YXCommentView *commentView;
@property (nonatomic, weak) UIButton *playBtn; //播放和暂停
@property (nonatomic, weak) UIButton *controlScreeBtn; //控制屏幕旋转

@property (nonatomic, copy) NSArray<YXModule *> *modules; //模块
@property (nonatomic, copy) NSArray<NSString *> *moduleTitles;
@property (nonatomic, strong) UIColor *themColor; //模块按钮颜色
@property (nonatomic, copy) NSString *streamId;
@property (nonatomic, assign) NSInteger page; //评论的page
@property (nonatomic, strong) Wilddog *wilddogRef;
@property (nonatomic, assign) WilddogHandle wilddogHandle;
@property (nonatomic, assign) WilddogHandle wilddogRemoveHandle;
@end

@implementation YXLiveDetailViewController

- (instancetype)init {
    self = [super init];
    [self addSubviews];
    [self addConstraintsForSubviews];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"直播详情";
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    self.edgesForExtendedLayout = UIRectEdgeBottom;
}

- (void)addSubviews {
    YXPlayView *playView = [[YXPlayView alloc] init];
    __weak typeof(self) weakSelf = self;
    playView.statusDidChangBlock =  ^(PLPlayerStatus status) {
        YXLiveDetailViewController *strongSelf = weakSelf;
        switch (status) {
            case PLPlayerStatusPlaying:
                strongSelf.playBtn.selected = YES;
                break;
            default:
                strongSelf.playBtn.selected = NO;
                break;
        }
    };
    [playView addTapTarget:self action:@selector(didTapPlayView)];
    [self.view addSubview:playView];
    self.playView = playView;
    
    UIButton *playBtn = [[UIButton alloc] init];
    [playBtn setImage:[UIImage imageNamed:@"detail_play_icon"] forState:UIControlStateNormal];
    [playBtn setImage:[UIImage imageNamed:@"detail_pause_icon"] forState:UIControlStateSelected];
    [playBtn addTarget:self action:@selector(didClickPlayBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playBtn];
    self.playBtn = playBtn;
    
    UIButton *controlScreeBtn = [[UIButton alloc] init];
    [controlScreeBtn setImage:[UIImage imageNamed:@"detail_fullscreen_btn_normal"] forState:UIControlStateNormal];
    [controlScreeBtn addTarget:self action:@selector(didClickControllScreenBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:controlScreeBtn];
    self.controlScreeBtn = controlScreeBtn;
    
}

- (void)addConstraintsForSubviews {
    [self.playView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(self.playView.mas_width).multipliedBy(0.56);
    }];
    
    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.playView);
        make.size.mas_equalTo(CGSizeMake(65, 65));
    }];
    
    [self.controlScreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-10);
        make.bottom.equalTo(self.playView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(33, 33));
    }];
}

#pragma mark setter
- (void)setLiveModel:(YXLiveModel *)liveModel {
    _liveModel = liveModel;
    [self sendRequest:Livestream_Info para:@{@"accessKey":AccessKey,
                                             @"activityId":liveModel.liveId}];
}

- (void)setModules:(NSArray<YXModule *> *)modules {
    _modules = modules;
    [self.titleBar removeFromSuperview];
    
    YXCommentView *commentView = [[YXCommentView alloc] init];
    __weak typeof(self) weakSelf = self;
    commentView.commentTableView.startLoadMoreData = ^{
        YXLiveDetailViewController *strongSelf = weakSelf;
        strongSelf.page += 1;
        NSString *page = [NSString stringWithFormat:@"%ld",strongSelf.page];
        [strongSelf sendRequest:Comments_List para:@{@"accessKey":AccessKey,
                                               @"lsId":strongSelf.streamId,
                                               @"page":page}];

    };
    self.commentView = commentView;
    NSMutableArray *views = [NSMutableArray arrayWithCapacity:self.moduleTitles.count];
    [views addObject:commentView];
    for (int i = 1; i < self.moduleTitles.count; ++i) {
        YXWebView *view = [YXWebView new];
        view.backgroundColor = [UIColor whiteColor];
        if (modules[i].editorValue) {
            view.content = modules[i].editorValue;
        }
        [views addObject:view];
    }
    
    YXTitleBar *titleBar = [YXTitleBar titleBarWithTitleArray:self.moduleTitles  Frame:CGRectZero titleH:45 showDetaiViews:views];
    [self.view addSubview:titleBar];
    self.titleBar = titleBar;
    [titleBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.playView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}

- (void)setStreamId:(NSString *)streamId {
    _streamId = streamId;
    self.commentView.streamId = streamId;
    self.liveModel.streamId = streamId;
    self.playView.liveModel = self.liveModel;
}

- (void)setThemColor:(UIColor *)themColor {
    _themColor = themColor;
    self.titleBar.btnsBackColor = themColor;
}

#pragma mark 网络请求
- (void)sendRequest:(NSString *)urlStr para:(NSDictionary *)para {
    [YXNetWorking postUrlString:urlStr paramater:para success:^(id obj, NSURLResponse *response) {
        if ([urlStr  isEqual: Livestream_Info]) {
            NSDictionary *data = obj[@"data"];
            NSDictionary *templateData = data[@"templateData"];
            //模块
            if (![templateData isKindOfClass:[NSNull class]]) {
                NSMutableArray *modules = [NSMutableArray array];
                NSMutableArray *titles = [NSMutableArray array];
                for (NSDictionary *dic in templateData[@"modules"]) {
                    YXModule *module = [YXModule moduleWithDic:dic];
                    if ([module.type isEqualToString:@"comment"]) {
                        //评论放在第一个
                        [modules insertObject:module atIndex:0];
                        [titles insertObject:module.name atIndex:0];
                    } else {
                        [modules addObject:module];
                        [titles addObject:module.name];
                    }
                }
                self.moduleTitles = titles;
                self.modules = modules;
                
                NSString *themeColor = templateData[@"themeColor"];
                themeColor = [themeColor stringByReplacingOccurrencesOfString:@"#" withString:@"0x"];
                unsigned long hex = strtoul([themeColor UTF8String], 0, 0);
                self.themColor = [UIColor hexColor:hex];
            }
            self.streamId = data[@"livestream"][@"id"];
            //获取评论
            self.page = 1;
            NSString *page = [NSString stringWithFormat:@"%ld",self.page];
            [self sendRequest:Comments_List para:@{@"accessKey":AccessKey,
                                                   @"lsId":self.streamId,
                                                   @"page":page}];
            
        } else if ([urlStr isEqualToString:Comments_List]) {
            if (self.page > 1) {
                [self.commentView.commentTableView.indicator stopAnimating];
            }
            NSArray *comments = obj[@"data"][@"comments"];
            if (![comments isKindOfClass:[NSNull class]]) {
                for (NSDictionary *dic in comments) {
                    YXCommentModel *commentModel = [YXCommentModel commentModelWithDic:dic];
                    [self.commentView.commentTableView.dataArr addObject:commentModel];
                }
                if (comments.count > 0) {
                    [self.commentView.commentTableView reloadData];
                }
            }
            [self createWildDog];
        }
    } fail:^(NSError *error, NSString *errorMessage) {
        if ([urlStr isEqualToString:Comments_List]) {
            [self createWildDog];
            if (self.page > 1) {
                self.page -= 1;
                [self.commentView.commentTableView.indicator stopAnimating];
            }
        }
        NSLog(@"errorMessage：%@", errorMessage);
    }];
}


- (void)createWildDog {
    if (self.wilddogRef || !self.streamId) {
        return ;
    }
    NSString *wildDogUrl = [NSString stringWithFormat:@"%@%@/comments",YXWildDogLivestream,self.streamId];
    NSLog(@"wildDogUrl: %@",wildDogUrl);
    
    self.wilddogRef = [[Wilddog alloc] initWithUrl:wildDogUrl];
    __weak typeof(self) weakSelf = self;
    self.wilddogHandle = [self.wilddogRef observeEventType:WEventTypeChildAdded withBlock:^(WDataSnapshot * _Nonnull snapshot) {
        YXLiveDetailViewController *strongSelf = weakSelf;
        
        NSData *data = [snapshot.value dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        YXCommentModel *commentModel = [YXCommentModel commentModelWithDic:dic];
        if (strongSelf.commentView.commentTableView.dataArr.count > 0) {
            YXCommentModel *firstComment = (YXCommentModel *)strongSelf.commentView.commentTableView.dataArr.firstObject;
            if (commentModel.floor.integerValue > firstComment.floor.integerValue) {
                [strongSelf.commentView.commentTableView.dataArr insertObject:commentModel atIndex:0];
                [strongSelf.commentView.commentTableView  insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]]  withRowAnimation:UITableViewRowAnimationNone];
            }
        } else {
            [strongSelf.commentView.commentTableView.dataArr insertObject:commentModel atIndex:0];
            [strongSelf.commentView.commentTableView  insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]]  withRowAnimation:UITableViewRowAnimationNone];
        }
        //                NSLog(@"wilddog: %@",dic);
    }];
    self.wilddogRemoveHandle = [self.wilddogRef observeEventType:WEventTypeChildRemoved withBlock:^(WDataSnapshot * _Nonnull snapshot) {
//        YXLiveDetailViewController *strongSelf = weakSelf;
        NSLog(@"删除：%@",snapshot.value);
    }];
}

#pragma mark target
- (void)didTapPlayView {
    [self.commentView resignTextviewFirstResponder];
    self.playBtn.hidden = !self.playBtn.hidden;
    self.controlScreeBtn.hidden = !self.controlScreeBtn.hidden;
}

- (void)didClickPlayBtn:(UIButton *)sender {
    self.playView.play = !self.playView.play;
}

- (void)didClickControllScreenBtn {
    UIInterfaceOrientation interfaceOrientation = [UIApplication sharedApplication].statusBarOrientation;
    switch (interfaceOrientation) {
            //竖屏转横屏
        case UIInterfaceOrientationPortrait:
            [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationLandscapeRight) forKey:@"orientation"];
            break;
            
        case UIInterfaceOrientationPortraitUpsideDown:
            [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationLandscapeRight) forKey:@"orientation"];
            break;
            //横屏转竖屏
        case UIInterfaceOrientationLandscapeLeft:
            [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationPortrait) forKey:@"orientation"];
            break;
            
        case UIInterfaceOrientationLandscapeRight:
            [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationPortrait) forKey:@"orientation"];
            break;
            
        default:
            break;
    }
}

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection
              withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator
{
    [super willTransitionToTraitCollection:newCollection
                 withTransitionCoordinator:coordinator];
    [self.commentView resignTextviewFirstResponder];
    [coordinator animateAlongsideTransition:^(id <UIViewControllerTransitionCoordinatorContext> context) {
        if (newCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact) {
            [self.playView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.view);
            }];
            self.navigationController.navigationBar.hidden = YES;
        } else {
            [self.playView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.equalTo(self.view);
                make.height.equalTo(self.playView.mas_width).multipliedBy(0.56);
            }];
            self.navigationController.navigationBar.hidden = false;
        }
    } completion:nil];
}

- (void)dealloc
{
    if (self.wilddogRef) {
        [self.wilddogRef removeObserverWithHandle:self.wilddogHandle];
        [self.wilddogRef removeObserverWithHandle:self.wilddogRemoveHandle];
        self.wilddogRef = nil;
    }
    NSLog(@"YXLiveDetailViewController 销毁");
}


@end
