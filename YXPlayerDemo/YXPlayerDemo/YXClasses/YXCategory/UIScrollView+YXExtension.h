//
//  UIScrollView+YXExtension.h
//  YXiOSPlayerTest
//
//  Created by 丁彦鹏 on 16/9/13.
//  Copyright © 2016年 YunXi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
@interface UIScrollView (YXExtension)
//添加默认的上拉和下拉刷新样式
- (void)yx_addDefaultTextHeaderRefresh:(MJRefreshComponentRefreshingBlock)refreshingBlock;
- (void)yx_addDefaultTextFooterRefresh:(MJRefreshComponentRefreshingBlock)refreshingBlock;
@end
