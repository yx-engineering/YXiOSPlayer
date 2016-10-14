//
//  UIImage+YXExtension.m
//  YXiOSPlayerTest
//
//  Created by 丁彦鹏 on 2016/10/10.
//  Copyright © 2016年 YunXi. All rights reserved.
//

#import "UIImage+YXExtension.h"

@implementation UIImage (YXExtension)
//用颜色创建图片
+ (UIImage *)imageWithColor:(UIColor *)color Size:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [color setFill];
    CGContextAddRect(context, CGRectMake(0, 0, size.width, size.height));
    CGContextFillPath(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//截取圆形图片
- (UIImage *)cutCircleImage {
    UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0);
    CGContextRef ctr = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctr, rect);
    CGContextClip(ctr);
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
