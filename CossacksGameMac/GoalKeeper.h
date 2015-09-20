//
//  GoalKeeper.h
//  CossacksGameMac
//
//  Created by Alexander Yolkin on 9/19/15.
//  Copyright (c) 2015 Oleksandr Iolkin. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QuartzCore/QuartzCore.h>

static const NSInteger gateWidth = 80;
static const NSInteger gateHeight = 20;

@interface GoalKeeper : NSObject

@property (strong, nonatomic) NSView *view;
@property (assign, nonatomic) CGFloat yCoordinate;
@property (assign, nonatomic) BOOL manualMove;
@property (assign, nonatomic) NSInteger fieldWidth;

- (void)drawAtField:(NSView *)field;
- (void)moveTo:(NSString *)direction;

@end
