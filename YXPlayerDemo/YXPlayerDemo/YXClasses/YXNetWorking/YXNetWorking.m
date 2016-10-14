//
//  NetWorking.m
//  YXiOSPlayerTest
//
//  Created by 丁彦鹏 on 16/9/12.
//  Copyright © 2016年 YunXi. All rights reserved.
//

#import "YXNetWorking.h"
#import <CommonCrypto/CommonDigest.h>

#import "YXGlobalDefine.h"

@interface NSArray (extension)
//根据字符串的首字母字典序升序排列(当元素都是字符串时使用，首字母相同，比较第二个...)
- (NSArray *)sortArrByCharacterAsc;
@end

@implementation NSArray (Action)
- (NSArray *)sortArrByCharacterAsc {
    NSMutableArray *arr = [NSMutableArray arrayWithArray:self];
    NSInteger index = 0;
    for (int i = 0; i < arr.count-1; ++i) {
        for (int j = i+1; j < arr.count; ++j) {
            if (index >= [arr[i] length]) {
                index = 0;
                continue;
            } else if (index >= [arr[j] length]) {
                [arr exchangeObjectAtIndex:i withObjectAtIndex:j];
                index = 0;
                continue;
            }
            char ci = [arr[i] characterAtIndex:index];
            char cj = [arr[j] characterAtIndex:index];
            if (ci > cj) {
                [arr exchangeObjectAtIndex:i withObjectAtIndex:j];
                index = 0;
            } else if (ci == cj) {
                j--;
                index++;
            } else if (ci < cj) {
                index = 0;
            }
        }
    }
    return arr;
}
@end


@interface NSString (MD5str)
- (NSString *)stringFromMD5;
@end

@implementation NSString (MD5str)
- (NSString *)stringFromMD5{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result);
    NSString *strMD5 =  [NSString stringWithFormat:
                         @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                         result[0], result[1], result[2], result[3],
                         result[4], result[5], result[6], result[7],
                         result[8], result[9], result[10], result[11],
                         result[12], result[13], result[14], result[15]
                         ];
    return strMD5;
}
@end



@implementation YXNetWorking
+ (void)getUrlString:(NSString *)urlString paramater:(NSDictionary *)paramater success:(SuccessBlock)successBlock fail:(FailBlock)failBlock {
    NSMutableString *paraStr = [NSMutableString string];
    [paramater enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSString *nameKey = key;
        NSString *nameValue = obj;
        [paraStr appendFormat:@"%@=%@&",nameKey, nameValue];
        
    }];
    
    urlString = [NSString stringWithFormat:@"%@?%@",urlString,[paraStr substringToIndex:paraStr.length - 1]];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlString];
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        id obj = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        if (obj && !error) {
            if ([obj isKindOfClass:[NSDictionary class]]) {
                int statusCode = [obj[@"statusCode"] intValue];
                if (statusCode != 200) {
                    NSString *errorMessage = obj[@"msg"];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (errorMessage.length != 0) {
                            [self showMessage:errorMessage];
                        } else {
                            [self showMessage:@"未知原因"];
                        }
                        if (failBlock) {
                            failBlock(error,errorMessage);
                        }
                    });
                    return ;
                }
            }
            if (successBlock) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    successBlock(obj,response);
                });
            }
        }
        else {
            if (failBlock) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    failBlock(error,@"没有获取到数据");
                    [self showMessage:@"没有获取到数据"];
                });
            }
        }
    }] resume];
}

+ (void)postUrlString:(NSString *)urlString paramater:(NSDictionary *)paramater success:(SuccessBlock)successBlock fail:(FailBlock)failBlock
{
    urlString = [NSString stringWithFormat:@"%@%@",YunXiService,urlString];
    
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    // 1.创建请求 (POST请求)
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    // 设置请求方法:
    request.HTTPMethod = @"POST";
    //添加时间戳
    NSMutableDictionary *mutalPara = [[NSMutableDictionary alloc] initWithDictionary:paramater];
    NSString *time =[NSString stringWithFormat:@"%.0f",[[NSDate alloc] init].timeIntervalSince1970];
    mutalPara[@"timestamp"] = time;
    //获取签名
    NSString *sign = [self getSignatureWithParaDic:mutalPara];
    //将签名加到参数中
    mutalPara[@"sign"] = sign;
    NSLog(@"云犀URL: %@",urlString);
    NSLog(@"云犀最终参数：%@", mutalPara);
    NSMutableString *strM = [NSMutableString string];
    NSString *newStrM = @"";
    if (mutalPara.allKeys.count != 0) {
        [mutalPara enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            NSString *nameKey = key;
            NSString *nameValue = obj;
            [strM appendString:[NSString stringWithFormat:@"%@=%@&",nameKey,nameValue]];
        }];
        // 处理字符串,去掉最后一个字符!
        newStrM = [strM substringToIndex:(strM.length - 1)];
    }
    // 设置请求体:
    request.HTTPBody = [newStrM dataUsingEncoding:NSUTF8StringEncoding];
    // 2. 发送请求
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        id obj;
        if (data != nil) {
            obj = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        }
        if (obj && !error) {
            if ([obj isKindOfClass:[NSDictionary class]]) {
                int statusCode = [obj[@"statusCode"] intValue];
                if (statusCode != 200) {
                    NSString *errorMessage = obj[@"msg"];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"错误码：%d",statusCode);
                        if (errorMessage.length != 0) {
                            [self showMessage:errorMessage];
                        } else {
                            [self showMessage:@"未知原因"];
                        }
                        if (failBlock) {
                            failBlock(error,errorMessage);
                        }
                    });
                    return ;
                }
            }
            if (successBlock) {
                NSLog(@"response: %@",obj);
                dispatch_async(dispatch_get_main_queue(), ^{
                    successBlock(obj,response);
                });
            }
        }
        else {
            if (failBlock) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    failBlock(error,@"没有获取到数据");
                    [self showMessage:@"没有获取到数据"];
                });
            }
        }
    }] resume];
}


+ (void)showMessage:(NSString*)message {
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    lab.layer.cornerRadius = 5;
    lab.layer.masksToBounds = YES;
    lab.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    lab.text = message;
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor = [UIColor whiteColor];
    lab.numberOfLines = 0;
    lab.center = [UIApplication sharedApplication].keyWindow.center;
    [[UIApplication sharedApplication].keyWindow addSubview:lab];
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 1.5 * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [lab removeFromSuperview];
    });
}

+ (NSString *)getSignatureWithParaDic:(NSDictionary *)paraDic {
    NSMutableString *str = [NSMutableString string];
    //字典序升序排列
    NSMutableArray *sortArr = [NSMutableArray arrayWithArray:[paraDic.allKeys sortArrByCharacterAsc]];
    for (NSString *key in sortArr) {
        [str appendString:[NSString stringWithFormat:@"%@=%@&",key,paraDic[key]]];
    }
    
    [str appendString:[NSString stringWithFormat:@"secretKey=%@",YXSecretKey]];
    return [str stringFromMD5].uppercaseString;
}



@end
