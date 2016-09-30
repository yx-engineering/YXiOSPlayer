//
//  YXNavigationController.m
//  YXiOSPlayerTest
//
//  Created by 丁彦鹏 on 16/9/21.
//  Copyright © 2016年 YunXi. All rights reserved.
//

#import "YXNavigationController.h"
#import "YXLiveDetailViewController.h"
@interface YXNavigationController ()

@end

@implementation YXNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (BOOL)shouldAutorotate {
    if ([self.visibleViewController isKindOfClass:[YXLiveDetailViewController class]]) {
        return YES;
    }
    return NO;
}


@end
