//
//  YXCommentModel.h
//  YXiOSPlayerTest
//
//  Created by 丁彦鹏 on 16/9/18.
//  Copyright © 2016年 YunXi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXCommentModel : NSObject
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *avatar; //头像
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *floor;
+ (instancetype)commentModelWithDic:(NSDictionary *)dic;
@end
