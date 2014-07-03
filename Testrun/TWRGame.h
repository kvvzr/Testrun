//
//  TWRGame.h
//  Testrun
//
//  Created by Kawazure on 2014/07/03.
//  Copyright (c) 2014年 Twinkrun. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, TWRGameState){
    TWRGameStateIdle,
    TWRGameStateCountDown,
    TWRGameStateStarted
};

@class TWRGame;

@protocol TWRGameDelegate <NSObject>

- (void)didUpdateCountDown:(int)count;
- (void)didStartGame:(TWRGame *)game;
- (void)didUpdateColor:(TWRGame *)game;
- (void)didEndGame:(TWRGame *)game;

@end

@interface TWRGame : NSObject

@property TWRGameState state;
@property (nonatomic, strong) NSDictionary *settings;
@property (nonatomic, assign) id<TWRGameDelegate> delegate;
@property (nonatomic, strong) UIColor *currentColor;

- (id)initWithSettings:(NSDictionary *)settings;
- (void)start;
- (void)end;

@end
