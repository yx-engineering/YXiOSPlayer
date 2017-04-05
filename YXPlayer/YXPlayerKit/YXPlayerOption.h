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
extern NSString * _Nonnull YXPlayerOptionKeyTimeoutIntervalForMediaPackets;

/**
 @abstract 一级缓存大小，单位为 ms，默认为 1000ms，增大该值可以减小播放过程中的卡顿率，但会增大弱网环境的最大累积延迟
 
 @discussion 该缓存存放的是网络层读取到的数据，为保证实时性，超过该缓存池大小的过期音频数据将被丢弃，视频将加速渲染追上音频
 
 @warning 该参数仅对 rtmp/flv 生效
 
 @since v2.1.3
 */
extern NSString * _Nonnull YXPlayerOptionKeyMaxL1BufferDuration;

/**
 @abstract 默认二级缓存大小，单位为 ms，默认为 1000ms，增大该值可以减小播放过程中的卡顿率，但会增大弱网环境的最大累积延迟
 
 @discussion 该缓存存放的是解码之后待渲染的数据，如果该缓存池满，则二级缓存将不再接收来自一级缓存的数据
 
 @warning 该参数仅对 rtmp/flv 生效
 
 @since v2.1.3
 */
extern NSString * _Nonnull YXPlayerOptionKeyMaxL2BufferDuration;

/**
 @abstract 是否使用 video toolbox 硬解码。
 
 @discussion 使用 video toolbox Player 将尝试硬解码，失败后，将切换回软解码。
 
 @waring 该参数仅对 rtmp/flv 生效, 默认不使用。支持 iOS 8.0 及更高版本。
 
 @since v2.1.4
 */
extern NSString * _Nonnull YXPlayerOptionKeyVideoToolbox;

/**
 @abstract 配置 log 级别
 
 @discussion release 建议使用 kPLLogWarning, debug 建议使用 kPLLogInfo.
 
 @waring 取值范围: PLLogLevel
 
 @since v2.2.1
 */
extern NSString * _Nonnull YXPlayerOptionKeyLogLevel;

/**
 @abstract 自定义 dns dnsmanager 查询，使用 HappyDNS
 
 @discussion 使用 HappyDNS 做 dns 解析，如果你期望自己配置 dns 解析的规则，可以通过传递自己定义的 dns manager 来做 dns 查询。
 如果你对 dns 解析部分不清楚，建议使用默认规则。
 
 @waring 值类型为 QNDnsManager，该参数仅对 rtmp/flv 直播生效
 
 @since v2.2.1
 */
extern NSString * _Nonnull YXPlayerOptionKeyDNSManager;

/**
@abstract 开启/关闭 HappyDNS 的 DNS 解析

@discussion 默认开启

@waring 该参数仅对 rtmp 与 flv 生效，值类型为 BOOL

@since v2.3.0
*/
extern NSString * _Nonnull YXPlayerOptionKeyHappyDNSEnable;

/**
 @abstract 点播使用 ffmpeg 还是 AVPlayer
 
 @discussion YES 表示使用 ffmpeg ，NO 表示使用 AVPlayer。默认为 NO。
 
 @waring 该参数仅对点播生效，值类型为 BOOL
 
 @since v2.3.0
 */
extern NSString * _Nonnull YXPlayerOptionKeyVODFFmpegEnable;

/**
 @abstract ffmpeg 播放前最大探测流的字节数，单位是 byte
 
 @discussion 默认值：直播 128 * 1024，点播 5*1024*1024
 
 @since v2.4.1
 */
extern NSString * _Nonnull YXPlayerOptionKeyProbeSize;

@interface YXPlayerOption : PLPlayerOption

@end
