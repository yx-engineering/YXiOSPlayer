
# YXPlayerKit

YXPlayerKit 是一个适用于 “iOS 8.0” 以上的音视频播放器 SDK，可高度定制化和二次开发，特色是支持 RTMP 和 HLS 直播流媒体播放。


功能特性

- [x] RTMP 直播流播放
- [x] HLS 播放
- [x] 高可定制
- [x] 音频后台播放
- [x] RTMP 直播首屏秒开支持
- [x] RTMP 直播累积延迟消除技术


## 内容摘要

- [快速开始](#1-快速开始)
      - [配置工程](#配置工程)
      - [示例代码](#示例代码)
      - [云犀直播界面](#云犀直播界面)

## 快速开始

### 配置工程

- 配置你的 Podfile 文件，添加如下配置信息

```
pod 'YXPlayerKit'
```

- 安装 CocoaPods 依赖

```
pod update
```
or
```
pod install
```

- Done! 运行你工程的 workspace

### 示例代码

在需要的地方添加

```Objective-C
#import "YXPlayerKit.h"
```

初始化 YXPlayerOption

```Objective-C
// 初始化 YXPlayerOption 对象
YXPlayerOption *option = [YXPlayerOption defaultOption];

// 更改需要修改的 option 属性键所对应的值
[option setOptionValue:@15 forKey:YXPlayerOptionKeyTimeoutIntervalForMediaPackets];
[option setOptionValue:@1000 forKey:YXPlayerOptionKeyMaxL1BufferDuration];
[option setOptionValue:@1000 forKey:YXPlayerOptionKeyMaxL2BufferDuration];
[option setOptionValue:@(YES) forKey:YXPlayerOptionKeyVideoToolbox];
[option setOptionValue:@(kPLLogInfo) forKey:YXPlayerOptionKeyLogLevel];
[option setOptionValue:[QNDnsManager new] forKey:YXPlayerOptionKeyDNSManager];

```
初始化 YXPlayer

```Objective-C
// 初始化 YXPlayer
//回放时使用此接口
self.player = [YXPlayer playerWithURL:self.URL option:option];
//直播使用此接口
self.player = [YXPlayer playerLiveWithURL:self.URL option:option];
// 设定企业APPId (必须) 
self.player.yxAppId = @"企业APPId";
// 设定直播Id (必须)
self.player.yxStreamId = @"直播Id";

// 设定代理 (optional)
self.player.delegate = self;
```

获取播放器的视频输出的 UIView 对象并添加为到当前 UIView 对象的 Subview
```Objective-C
//获取视频输出视图并添加为到当前 UIView 对象的 Subview
[self.view addSubview:player.playerView];
```

开始／暂停操作

```Objective-C
// 播放
[self.player play];

// 停止
[self.player stop];

// 暂停
[self.player pause];

// 继续播放
[self.player resume];
```
视频时长/视频节点

```Objective-C
//回放时获取视频总时长(单位：秒)，当播放器初始化后，播放状态可以切换到 PLPlayerStatusPlaying 后才可以获取到self.player.totalDuration
float totoalTime = self.player.totalDuration / self.player.totalDuration.timescale
//回放时获取视频当前时间节点(单位：秒)
float currentTime = self.player.currentTime / self.player.currentTime.timescale
//回放时跳到指定视频节点
float secondTime = 600; //单位：秒
CMTime time = CMTimeMake(secondTime, 1);
[self.player seekTo:time];
```

播放器状态获取

```Objective-C
// 实现 <PLPlayerDelegate> 来控制流状态的变更
- (void)player:(nonnull PLPlayer *)player statusDidChange:(PLPlayerStatus)state {
// 这里会返回流的各种状态，你可以根据状态做 UI 定制及各类其他业务操作
// 除了 Error 状态，其他状态都会回调这个方法
  switch (state) {
            case PLPlayerStatusPlaying:
            //重复获取视频总时长时，视频总时长可能会有波动，所以最好判断一下以保证只获取一次
            if (self.totoalTime == 0) {
           self.totoalTime = player.totalDuration.value / player.totalDuration.timescale
        }
            break;
        default:
            
            break;
    }
}

- (void)player:(nonnull PLPlayer *)player stoppedWithError:(nullable NSError *)error {
// 当发生错误时，会回调这个方法
}
```


### 云犀直播界面

```
YXPlayerKit 只具备播放等一系列功能，如果需要使用云犀默认的直播列表界面，以及播放界面，
请到 "https://github.com/yx-engineering/YXiOSPlayer.git" 自行下载。然后将 YXClasses 拖入到自己的工程中。
然后找到"YXClasses/YXSource/YXGlobalDefine.h"文件（可通过搜索 “//YXTODO:”，快速找到对应的位置，进行内容填写），
该文件中有三个空字符串的宏定义 YXBusinessAppId、YXAccessKey、YXSecretKey，将自己企业对应的 AppID、AccessKey、SecretKey
填写进去。再到 "YXClasses/YXPlayerGUI/YXLiveDetail/View/YXCommentView.m”文件中的
- (void)bottomInputView:(YXBottomInputView *)bottomInputView sendMessage:(NSString *)message { 

}
方法中，填写当前用户的 username、userId、avatar （可提前用一个单例将这三个字段的值进行存储 或使用 NSUserDefaults
进行存储，这样就可以在这里直接获取到了）。

```

## 音频部分的特别说明

因为 iOS 的音频资源被设计为单例资源，所以如果在 player 中做的任何修改，对外都可能造成影响，并且带来不能预估的各种问题。

为了应对这一情况，YXPlayerKit 采取的方式是检查是否可以播放及是否可以进入后台，而在内部不做任何设置。具体是通过扩展 `AVAudioSession` 来做到的，提供了两个方法，如下：

```Objective-C
/*!
* @description 检查当前 AVAudioSession 的 category 配置是否可以播放音频. 当为 AVAudioSessionCategoryAmbient,
* AVAudioSessionCategorySoloAmbient, AVAudioSessionCategoryPlayback, AVAudioSessionCategoryPlayAndRecord
* 中的一种时为 YES, 否则为 NO.
*/
+ (BOOL)isPlayable;

/*!
* @description 检查当前 AVAudioSession 的 category 配置是否可以后台播放. 当为 AVAudioSessionCategoryPlayback,
* AVAudioSessionCategoryPlayAndRecord 中的一种时为 YES, 否则为 NO.
*/
+ (BOOL)canPlayInBackground;
```

分辨可以检查是否可以播放以及当前 category 的设置是否可以后台播放。


