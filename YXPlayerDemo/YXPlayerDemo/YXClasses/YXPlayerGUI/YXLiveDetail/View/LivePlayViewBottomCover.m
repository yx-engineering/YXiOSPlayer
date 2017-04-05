//
//  LivePlayViewBottomCover.m
//  YXPlayerDemo
//
//  Created by 丁彦鹏 on 2017/3/31.
//  Copyright © 2017年 YunXi. All rights reserved.
//  直播时显示

#import "LivePlayViewBottomCover.h"

@interface LivePlayViewBottomCover()
@property (nonatomic, weak) UILabel *watcherNumLab;
@property (nonatomic, weak) UIButton *fullScreenBtn;
@end

@implementation LivePlayViewBottomCover

- (instancetype)init {
    self = [super initWithFrame:CGRectMake(0, 0, 320, 44)];
    if (self) {
        
    }
    
    return self;
}

- (void)addSubviews {
    UIImageView *coverBottomBack = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"countdownbg"]];
    [self addSubview:coverBottomBack];
    
    UILabel *watcherNumLab = [[UILabel alloc] init];
    watcherNumLab.font = [UIFont systemFontOfSize:12];
    watcherNumLab.textAlignment = NSTextAlignmentLeft;
    [self addSubview:watcherNumLab];
    self.watcherNumLab = watcherNumLab;

    UIButton *fullScreenBtn = [[UIButton alloc] init];
    [fullScreenBtn setImage:[UIImage imageNamed:@"live_fullscreen_btn_normal"] forState:UIControlStateNormal];
    [fullScreenBtn setImage:[UIImage imageNamed:@"live_exitfullscreen_btn_normal"] forState:UIControlStateSelected];
    [fullScreenBtn addTarget:self action:@selector(didClickScreenBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:fullScreenBtn];
    self.fullScreenBtn = fullScreenBtn;
    
    [coverBottomBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)addConstarinsForSubviews {
    [self.watcherNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(15);
        make.width.equalTo(@280);
        make.height.equalTo(@20);
    }];
    
    [self.fullScreenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.watcherNumLab);
        make.right.equalTo(self).offset(-5);
        make.size.mas_equalTo(CGSizeMake(44, 44));

    }];
}

#pragma mark Setter
- (void)setWatcherNum:(int)watcherNum {
    _watcherNum = watcherNum <= 0 ? 1 : watcherNum;
    NSString *watcherNumText = @"";
    if (_watcherNum >= 100000) {
        watcherNumText = [[NSString alloc] initWithFormat:@"%.2f万人围观                                          ",((CGFloat)_watcherNum) / 1000];
    } else {
        watcherNumText = [[NSString alloc] initWithFormat:@"%d人围观",_watcherNum];
    }
    self.watcherNumLab.text = watcherNumText;
}

- (void)setFullScreenBtnSelected:(BOOL)fullScreenBtnIsSelected {
    self.fullScreenBtn.selected = fullScreenBtnIsSelected;
}

#pragma mark target
- (void)didClickScreenBtn:(UIButton *)sender {
    UIInterfaceOrientation interfaceOrientation = [UIApplication sharedApplication].statusBarOrientation;
    switch (interfaceOrientation) {
            //竖屏转横屏
        case UIInterfaceOrientationPortrait:
        case UIInterfaceOrientationPortraitUpsideDown:
            [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationLandscapeRight) forKey:@"orientation"];
            break;
            //横屏转竖屏
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
            [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationPortrait) forKey:@"orientation"];
            break;
        default:
            break;
    }
}

@end
