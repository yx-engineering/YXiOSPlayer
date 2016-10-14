//
//  YXModule.m
//  YXiOSPlayerTest
//
//  Created by 丁彦鹏 on 2016/9/27.
//  Copyright © 2016年 YunXi. All rights reserved.

#import "YXModule.h"

@implementation YXModule

+ (instancetype)moduleWithDic:(NSDictionary *)dic {
    YXModule *module = [[YXModule alloc] init];
    [module setValuesForKeysWithDictionary:dic];
    
    return module;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.moduleId = value;
    }
}

@end
