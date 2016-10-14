//
//  CommentTableView.h
//  YXiOSPlayerTest
//
//  Created by 丁彦鹏 on 16/9/12.
//  Copyright © 2016年 YunXi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXCommentTableView : UITableView
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, weak) UIActivityIndicatorView *indicator;
@property (nonatomic, copy) void (^startLoadMoreData)();
@end
