//
//  UIScrollView+YXExtension.m
//  YXiOSPlayerTest
//
//  Created by 丁彦鹏 on 16/9/13.
//  Copyright © 2016年 YunXi. All rights reserved.
//

#import "UIScrollView+YXExtension.h"

@implementation UIScrollView (YXExtension)
- (void)yx_addDefaultTextHeaderRefresh:(MJRefreshComponentRefreshingBlock)refreshingBlock {
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        self.mj_footer.state = MJRefreshStateIdle;
        refreshingBlock();
    }];
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"正在加载" forState:MJRefreshStateRefreshing];
    header.stateLabel.font = [UIFont systemFontOfSize:12];
    header.stateLabel.textColor = [UIColor grayColor];
    self.mj_header = header;
}

- (void)yx_addDefaultTextFooterRefresh:(MJRefreshComponentRefreshingBlock)refreshingBlock {
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        refreshingBlock();
    }];
    
    [footer setTitle:@"上拉刷新" forState:MJRefreshStateIdle];
    [footer setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    [footer setTitle:@"正在为您加载" forState:MJRefreshStateRefreshing];
    [footer setTitle:@"没有更多数据了" forState:MJRefreshStateNoMoreData];
    footer.stateLabel.font = [UIFont systemFontOfSize:12];
    footer.stateLabel.textColor = [UIColor grayColor];
    self.mj_footer = footer;
    self.mj_footer.automaticallyChangeAlpha = YES;
}



@end
