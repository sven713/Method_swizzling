//
//  UIControl+ActionTimeInterval.m
//  Method_swizzling_runtime方法欺骗
//
//  Created by sve on 2018/6/12.
//  Copyright © 2018年 sve. All rights reserved.
//

#import "UIControl+ActionTimeInterval.h"
#import <objc/runtime.h>

static const void *actionTimeIntervalKey = "actionTimeIntervalKey";
static const void *shouldActionKey = "shouldActionKey";

@interface UIControl ()
@property (nonatomic, assign) BOOL ignoreEvent; //!<是否需要相应点击事件
@end


@implementation UIControl (ActionTimeInterval)

+(void)load {
    Method m1 = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method m2 = class_getInstanceMethod(self, @selector(SV_sendAction:to:forEvent:));
    method_exchangeImplementations(m1, m2);
}

- (void)SV_sendAction:(SEL)selector to:(id)target forEvent:(UIEvent *)event {
    
    if (self.ignoreEvent) {
        return;
    }
    
    if (self.actionTimeInterval > 0) {
        self.ignoreEvent = YES;
        [self performSelector:@selector(changeShouldActionStatus) withObject:nil afterDelay:self.actionTimeInterval];
    }
    
    [self SV_sendAction:selector to:target forEvent:event];
}

- (void)changeShouldActionStatus {
    self.ignoreEvent = NO;
}

#pragma mark Getter & Setter
-(void)setActionTimeInterval:(NSTimeInterval)actionTimeInterval {
    objc_setAssociatedObject(self, actionTimeIntervalKey, @(actionTimeInterval), OBJC_ASSOCIATION_ASSIGN);
}


-(NSTimeInterval)actionTimeInterval {
    id object = objc_getAssociatedObject(self, actionTimeIntervalKey);
    return [object doubleValue];
}


// 不写set方法崩溃了 在分类里面必须用关联对象,添加属性
-(void)setIgnoreEvent:(BOOL)ignoreEvent {
    objc_setAssociatedObject(self, shouldActionKey, @(ignoreEvent), OBJC_ASSOCIATION_ASSIGN);
}

-(BOOL)ignoreEvent {
    return  [objc_getAssociatedObject(self, shouldActionKey) boolValue];
}

@end
