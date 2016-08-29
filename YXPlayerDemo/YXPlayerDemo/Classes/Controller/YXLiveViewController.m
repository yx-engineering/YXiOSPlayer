//
//  YXLiveViewController.m
//  LiveSDK
//
//  Created by 丁彦鹏 on 16/8/22.
//  Copyright © 2016年 YunXi. All rights reserved.
//

#import "YXLiveViewController.h"
#import "YXPlayView.h"
@interface YXLiveViewController ()
@property (nonatomic, weak) YXPlayView *playView;
@property (nonatomic, weak) UIButton *playBtn;
@end

@implementation YXLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"云犀直播";
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    [self addSubViews];
    [self addConstraintsForSubviews];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void) addSubViews {
    YXPlayView *playView = [[YXPlayView alloc] init];
    playView.backgroundColor = [UIColor redColor];
    [self.view addSubview:playView];
    self.playView = playView;
    UIButton *playBtn = [[UIButton alloc] init];
    [playBtn setImage:[UIImage imageNamed:@"detail_play_icon"] forState:UIControlStateNormal];
    [playBtn setImage:[UIImage imageNamed:@"detail_pause_icon"] forState:UIControlStateSelected];
    [playBtn addTarget:self action:@selector(didClickPlayBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playBtn];
    self.playBtn = playBtn;
}

- (void) addConstraintsForSubviews {
    [self.playView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@200);
    }];
    
    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.playView);
        make.height.with.equalTo(@100);
    }];
}
- (void)didClickPlayBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.playView.play = sender.selected;
}


- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection
              withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator
{
    [super willTransitionToTraitCollection:newCollection
                 withTransitionCoordinator:coordinator];
    [coordinator animateAlongsideTransition:^(id <UIViewControllerTransitionCoordinatorContext> context) {
        if (newCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact) {
            [self.playView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.view);
            }];
            
        } else {
            [self.playView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.equalTo(self.view);
                make.height.equalTo(@200);
            }];
        }
        [self.view setNeedsLayout];
    } completion:nil];
}





@end
