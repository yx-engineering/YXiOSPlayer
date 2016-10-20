//
//  CommentTableView.m
//  YXiOSPlayerTest
//
//  Created by 丁彦鹏 on 16/9/12.
//  Copyright © 2016年 YunXi. All rights reserved.
//

#import "YXCommentTableView.h"
#import "YXCommentTableCell.h"
#import "YXCommentModel.h"

@interface YXCommentTableView ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation YXCommentTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    //初始化，frame不为 CGRectZero，就不会有报约束冲突了
    self = [super initWithFrame:CGRectMake(0, 0, 100, 100) style:UITableViewStylePlain];
    self.backgroundColor = [UIColor clearColor];
    self.delegate = self;
    self.dataSource = self;
    self.rowHeight = UITableViewAutomaticDimension;
    self.estimatedRowHeight = 45;
    [self registerClass:[YXCommentTableCell class] forCellReuseIdentifier:@"YXCommentTableCell"];
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.tableFooterView = indicator;
    self.indicator = indicator;
    return self;
}

//上拉加载更多
- (void)loadMoreData {
    if (self.startLoadMoreData) {
        self.startLoadMoreData();
    }
}

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"TestCommentContent.plist" ofType:nil];
//        NSArray *arr = [NSArray arrayWithContentsOfFile:path];
//        for (NSDictionary *dic in arr) {
//            YXCommentModel *model = [YXCommentModel commentModelWithDic:dic];
//            [_dataArr addObject:model];
//        }
    }
    return _dataArr;
}


#pragma mark TableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.dataArr.count - 1 && !self.indicator.isAnimating) {
        [self.indicator startAnimating];
        [self loadMoreData];
    }
    
    YXCommentTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YXCommentTableCell" forIndexPath:indexPath];
    cell.commentModel = self.dataArr[indexPath.row];
    return cell;
}

#pragma mark TableViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [UIMenuController sharedMenuController].menuVisible = NO;
}

@end
