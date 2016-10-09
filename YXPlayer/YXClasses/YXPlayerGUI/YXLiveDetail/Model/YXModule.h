//
//  YXModule.h
//  YXiOSPlayerTest
//
//  Created by 丁彦鹏 on 2016/9/27.
//  Copyright © 2016年 YunXi. All rights reserved.
//
// 模块

#import <Foundation/Foundation.h>

@interface YXModule : NSObject
@property (nonatomic, copy) NSString *moduleId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *hasText;
@property (nonatomic, copy) NSString *editorValue;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *active;

+ (instancetype)moduleWithDic:(NSDictionary *)dic;

@end
