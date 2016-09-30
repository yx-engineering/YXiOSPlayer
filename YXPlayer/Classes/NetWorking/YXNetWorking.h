//
//  NetWorking.h
//  YXiOSPlayerTest
//
//  Created by 丁彦鹏 on 16/9/12.
//  Copyright © 2016年 YunXi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXNetWorking : NSObject
// 定义两个 Block : 1. 成功Block回调 2.失败的 Block 回调!
// 定义 Block 的方式:
typedef void(^SuccessBlock)(id obj, NSURLResponse *response);
typedef void(^FailBlock)(NSError *error, NSString *errorMessage);

+ (void)getUrlString:(NSString *)urlString paramater:(NSDictionary *)paramater success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;

+ (void)postUrlString:(NSString *)urlString paramater:(NSDictionary *)paramater success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;
@end
