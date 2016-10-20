//
//  UIImage+YXExtension.h
//  YXiOSPlayerTest
//
//  Created by 丁彦鹏 on 2016/10/10.
//  Copyright © 2016年 YunXi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YXExtension)
//用颜色创建图片
+ (UIImage *)yx_imageWithColor:(UIColor *)color Size:(CGSize)size;
//带圆圈的圆形图片
+ (UIImage *)yx_circleImageWithFillColor:(UIColor *)fillColor strokeColor:(UIColor *)strokeColor radius:(CGFloat)radius;
//截取圆形图片
- (UIImage *)yx_cutCircleImage;
@end
