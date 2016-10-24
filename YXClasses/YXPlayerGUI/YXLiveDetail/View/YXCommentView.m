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
    //初始化，frame不为 CGRectZero，就不会报约束冲突了
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
        if ([urlStr isEqualToString:YXSave_Comment]) {
            
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
    //当按下回车，发送评论的时候，会执行该代理方法。
    //YXTODO:在这里传入用户名，用户ID，用户头像
    NSString *username = @"";
    NSString *userId = @"";//用户ID后添加“-sdk”，如：@"0001-sdk"
    NSString *avatar = @"";//用户头像图片地址
    [self sendRequest:YXSave_Comment
                 para:@{
                        @"lsId":self.streamId,
                        @"userId":userId,
                        @"username":username,
                        @"avatar":avatar,
                        @"content":message}];
}
@end
