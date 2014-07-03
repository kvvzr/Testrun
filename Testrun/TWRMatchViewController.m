//
//  TWRMatchViewController.m
//  Testrun
//
//  Created by Kawazure on 2014/07/03.
//  Copyright (c) 2014年 Twinkrun. All rights reserved.
//

#import "TWRMatchViewController.h"
#import "UIColor+Twinkrun.h"
#import "TWRGame.h"
#import <CSAnimationView.h>
#import <ObjectAL.h>

@interface TWRMatchViewController () <TWRGameDelegate>

@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UILabel *countDownLabel;
@property (weak, nonatomic) IBOutlet CSAnimationView *leftBottomPhoneView;
@property (weak, nonatomic) IBOutlet CSAnimationView *leftBottomHandView;
@property (weak, nonatomic) IBOutlet CSAnimationView *rightBottomPhoneView;
@property (weak, nonatomic) IBOutlet CSAnimationView *rightBottomHandView;
@property (weak, nonatomic) IBOutlet CSAnimationView *leftTopPhoneView;
@property (weak, nonatomic) IBOutlet CSAnimationView *leftTopHandView;
@property (weak, nonatomic) IBOutlet CSAnimationView *rightTopPhoneView;
@property (weak, nonatomic) IBOutlet CSAnimationView *rightTopHandView;
@property (strong, nonatomic) TWRGame *game;

- (IBAction)startButtonTouched:(id)sender;

@end

@implementation TWRMatchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self prefersStatusBarHidden];
    [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backToSettings)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
    
    [OALSimpleAudio sharedInstance].honorSilentSwitch = YES;
    [[OALSimpleAudio sharedInstance] preloadEffect:@"beep.mp3"];
    [[OALSimpleAudio sharedInstance] preloadEffect:@"count-down.mp3"];
    [[OALSimpleAudio sharedInstance] preloadEffect:@"score-transition.mp3"];
    
    self.view.backgroundColor = [UIColor twinkrunBlack];
    
    self.game = [[TWRGame alloc] initWithSettings:self.settings];
    self.game.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.leftBottomHandView.hidden = NO;
    self.rightBottomHandView.hidden = NO;
    self.leftTopHandView.hidden = NO;
    self.rightTopHandView.hidden = NO;
    
    self.leftBottomPhoneView.hidden = NO;
    self.rightBottomPhoneView.hidden = NO;
    self.leftTopPhoneView.hidden = NO;
    self.rightTopPhoneView.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
    [self.game end];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)backToPlayerSelectView
{
    if (self.game.state == TWRGameStateIdle){
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)startButtonTouched:(id)sender {
    if (self.game.state == TWRGameStateIdle){
        [self.game start];
        
        self.startButton.alpha = 0.1;
        [self.startButton setImage:[UIImage imageNamed:@"StopMatchButton"] forState:UIControlStateNormal];
        
        self.leftBottomHandView.hidden = YES;
        self.rightBottomHandView.hidden = YES;
        self.leftTopHandView.hidden = YES;
        self.rightTopHandView.hidden = YES;
        
        self.leftBottomPhoneView.hidden = YES;
        self.rightBottomPhoneView.hidden = YES;
        self.leftTopPhoneView.hidden = YES;
        self.rightTopPhoneView.hidden = YES;
        
        self.countDownLabel.hidden = NO;
    }else{
        [self.game end];
        
        [[UIScreen mainScreen] setBrightness:1.0];
        
        self.startButton.alpha = 1.0;
        [self.startButton setImage:[UIImage imageNamed:@"StartMatchButton"] forState:UIControlStateNormal];
        
        self.leftBottomHandView.hidden = NO;
        self.rightBottomHandView.hidden = NO;
        self.leftTopHandView.hidden = NO;
        self.rightTopHandView.hidden = NO;
        
        self.leftBottomPhoneView.hidden = NO;
        self.rightBottomPhoneView.hidden = NO;
        self.leftTopPhoneView.hidden = NO;
        self.rightTopPhoneView.hidden = NO;
        
        self.view.backgroundColor = [UIColor twinkrunBlack];
        self.countDownLabel.hidden = YES;
    }
}

- (void)didUpdateCountDown:(int)count
{
    [[OALSimpleAudio sharedInstance] playEffect:@"count-down.mp3"];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.countDownLabel.text = [NSString stringWithFormat:@"%d", count];
    });
}

- (void)didStartGame:(TWRGame *)game
{
    self.countDownLabel.hidden = YES;
}

- (void)didUpdateColor:(TWRGame *)game
{
    [[OALSimpleAudio sharedInstance] playEffect:@"score-transition.mp3" volume:1.0 pitch:1.0 pan:0.0 loop:NO];
    self.view.backgroundColor = [game currentColor];
}

- (void)didEndGame:(TWRGame *)game
{
    [[OALSimpleAudio sharedInstance] stopAllEffects];
    [[OALSimpleAudio sharedInstance] playEffect:@"beep.mp3"];
    
    [self backToSettings];
}

- (void)backToSettings
{
    if (self.game.state == TWRGameStateIdle){
        self.leftBottomHandView.hidden = YES;
        self.rightBottomHandView.hidden = YES;
        self.leftTopHandView.hidden = YES;
        self.rightTopHandView.hidden = YES;
        
        self.leftBottomPhoneView.hidden = YES;
        self.rightBottomPhoneView.hidden = YES;
        self.leftTopPhoneView.hidden = YES;
        self.rightTopPhoneView.hidden = YES;
        
        [[OALSimpleAudio sharedInstance] unloadAllEffects];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
