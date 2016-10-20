//
//  YXLiveListViewController.m
//  YXiOSPlayerTest
//
//  Created by 丁彦鹏 on 16/9/13.
//  Copyright © 2016年 YunXi. All rights reserved.
//

#import "YXLiveListViewController.h"
#import "YXGlobalDefine.h"
#import "YXLiveListCollectionView.h"
#import "YXLiveDetailViewController.h"
#import "YXCollectionLayout.h"
#import "YXLiveModel.h"
#import "YXNetWorking.h"
#import "UIScrollView+YXExtension.h"
#import "YXLiveCollectionCell.h"

@interface YXLiveListViewController ()<UICollectionViewDelegate>
@property (nonatomic, weak) YXLiveListCollectionView *listCollectionView ;
@property (nonatomic, assign) int page;
@end

@implementation YXLiveListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"直播列表";
    self.view.backgroundColor = [UIColor colorWithRed:250/255 green:250/255 blue:250/255 alpha:1];
    [self addSubviews];
    [self addConstraintsForSubvies];
    self.page = 1;
    [self.listCollectionView.mj_header beginRefreshing];
}

- (void)addSubviews {
    YXLiveListCollectionView *listCollectionView = [[YXLiveListCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[YXCollectionLayout alloc] init]];
    listCollectionView.delegate = self;
    __weak typeof(self) weakSelf = self;
    [listCollectionView yx_addDefaultTextHeaderRefresh:^{
        YXLiveListViewController *stongSelf = weakSelf;
        if (stongSelf.listCollectionView.mj_footer.isRefreshing) {
            [stongSelf.listCollectionView.mj_header endRefreshing];
            return ;
        }
        stongSelf.page = 1;
        [stongSelf sendRequest:YXActitity_List
                          para:@{@"accessKey":
                                     YXAccessKey,
                                 @"page":[NSString stringWithFormat:@"%d",stongSelf.page],
                                 @"pageSize":@"20",
                                 }];
    }];
    
    [listCollectionView yx_addDefaultTextFooterRefresh:^{
        YXLiveListViewController *stongSelf = weakSelf;
        if (stongSelf.listCollectionView.mj_header.isRefreshing) {
            [stongSelf.listCollectionView.mj_footer endRefreshing];
            return ;
        }
        stongSelf.page += 1;
        [stongSelf sendRequest:YXActitity_List para:@{@"accessKey":YXAccessKey,
                                                    @"page":[NSString stringWithFormat:@"%d",stongSelf.page],
                                                    @"pageSize":@"20",
                                                    }];
    }];
    [self.view addSubview:listCollectionView];
    self.listCollectionView = listCollectionView;
}

- (void)addConstraintsForSubvies {
    [self.listCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark Send Request
- (void)sendRequest:(NSString *)urlStr para:(NSDictionary *)para {
    [YXNetWorking postUrlString:urlStr paramater:para success:^(id obj, NSURLResponse *response) {
        if ([urlStr  isEqual: YXActitity_List]) {
            int pageCount = [obj[@"data"][@"pageCount"] intValue];
            if (self.page == 1) {
                [self.listCollectionView.mj_header endRefreshing];
                [self.listCollectionView.dataArr removeAllObjects];
            } else {
                [self.listCollectionView.mj_footer endRefreshing];
                if (self.page > pageCount) {
                    self.listCollectionView.mj_footer.state = MJRefreshStateNoMoreData;
                    return ;
                }
            }
            NSArray *activities = obj[@"data"][@"activities"];
            NSMutableArray *models = [NSMutableArray arrayWithCapacity:activities.count];
            for (NSDictionary *dic in activities) {
                YXLiveModel *model = [YXLiveModel liveModelWithDic:dic];
                [models addObject:model];
            }
            [self.listCollectionView.dataArr addObjectsFromArray:models];
            [self.listCollectionView reloadData];
        }
        
    } fail:^(NSError *error, NSString *errorMessage) {
        if ([urlStr  isEqual: YXActitity_List]) {
            if (self.page == 1) {
                [self.listCollectionView.mj_header endRefreshing];
            } else {
                [self.listCollectionView.mj_footer endRefreshing];
            }
        }
        NSLog(@"%@", errorMessage);
    }];
}

#pragma mark collectionDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    YXLiveDetailViewController *liveDetailVC = [[YXLiveDetailViewController alloc] init];
    liveDetailVC.liveModel = self.listCollectionView.dataArr[indexPath.item];
    YXLiveCollectionCell *cell = (YXLiveCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    liveDetailVC.didUpdateStreamStatus = ^(NSInteger streamStaus){
        cell.streamStatus = streamStaus;
    };
    [self.navigationController pushViewController:liveDetailVC animated:true];
}

- (void)dealloc
{
    NSLog(@"YXLiveListViewController 销毁");
}

@end
