//
//  NSString+YXExtension.h
//  YXiOSPlayerTest
//
//  Created by 丁彦鹏 on 2016/10/14.
//  Copyright © 2016年 YunXi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YXExtension)
//NSString 本身是 timeIntervalSince1970 得到的秒数。
- (NSString *)formatTime;
@end
