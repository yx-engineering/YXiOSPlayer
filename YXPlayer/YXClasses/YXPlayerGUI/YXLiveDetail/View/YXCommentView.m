//
//  CommentView.m
//  YXiOSPlayerTest
//
//  Created by 丁彦鹏 on 16/9/14.
//  Copyright © 2016年 YunXi. All rights reserved.
//

#import "YXCommentView.h"
#import "YXGlobalDefine.h"
#import "YXCommentTableView.h"
#import "YXBottomInputView.h"
#import "YXCommentModel.h"
#import "YXNetWorking.h"


@interface YXCommentView ()<YXBottomInputViewDelegate>
@property (nonatomic, strong) MASConstraint *bottomInputViewBotConstarint;
@end

@implementation YXCommentView

- (instancetype)init {
    //初始化，frame不为 CGRectZero，就不会有报约束冲突了
    self = [super initWithFrame:CGRectMake(0, 0, 100, 100)];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubviews];
        [self addConstarinsForSubviews];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
    return self;
}

- (void)addSubviews {
    YXCommentTableView *commentTableView = [[YXCommentTableView alloc] init];
    [self addSubview:commentTableView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapCommentTableView)];
    [commentTableView addGestureRecognizer:tap];
    self.commentTableView = commentTableView;
    
    YXBottomInputView *bottomInputView = [[YXBottomInputView alloc] init];
    bottomInputView.delegate = self;
    [self addSubview:bottomInputView];
    self.bottomInputView = bottomInputView;
}

- (void)addConstarinsForSubviews {
    [self.commentTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(-49);
    }];
    
    [self.bottomInputView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.equalTo(@49);
        self.bottomInputViewBotConstarint = make.bottom.equalTo(self);
    }];
}

- (void)sendRequest:(NSString *)urlStr para:(NSDictionary *)para {
    [YXNetWorking postUrlString:urlStr paramater:para success:^(id obj, NSURLResponse *response) {
        if ([urlStr isEqualToString:Save_Comment]) {
            
        }
        
    } fail:^(NSError *error, NSString *errorMessage) {
        NSLog(@"errorMessage：%@", errorMessage);
    }];
}

//收到键盘Frame发生改变的通知后执行
- (void)keyboardWillChangeFrame:(NSNotification *)noti {
    NSTimeInterval duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardFrame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (keyboardFrame.origin.y != [UIScreen mainScreen].bounds.size.height) {
        [UIView animateWithDuration:duration animations:^{
            self.bottomInputViewBotConstarint.offset = -keyboardFrame.size.height;
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            
        }];
    } else {
        [UIView animateWithDuration:duration animations:^{
            self.bottomInputViewBotConstarint.offset = 0;
            [self layoutIfNeeded];
        }];
    }
}

- (void)didTapCommentTableView {
    [self resignTextviewFirstResponder];
    [UIMenuController sharedMenuController].menuVisible = NO;
}

- (void)resignTextviewFirstResponder {
    if (self.bottomInputView.textView.isFirstResponder) {
        [self.bottomInputView.textView resignFirstResponder];
    }
}

#pragma mark BottomInputViewDelegate

- (void)bottomInputView:(YXBottomInputView *)bottomInputView sendMessage:(NSString *)message {
    
//    NSString *username = [NSString stringWithFormat:@"观众%d",arc4random_uniform(8)];
    NSString *username = [NSString stringWithFormat:@"观众%d",2];
    [self sendRequest:Save_Comment para:@{@"accessKey":AccessKey,@"lsId":self.streamId,@"userId":@"0002-sdk",@"username":username,@"avatar":@"http://scimg.jb51.net/allimg/160812/103-160Q2095G5220.jpg",@"content":message}];
  /*
   test
//    NSString *number = [NSString stringWithFormat:@"%ld",self.commentTableView.dataArr.count + 1];
//    NSTimeInterval time = [[[NSDate alloc] init] timeIntervalSince1970];
//    NSString *create = [NSString stringWithFormat:@"%.0f",time];
//    NSDictionary *dic = @{@"username":username,@"content":message,@"createdAt":create,@"floor":number};
//    
//    [self.commentTableView.dataArr insertObject:[YXCommentModel commentModelWithDic:dic] atIndex:0];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//
//    [self.commentTableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
//    [self.commentTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
   */
}
@end
