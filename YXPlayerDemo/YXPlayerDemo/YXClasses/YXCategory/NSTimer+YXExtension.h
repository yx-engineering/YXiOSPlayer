//
//  NSTimer+YXExtension.h
//  YXiOSPlayerTest
//
//  Created by 丁彦鹏 on 2016/10/14.
//  Copyright © 2016年 YunXi. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^TimerBlcok)();
@interface NSTimer (YXExtension)
+ (NSTimer *) yx_ScheduledTimerWithTimeInterval:(NSTimeInterval)time block:(TimerBlcok)block repeats:(BOOL)repeats;
@end
