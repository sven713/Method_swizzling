//
//  ViewController.m
//  Method_swizzling_runtime方法欺骗
//
//  Created by sve on 2018/6/12.
//  Copyright © 2018年 sve. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:@"http:baidu.com/哈哈"]; // 不能带中文,系统方法缺陷
    
    NSLog(@"url:-%@",url);
}



@end
