//
//  NSMutableArray+Queue.m
//  BluetoothLowEnergy
//
//  Created by Kawazure on 2014/02/20.
//  Copyright (c) 2014年 Twinkrun. All rights reserved.
//

#import "NSMutableArray+Queue.h"

@implementation NSMutableArray (Queue)

- (id)dequeue
{
    id first = nil;
    if ([self count] > 0){
        first = self[0];
        [self removeObjectAtIndex:0];
    }
    
    return first;
}

- (void)enqueue:(id)object
{
    [self addObject:object];
}

@end
