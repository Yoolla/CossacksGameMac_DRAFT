//
//  KeyHandlingView.m
//  CossacksGameMac
//
//  Created by Alexander Yolkin on 9/19/15.
//  Copyright (c) 2015 Oleksandr Iolkin. All rights reserved.
//

#import "GameField.h"

@implementation GameField

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    
}

- (BOOL)acceptsFirstResponder
{
    return YES;
}

- (void)keyDown:(NSEvent *)theEvent {
    
    NSString *characters = [theEvent characters];
    if ([characters length] == 1 && ![theEvent isARepeat])
    {
        unichar character = [characters characterAtIndex:0];
        if (character == NSLeftArrowFunctionKey)
        {
            [self.manualGoalKeeper moveTo:@"left"];
        }
        else if (character == NSRightArrowFunctionKey)
        {
            [self.manualGoalKeeper moveTo:@"right"];
        }
        else if (character == NSDownArrowFunctionKey)
        {
            [self.manualGoalKeeper moveTo:@"stop"];
        }
    }
}


@end
