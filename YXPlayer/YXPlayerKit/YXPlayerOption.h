//
//  YXPlayerOption.h
//  YXPlayer
//
//  Created by 丁彦鹏 on 16/8/29.
//  Copyright © 2016年 YunXi. All rights reserved.
//

#import "PLPlayerOption.h"
/**
 @abstract 接收/发送数据包超时时间间隔所对应的键值，单位为 s ，默认配置为 10s
 
 @warning 建议设置正数。设置的值小于等于 0 时，表示禁用超时，播放卡住时，将无超时回调。
 
 @since v1.0.0
 */
extern NSString * const YXPlayerOptionKeyTimeoutIntervalForMediaPackets;

/**
 @abstract 一级缓存大小，单位为 ms，默认为 1000ms，增大该值可以减小播放过程中的卡顿率，但会增大弱网环境的最大累积延迟
 
 @discussion 该缓存存放的是网络层读取到的数据，为保证实时性，超过该缓存池大小的过期音频数据将被丢弃，视频将加速渲染追上音频
 
 @warning 该参数仅对 rtmp 生效
 
 @since v2.1.3
 */
extern NSString * const YXPlayerOptionKeyMaxL1BufferDuration;

/**
 @abstract 默认二级缓存大小，单位为 ms，默认为 1000ms，增大该值可以减小播放过程中的卡顿率，但会增大弱网环境的最大累积延迟
 
 @discussion 该缓存存放的是解码之后待渲染的数据，如果该缓存池满，则二级缓存将不再接收来自一级缓存的数据
 
 @warning 该参数仅对 rtmp 生效
 
 @since v2.1.3
 */
extern NSString * const YXPlayerOptionKeyMaxL2BufferDuration;

/**
 @abstract 是否使用 video toolbox 硬解码。
 
 @discussion 使用 video toolbox Player 将尝试硬解码，失败后，将切换回软解码。
 
 @waring 该参数仅对 rtmp 生效, 默认不使用。支持 iOS 8.0 及更高版本。
 
 @since v2.1.4
 */
extern NSString * const YXPlayerOptionKeyVideoToolbox;

/**
 @abstract 配置 log 级别
 
 @discussion release 建议使用 kPLLogWarning, debug 建议使用 kPLLogInfo.
 
 @waring 取值范围: PLLogLevel
 
 @since v2.2.1
 */
extern NSString * const YXPlayerOptionKeyLogLevel;

/**
 @abstract 自定义 dns dnsmanager 查询，使用 HappyDNS
 
 @discussion 使用 HappyDNS 做 dns 解析，如果你期望自己配置 dns 解析的规则，可以通过传递自己定义的 dns manager 来做 dns 查询。
 如果你对 dns 解析部分不清楚，建议使用默认规则。
 
 @waring 值类型为 QNDnsManager
 
 @since v2.2.1
 */
extern NSString * const YXPlayerOptionKeyDNSManager;
@interface YXPlayerOption : PLPlayerOption

@end
