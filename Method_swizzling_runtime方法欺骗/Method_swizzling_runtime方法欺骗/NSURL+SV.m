//
//  NSURL+SV.m
//  Method_swizzling_runtime方法欺骗
//
//  Created by sve on 2018/6/12.
//  Copyright © 2018年 sve. All rights reserved.
//

#import "NSURL+SV.h"
#import <objc/runtime.h>

@implementation NSURL (SV)

+ (void)load {
    NSLog(@"调用了load"); // 只调用一次
    Method m1 = class_getClassMethod(self, @selector(URLWithString:));
    Method m2 = class_getClassMethod(self, @selector(SV_URLWithString:));
    method_exchangeImplementations(m1, m2);
}

+ (instancetype)SV_URLWithString:(NSString *)urlString {
    
    NSURL *URL = [NSURL SV_URLWithString:urlString]; // 调用方法自身,并不会递归,因为已经交换了 SEL和IMP
    
    if (URL == nil) {
        NSLog(@"url为空");
    }
    return URL;
}

@end
