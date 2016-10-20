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
+ (UIImage *)yx_imageWithColor:(UIColor *)color Size:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [color setFill];
    CGContextAddRect(context, CGRectMake(0, 0, size.width, size.height));
    CGContextFillPath(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//带圆圈的圆形图片
+ (UIImage *)yx_circleImageWithFillColor:(UIColor *)fillColor strokeColor:(UIColor *)strokeColor radius:(CGFloat)radius {
    //图片画好以后，为了提升像素密度，会将图片缩小一倍。所以需要的尺寸是：radius * 4
    CGFloat pixRadius = radius * 2; //像素尺寸
    UIGraphicsBeginImageContext(CGSizeMake(pixRadius * 2, pixRadius * 2));
    CGContextRef context = UIGraphicsGetCurrentContext();
    [fillColor setFill];
    CGFloat lineWith = 1 * 2;
    CGContextAddArc(context, pixRadius, pixRadius, pixRadius - lineWith, 0, M_PI * 2, 1);
    CGContextFillPath(context);
    
    [strokeColor setStroke];
    CGContextSetLineWidth(context, lineWith);
    CGContextAddArc(context, pixRadius, pixRadius, pixRadius - lineWith / 2, 0, M_PI * 2, 1);
    CGContextStrokePath(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [[UIImage alloc] initWithCGImage:image.CGImage scale:2 orientation:UIImageOrientationUp];
}


//截取圆形图片
- (UIImage *)yx_cutCircleImage {
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
