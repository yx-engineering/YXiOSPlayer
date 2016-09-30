//
//  YXWebView.m
//  YXiOSPlayerTest
//
//  Created by 丁彦鹏 on 2016/9/28.
//  Copyright © 2016年 YunXi. All rights reserved.
//

#import "YXWebView.h"

@interface YXWebView ()<UIWebViewDelegate>
@property (nonatomic, weak) UIButton *backBtn;
@property (nonatomic, assign) bool start;
@end

@implementation YXWebView

- (instancetype)init {
    self = [super init];
    self.delegate = self;
    self.start = true;
    [self addSubviews];
    return self;
}

- (void)addSubviews {
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    backBtn.hidden = true;
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [backBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backBtn];
    self.backBtn = backBtn;
    
}

- (void)setContent:(NSString *)content {
    
    
    NSString *base = @"<!DOCTYPE html><html><head><meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no\" /></head><body><div style=\"padding: 16px;\">$editorValue</div></body></html>";
    _content = [base stringByReplacingOccurrencesOfString:@"$editorValue" withString:content];
    [self loadHTMLString:_content baseURL:nil];
}

- (void)back {
    if (self.canGoBack) {
        [self goBack];
    } else {
        [self loadHTMLString:_content baseURL:nil];
        self.backBtn.hidden = true;
        self.start = true;
    }
}


#pragma mark webViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if(navigationType==UIWebViewNavigationTypeLinkClicked)//判断是否是点击链接
    {
        self.start = false;
    }
    return true;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if (!self.start) {
        self.backBtn.hidden = false;
    }
}

@end
