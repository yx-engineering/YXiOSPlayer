//
//  YXEnterViewController.m
//  YXiOSPlayerTest
//
//  Created by 丁彦鹏 on 16/9/12.
//  Copyright © 2016年 YunXi. All rights reserved.
//

#import "YXEnterViewController.h"
#import "YXLiveViewController.h"
#import "YXLiveListViewController.h"

@interface YXEnterViewController ()

@end

@implementation YXEnterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    
    UIButton *btn1 = [[UIButton alloc] init];
    btn1.tag = 1;
    btn1.backgroundColor = [UIColor orangeColor];
    [btn1 setTitle:@"YXPlayer简单的Demo" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn2 = [[UIButton alloc] init];
    btn2.tag = 2;
    btn2.backgroundColor = [UIColor orangeColor];
    [btn2 setTitle:@"直播列表" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn1];
    [self.view addSubview:btn2];
    
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(150);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(180, 50));
    }];
    
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn1.mas_bottom).offset(50);
        make.centerX.equalTo(btn1);
        make.size.equalTo(btn1);
    }];
}

- (void)didClickBtn:(UIButton *)sender {
    UIViewController *vc;
    if (sender.tag == 1) {
        vc = [[YXLiveViewController alloc] init];
    } else {
        vc = [[YXLiveListViewController alloc] init];
    }
     [self.navigationController pushViewController:vc animated:true];
}


@end
