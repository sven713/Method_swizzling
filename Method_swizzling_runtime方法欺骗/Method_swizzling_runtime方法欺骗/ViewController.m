//
//  ViewController.m
//  Method_swizzling_runtime方法欺骗
//
//  Created by sve on 2018/6/12.
//  Copyright © 2018年 sve. All rights reserved.
//

#import "ViewController.h"
#import "UIControl+ActionTimeInterval.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:@"http:baidu.com/哈哈"]; // 不能带中文,系统方法缺陷
    
    NSLog(@"url:-%@",url);
    
    [self setUI];
}

- (void)setUI {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor orangeColor];
    [btn addTarget:self action:@selector(btnClickAction) forControlEvents:UIControlEventTouchUpInside];
    btn.actionTimeInterval = 2;
}

- (void)btnClickAction {
    NSLog(@"点击了按钮");
}

@end
