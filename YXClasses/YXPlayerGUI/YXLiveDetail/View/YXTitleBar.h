//
//  YXTitleBar.h
//  YXiOSPlayerTest
//
//  Created by 丁彦鹏 on 16/9/14.
//  Copyright © 2016年 YunXi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXTitleBar : UIView
+ (instancetype)titleBarWithTitleArray:(NSArray *)titleArray Frame:(CGRect)frame  titleH:(CGFloat)titleH showDetaiViews:(NSArray<UIView *> *)detailViews;
@property (nonatomic, strong) UIColor *btnsBackColor;
@end
