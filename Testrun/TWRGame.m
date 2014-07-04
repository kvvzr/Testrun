//
//  TWRGame.m
//  Testrun
//
//  Created by Kawazure on 2014/07/03.
//  Copyright (c) 2014年 Twinkrun. All rights reserved.
//

#import "TWRGame.h"
#import "UIColor+Twinkrun.h"
#import "NSMutableArray+Queue.h"

@interface TWRGame ()

@property (strong, nonatomic) NSMutableArray *colors;
@property (strong, nonatomic) NSTimer *countDownTimer, *colorChangeTimer;
@property int countDown, sumOfColors;

@end

@implementation TWRGame

@synthesize delegate;

- (id)initWithSettings:(NSDictionary *)settings
{
    if (self = [super init]){
        self.state = TWRGameStateIdle;
        self.countDown = 5;
        self.sumOfColors = 0;
        
        self.colors = [NSMutableArray array];
        
        if ([settings[@"mode"] isEqualToString:@"random"]) {
            for (NSArray *key in settings[@"colors"]) {
                self.sumOfColors += [(NSNumber *)settings[@"colors"][key][@"count"] intValue];
            }
            
            for (int i = 0; i < self.sumOfColors; i++) {
                [self.colors addObject:[NSNull null]];
            }
            for (NSArray *key in settings[@"colors"]) {
                [self fillColors:self.colors
                       withColor:settings[@"colors"][key][@"color"]
                        withTime:settings[@"colors"][key][@"time"]
                      colorCount:[(NSNumber *)settings[@"colors"][key][@"count"] intValue]];
            }
        } else {
            NSMutableArray *colors = settings[@"colors"];
            self.sumOfColors = (int)colors.count;
            self.colors = colors;
        }
    }
    return self;
}

- (void)fillColors:(NSMutableArray *)colors withColor:(UIColor *)color withTime:(NSNumber *)time colorCount:(int)colorCount
{
    for (int i = 0; i < colorCount; i++){
        while (true){
            int j = arc4random() % self.sumOfColors;
            if ([colors[j] isEqual:[NSNull null]]){
                colors[j] = @{@"color":color, @"time":time};
                break;
            }
        }
    }
}

- (void)start
{
    self.countDownTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.countDownTimer forMode:NSRunLoopCommonModes];
    [self countDown:nil];
}

- (void)countDown:(NSTimer *)timer
{
    self.state = TWRGameStateCountDown;
    
    if ([self.delegate respondsToSelector:@selector(didUpdateCountDown:)]){
        [self.delegate didUpdateCountDown:self.countDown];
    }
    
    if (self.countDown == 0){
        [timer invalidate];
        
        self.state = TWRGameStateStarted;
        if ([self.delegate respondsToSelector:@selector(didStartGame:)]){
            [self.delegate didStartGame:self];
        }
        
        if ([self.delegate respondsToSelector:@selector(didUpdateColor:)]){
            [self.delegate didUpdateColor:self];
        }
        
        [self updateBackgroundColor:nil];
        
        self.countDown = 5;
    }
    
    --self.countDown;
}

- (void)updateBackgroundColor:(NSTimer *)sender
{
    NSDictionary *color = [self.colors dequeue];
    if (!color){
        [self end:nil];
        return;
    }
    
    self.currentColor = color[@"color"];
    
    self.colorChangeTimer = [NSTimer timerWithTimeInterval:[(NSNumber *)color[@"time"] intValue] target:self selector:@selector(updateBackgroundColor:) userInfo:nil repeats:NO];
    [[NSRunLoop mainRunLoop] addTimer:self.colorChangeTimer forMode:NSRunLoopCommonModes];
    
    if ([self.delegate respondsToSelector:@selector(didUpdateColor:)]){
        [self.delegate didUpdateColor:self];
    }
}

- (void)end
{
    self.countDown = 5;
    
    [self.colorChangeTimer invalidate];
    [self.countDownTimer invalidate];
    
    self.state = TWRGameStateIdle;
}

- (void)end:(NSTimer *)timer
{
    [self end];
    
    if ([self.delegate respondsToSelector:@selector(didEndGame:)]){
        [self.delegate didEndGame:self];
    }
}

@end
