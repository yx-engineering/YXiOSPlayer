//
//  NSTimer+YXExtension.m
//  YXiOSPlayerTest
//
//  Created by 丁彦鹏 on 2016/10/14.
//  Copyright © 2016年 YunXi. All rights reserved.
//

#import "NSTimer+YXExtension.h"

@implementation NSTimer (YXExtension)
+ (NSTimer *) yx_ScheduledTimerWithTimeInterval:(NSTimeInterval)time block:(TimerBlcok)block repeats:(BOOL)repeats {
    return [self scheduledTimerWithTimeInterval:time target:self selector:@selector(excuteTimerBlock:) userInfo:block repeats:repeats];
}

+ (void) excuteTimerBlock:(NSTimer *)timer {
    TimerBlcok block = (TimerBlcok)timer.userInfo;
    block();
}
@end
