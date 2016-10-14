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
+ (UIImage *)imageWithColor:(UIColor *)color Size:(CGSize)size;

//截取圆形图片
- (UIImage *)cutCircleImage;
@end
