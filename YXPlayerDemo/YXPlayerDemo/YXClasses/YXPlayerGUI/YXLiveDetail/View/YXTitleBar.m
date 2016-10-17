//
//  YXTitleBar.m
//  YXiOSPlayerTest
//
//  Created by 丁彦鹏 on 16/9/14.
//  Copyright © 2016年 YunXi. All rights reserved.
//

#import "YXTitleBar.h"

@interface YXTitleBar ()
@property (nonatomic, strong) NSMutableArray *btns; //标题按钮数组
@property (nonatomic, assign) CGFloat btnw;         //标题按钮宽
@property (nonatomic, assign) CGFloat titleH;       //标题按钮高度
@property (nonatomic, assign) CGFloat detailViewH;  //标题下面要显示的View的高度
@property (nonatomic, weak) UIView *line;           //线条
@property (nonatomic, weak) UIButton *currentBtn; //当前被选中的按钮
@property (nonatomic, weak) UIView *currentShowView; //当前选中的标题对应的View
@property (nonatomic, strong) NSArray *detailViews; //标题下面要显示的View数组
@end


@implementation YXTitleBar

/*
 titleArray: 标题字符数组，如：@[@"登录",@"注册"]
 frame: titleBar的frame = 标题.frame + currentShowView.frame
 */
+ (instancetype)titleBarWithTitleArray:(NSArray *)titleArray Frame:(CGRect)frame  titleH:(CGFloat)titleH showDetaiViews:(NSArray<UIView *> *)detailViews {
    YXTitleBar *titleBar = [[self alloc] initWithFrame:frame];
    titleBar.titleH = titleH;
    titleBar.detailViewH = frame.size.height - titleH;
    [titleBar addSubviewsWithTitleArray:titleArray detailViews:detailViews];
    titleBar.detailViews = detailViews;
    return titleBar;
}

- (void)addSubviewsWithTitleArray:(NSArray *)titleArray detailViews:(NSArray *) detailViews{
    
    for (NSInteger i=0; i< titleArray.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(clickTilteBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i + 1;
        [self addSubview:btn];
        [self.btns addObject:btn];
    }
    if (titleArray.count == 1) {
        self.currentBtn = self.btns[0];
        [self.currentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    //线条
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor blueColor];
    [self addSubview:line];
    self.line = line;
    //详情
    self.currentShowView = detailViews.firstObject;
    [self addSubview:self.currentShowView];
}

- (void)setBtnsBackColor:(UIColor *)btnsBackColor {
    for (UIButton *btn in self.btns) {
        btn.backgroundColor = btnsBackColor;
    }
}

//点击按钮
- (void)clickTilteBtn:(UIButton *)sender {
    if (self.currentBtn == sender) {
        return ;
    }
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = self.line.frame;
        rect.origin.x = (sender.tag - 1) * sender.frame.size.width;
        self.line.frame = rect;
        [self.currentBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    } completion:^(BOOL finished) {
        self.currentBtn = sender;
        UIView *currentShowView = self.detailViews[sender.tag - 1];
        currentShowView.frame = self.currentShowView.frame;
        [self.currentShowView removeFromSuperview];
        [self addSubview:currentShowView];
        self.currentShowView = currentShowView;
    }];
}

- (NSMutableArray *)btns {
    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat btnW = self.frame.size.width / self.btns.count;
    self.btnw = btnW;
    CGFloat btnH = self.titleH;
    CGFloat btnY = 0;
    for (NSInteger i=0; i<self.btns.count; i++) {
        CGFloat btnX = btnW * i;
        UIButton *btn = self.btns[i];
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    self.currentShowView.frame = CGRectMake(0, btnH, self.frame.size.width, self.frame.size.height - btnH);
    if (self.line.frame.origin.x == 0) {
        CGFloat lineH = self.titleH == 0 ? 0 : 1;
        self.line.frame = CGRectMake(0, btnH - 1, btnW, lineH);
    }
}

@end
