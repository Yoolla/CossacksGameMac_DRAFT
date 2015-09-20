//
//  GoalKeeper.m
//  CossacksGameMac
//
//  Created by Alexander Yolkin on 9/19/15.
//  Copyright (c) 2015 Oleksandr Iolkin. All rights reserved.
//

#import "GoalKeeper.h"

@implementation GoalKeeper


- (instancetype)init {

    self = [super init];
    if (self) {
        self.yCoordinate = 0;
        self.view = nil;
        self.manualMove = NO;
    }
    return self;
}

- (void)drawAtField:(NSView *)field {
    
    self.view = [[NSView alloc] initWithFrame:CGRectMake(field.bounds.size.width / 2 - gateWidth / 2, self.yCoordinate - gateHeight / 2, gateWidth, gateHeight)];
    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = [[NSColor blackColor] CGColor];
    self.fieldWidth = field.bounds.size.width;
    
    [field addSubview:self.view];
}

- (void)moveTo:(NSString *)direction {
    
    long x;
    
    if (self.manualMove && ![direction isEqualToString:@"stop"]) {
        
        CALayer *layer = self.view.layer.presentationLayer;
        CGRect frame = layer.frame;
        [[self.view layer] removeAllAnimations];
        self.view.frame = frame;
        
        if ([direction isEqualToString:@"right"]) {

            x = self.fieldWidth - gateWidth;

        } else if ([direction isEqualToString:@"left"]) {

            x = 0;
            
        }
        
        CABasicAnimation* pulseAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
        
        [pulseAnimation setFromValue:[NSValue valueWithPoint:self.view.frame.origin]];
        [pulseAnimation setToValue:[NSValue valueWithPoint:CGPointMake(x, self.yCoordinate - 10.f)]];
        pulseAnimation.duration = 0.5;
        
        [[self.view layer] addAnimation:pulseAnimation forKey:@"position"];
        
        self.view.frame = CGRectMake(x, self.yCoordinate - 10.f, gateWidth, gateHeight);
        
    } else {
        
        CALayer *layer = self.view.layer.presentationLayer;
        CGRect frame = layer.frame;
        [[self.view layer] removeAllAnimations];
        self.view.frame = frame;
    }
}

@end
