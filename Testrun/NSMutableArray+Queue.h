//
//  NSMutableArray+Queue.h
//  BluetoothLowEnergy
//
//  Created by Kawazure on 2014/02/20.
//  Copyright (c) 2014年 Twinkrun. All rights reserved.
//

@interface NSMutableArray (Queue)

- (id)dequeue;
- (void)enqueue:(id)object;

@end
