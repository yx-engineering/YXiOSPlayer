//
//  BottomInputView.m
//  YXiOSPlayerTest
//
//  Created by 丁彦鹏 on 16/9/12.
//  Copyright © 2016年 YunXi. All rights reserved.
//

#import "YXBottomInputView.h"

@interface YXBottomInputView ()<UITextViewDelegate>
@property (nonatomic, weak) UILabel *placeHolderLab;
//@property (nonatomic, weak) UIButton *giftBtn;
@end

@implementation YXBottomInputView

- (instancetype)init {
    self = [super initWithFrame:CGRectMake(0, 0, 100, 100)];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubviews];
        [self addConstarinsForSubviews];
    }
    return self;
}

- (void)addSubviews {
    UITextView *textView = [[UITextView alloc] init];
    textView.font = [UIFont systemFontOfSize:16];
    textView.delegate = self;
    textView.returnKeyType = UIReturnKeySend;
    textView.contentInset = UIEdgeInsetsMake(6, -1, 0, 0);
    [self addSubview:textView];
    self.textView = textView;
    
    UILabel *placeHolderLab = [[UILabel alloc] init];
    placeHolderLab.text = @" 输入评论内容";
    placeHolderLab.textColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
    placeHolderLab.font = [UIFont systemFontOfSize:16];
    [self addSubview:placeHolderLab];
    self.placeHolderLab = placeHolderLab;

//    UIButton *giftBtn = [[UIButton alloc] init];
//    [giftBtn setImage:[UIImage imageNamed:@"live_gift_btn_normal"] forState:UIControlStateNormal];
//    [giftBtn setImage:[UIImage imageNamed:@"live_gift_btn_highlighted"] forState:UIControlStateHighlighted];
//    [self addSubview:giftBtn];
//    self.giftBtn = giftBtn;

}

- (void)addConstarinsForSubviews {
    [self.textView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(1);
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.bottom.equalTo(self);
    }];
    
    [self.placeHolderLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.textView);
    }];
    
//    [self.giftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self).offset(-15);
//        make.centerY.equalTo(self);
//        make.size.mas_equalTo(CGSizeMake(22, 22));
//    }];
    
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0.5);
    CGContextSetRGBStrokeColor(context, 0.8, 0.8, 0.8, 1);
    CGContextMoveToPoint(context, 0, 0.25);
    CGContextAddLineToPoint(context, self.frame.size.width, 0.25);
    CGContextStrokePath(context);
}


#pragma makr textViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text  isEqual: @"\n"]) {
        if (self.delegate != nil && textView.text.length > 0) {
            [self.delegate bottomInputView:self sendMessage:textView.text];
            self.textView.text = @"";
            [self.textView resignFirstResponder];
            self.placeHolderLab.hidden = false;
        }
        return false;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    self.placeHolderLab.hidden = textView.text.length != 0;
}

@end
