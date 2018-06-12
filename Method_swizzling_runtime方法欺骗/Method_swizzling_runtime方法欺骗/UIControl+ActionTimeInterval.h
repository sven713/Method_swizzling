//
//  UIControl+ActionTimeInterval.h
//  Method_swizzling_runtime方法欺骗
//
//  Created by sve on 2018/6/12.
//  Copyright © 2018年 sve. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (ActionTimeInterval)

@property (nonatomic, assign) NSTimeInterval actionTimeInterval; //!<相应时间间隔

@end
