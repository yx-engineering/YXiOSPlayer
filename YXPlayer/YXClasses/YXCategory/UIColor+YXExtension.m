//
//  UIColor+YXExtension.m
//  YXiOSPlayerTest
//
//  Created by 丁彦鹏 on 2016/9/27.
//  Copyright © 2016年 YunXi. All rights reserved.
//

#import "UIColor+YXExtension.h"

@implementation UIColor (YXExtension)
+ (UIColor *)hexColor:(unsigned long)hex {
    CGFloat r = ((hex & 0xFF0000) >> 16) / 255.0;
    CGFloat g = ((hex & 0xFF00) >> 8) / 255.0;
    CGFloat b = (hex & 0xFF) / 255.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}
@end
