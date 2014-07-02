//
//  UIStepper+Block.h
//  Testrun
//
//  Created by Kawazure on 2014/07/02.
//  Copyright (c) 2014年 Twinkrun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^RedrawTarget)(id, double);

@interface UIStepper (Block)

@property (nonatomic, copy) RedrawTarget block;
@property (nonatomic, retain) id target;

- (void)redrawTarget;

@end
