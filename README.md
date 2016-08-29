
# YXPlayerKit

YXPlayerKit 是一个基于 PLPlayerKit 适用于 iOS 的音视频播放器 SDK，可高度定制化和二次开发，特色是支持 RTMP 和 HLS 直播流媒体播放。


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
- [关于 2.0 版本](#关于2.0版本)
- [版本历史](#版本历史)

## 快速开始

### 配置工程
- 将 YXPlayerKit的 .h 和 .a 文件拖到工程中

- 配置你的 Podfile 文件，添加如下配置信息

```
pod 'PLPlayerKit'
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
#import "YXPlayer.h"
```

初始化 PLPlayerOption

```Objective-C
// 初始化 PLPlayerOption 对象
PLPlayerOption *option = [PLPlayerOption defaultOption];

// 更改需要修改的 option 属性键所对应的值
[option setOptionValue:@15 forKey:PLPlayerOptionKeyTimeoutIntervalForMediaPackets];

```

初始化 PLPlayer

```Objective-C
// 初始化 PLPlayer
self.player = [YXPlayer playerWithURL:self.URL option:option];

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

播放器状态获取

```Objective-C
// 实现 <PLPlayerDelegate> 来控制流状态的变更
- (void)player:(nonnull PLPlayer *)player statusDidChange:(PLPlayerStatus)state {
	// 这里会返回流的各种状态，你可以根据状态做 UI 定制及各类其他业务操作
	// 除了 Error 状态，其他状态都会回调这个方法
}

- (void)player:(nonnull PLPlayer *)player stoppedWithError:(nullable NSError *)error {
	// 当发生错误时，会回调这个方法
}
```

## 音频部分的特别说明

因为 iOS 的音频资源被设计为单例资源，所以如果在 player 中做的任何修改，对外都可能造成影响，并且带来不能预估的各种问题。

为了应对这一情况，PLPlayerKit 采取的方式是检查是否可以播放及是否可以进入后台，而在内部不做任何设置。具体是通过扩展 `AVAudioSession` 来做到的，提供了两个方法，如下：

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
