//
//  Ball.h
//  CossacksGameMac
//
//  Created by Alexander Yolkin on 9/19/15.
//  Copyright (c) 2015 Oleksandr Iolkin. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QuartzCore/QuartzCore.h>

static const NSInteger ballSize = 40;

@interface Ball : NSObject

@property (assign, nonatomic) NSInteger size;
@property (strong, nonatomic) NSView *view;
@property (assign, nonatomic) NSInteger teamOwner;

- (void)drawAtField:(NSView *)field;

@end
