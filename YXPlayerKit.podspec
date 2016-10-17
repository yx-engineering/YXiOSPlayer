#
#  Be sure to run `pod spec lint YXPlayerKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "YXPlayerKit"
  s.author       = { "ding" => "dingyp@yunxi.tv" }
  s.version      = "1.0.4"
  s.license  = "MIT"
  s.summary = "iOS video player SDK, RTMP, HLS video streaming supported." 
  s.homepage = 'https://github.com/yx-engineering/YXiOSPlayer.git'
  s.source   = { :git => "https://github.com/yx-engineering/YXiOSPlayer.git", :tag => s.version } 
  s.platform     = :ios, '8.0'
  s.requires_arc = true 
  s.source_files = 'YXPlayer/YXPlayerKit/*.h'
  s.vendored_libraries   = 'YXPlayer/lib/*.a'
  s.dependency "PLPlayerKit" ,"2.2.4"
  
end
