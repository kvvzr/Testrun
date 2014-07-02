//
//  UIStepper+Block.m
//  Testrun
//
//  Created by Kawazure on 2014/07/02.
//  Copyright (c) 2014年 Twinkrun. All rights reserved.
//

#import <objc/runtime.h>
#import "UIStepper+Block.h"

@implementation UIStepper (Block)

@dynamic block, target;

- (void)setBlock:(RedrawTarget)block
{
    objc_setAssociatedObject(self, @"redrawTarget", block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setTarget:(id)target
{
    objc_setAssociatedObject(self, @"target", target, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)redrawTarget
{
    RedrawTarget block = objc_getAssociatedObject(self, @"redrawTarget");
    id target = objc_getAssociatedObject(self, @"target");
    
    block(target, self.value);
}

@end