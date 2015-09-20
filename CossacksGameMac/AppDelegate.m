//
//  AppDelegate.m
//  CossacksGameMac
//
//  Created by Alexander Yolkin on 9/16/15.
//  Copyright (c) 2015 Oleksandr Iolkin. All rights reserved.
//


#import <AVFoundation/AVFoundation.h>
#import "AppDelegate.h"
#import "Ball.h"
#import "GoalKeeper.h"
#import "GameField.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet GameField *gameField;

@property (strong, nonatomic) Ball* ball;
@property (strong, nonatomic) GoalKeeper *goalKeeper1;
@property (strong, nonatomic) GoalKeeper *goalKeeper2;

@property (assign, nonatomic) CGFloat ballDirectionX;
@property (assign, nonatomic) CGFloat ballDirectionY;

@property (weak) IBOutlet NSTextField *scoreLabel1;
@property (weak) IBOutlet NSTextField *scoreLabel2;
@property (assign, nonatomic) NSInteger scoreTeam1;
@property (assign, nonatomic) NSInteger scoreTeam2;

@property (nonatomic, strong) AVAudioPlayer *hitAudioPlayer;
@property (nonatomic, strong) AVAudioPlayer *goalAudioPlayer;

@property (weak) IBOutlet NSButton *startGameButton;
@end

@implementation AppDelegate

#pragma mark - Game Model Methods

- (void)catchTheBall {
    
    int x;
    if (self.ball.teamOwner == 2) {
        
        int outOfField = self.gameField.bounds.size.width - self.goalKeeper2.view.bounds.size.width;
        
        if (self.ballDirectionX > outOfField) {
            
            x = outOfField;
            
        } else {
            
            x = self.ballDirectionX;
        }
        
        CABasicAnimation* pulseAnimation = [CABasicAnimation animationWithKeyPath:@"position"];

        [pulseAnimation setFromValue:[NSValue valueWithPoint:self.goalKeeper2.view.frame.origin]];
        [pulseAnimation setToValue:[NSValue valueWithPoint:CGPointMake(x, self.goalKeeper2.yCoordinate - 10.f)]];
        pulseAnimation.duration = 1.2;

        [[self.goalKeeper2.view layer] addAnimation:pulseAnimation forKey:@"position"];
        self.goalKeeper2.view.frame = CGRectMake(x, self.goalKeeper2.yCoordinate - 10.f, self.goalKeeper2.view.bounds.size.width, self.goalKeeper2.view.bounds.size.height);
    }
    
}

- (void)isTheGoal {
    
    CALayer *ballLayer = self.ball.view.layer.presentationLayer;
    CGRect ballLayerFrame = ballLayer.frame;
    
    CALayer *goalKeeper1Layer = self.goalKeeper1.view.layer.presentationLayer;
    CGRect goalKeeper1Frame = goalKeeper1Layer.frame;

    CALayer *goalKeeper2Layer = self.goalKeeper2.view.layer.presentationLayer;
    CGRect goalKeeper2Frame = goalKeeper2Layer.frame;
    
    BOOL goal1 = CGRectIntersectsRect(ballLayerFrame, goalKeeper1Frame);
    BOOL goal2 = CGRectIntersectsRect(ballLayerFrame, goalKeeper2Frame);
    
    if (self.ball.teamOwner == 2) {
        if (!goal2) {
            self.scoreTeam1++;
            self.scoreLabel1.stringValue = [NSString stringWithFormat:@"%ld", (long)self.scoreTeam1];
            
            if (self.goalAudioPlayer) {
                [self.goalAudioPlayer play];
            }
        }
    }
    
    if (self.ball.teamOwner == 1) {
        if (!goal1) {
            self.scoreTeam2++;
            self.scoreLabel2.stringValue = [NSString stringWithFormat:@"%ld", (long)self.scoreTeam2];
            
            if (self.goalAudioPlayer) {
                [self.goalAudioPlayer play];
            }
        }
    }
}

- (void)firstHitSelect {
    
    self.ball.teamOwner = arc4random() % 2 + 1;
}

- (void)hitTheBall {
    
    if (self.hitAudioPlayer) {
        [self.hitAudioPlayer play];
    }
    
    
    self.ballDirectionX = arc4random() % (int)(self.gameField.bounds.size.width - self.ball.view.bounds.size.width);
    self.ballDirectionY = 0;
    
    if (self.ball.teamOwner == 1) {
        self.ballDirectionY = self.goalKeeper2.yCoordinate - self.ball.size;
        self.ball.teamOwner = 2;
    } else {
        self.ballDirectionY = self.goalKeeper1.yCoordinate;
        self.ball.teamOwner = 1;
    }

    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, self.ball.view.frame.origin.x, self.ball.view.frame.origin.y);
    
    CGFloat xCurve = arc4random() % (int)self.gameField.bounds.size.width;
    CGFloat yCurve = self.gameField.bounds.size.height / 2;
    CGPathAddCurveToPoint(path, NULL, xCurve, yCurve, xCurve, yCurve, self.ballDirectionX, self.ballDirectionY);

    CAKeyframeAnimation *animation;

    animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path;
    animation.duration = 0.9f;
    
    animation.delegate = self;
    
    [[self.ball.view layer] addAnimation:animation forKey:@"position"];
    
    self.ball.view.frame = CGRectMake(self.ballDirectionX, self.ballDirectionY, self.ball.size, self.ball.size);
}

- (IBAction)startGame:(NSButton *)sender {

    self.startGameButton.hidden = YES;
    [self firstHitSelect];
    [self hitTheBall];
    [self catchTheBall];
    
}


#pragma mark - Application Delegate Methods

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    self.scoreTeam1 = 0;
    self.scoreTeam2 = 0;
    self.gameField.wantsLayer = YES;

    self.ball = [[Ball alloc] init];
    [self.ball drawAtField:self.gameField];
    
    self.goalKeeper1 = [[GoalKeeper alloc] init];
    self.goalKeeper1.yCoordinate = 10.f;
    self.goalKeeper1.manualMove = YES;
    self.gameField.manualGoalKeeper = self.goalKeeper1;
    [self.goalKeeper1 drawAtField:self.gameField];
    
    self.goalKeeper2 = [[GoalKeeper alloc] init];
    self.goalKeeper2.yCoordinate = self.gameField.bounds.size.height - 10.f;
    [self.goalKeeper2 drawAtField:self.gameField];
    
    [self prepareAudioPlayer];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {

}

#pragma  mark - Animation Delegate Methods

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self isTheGoal];
    [self hitTheBall];
    [self catchTheBall];
}

- (void)animationDidStart:(CAAnimation *)anim {
    
}

#pragma mark - Audio Player

- (void)prepareAudioPlayer {
    
    NSString *hitFilePath = [[NSBundle mainBundle] pathForResource:@"hit" ofType:@"mp3"];
    NSURL *hitURL = [NSURL URLWithString:hitFilePath];
    
    NSError *error;
    
    self.hitAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:hitURL error:&error];
    if (error) {

        NSLog(@"Could not play beep file.");
        NSLog(@"%@", [error localizedDescription]);
    }
    else{
 
        [self.hitAudioPlayer prepareToPlay];
    }
    
    NSString *goalFilePath = [[NSBundle mainBundle] pathForResource:@"goal" ofType:@"mp3"];
    NSURL *goalURL = [NSURL URLWithString:goalFilePath];
    
    NSError *error2;
    
    self.goalAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:goalURL error:&error];
    if (error2) {

        NSLog(@"Could not play beep file.");
        NSLog(@"%@", [error localizedDescription]);
    }
    else{

        [self.goalAudioPlayer prepareToPlay];
    }
}

@end
