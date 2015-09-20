//
//  Ball.m
//  CossacksGameMac
//
//  Created by Alexander Yolkin on 9/19/15.
//  Copyright (c) 2015 Oleksandr Iolkin. All rights reserved.
//

#import "Ball.h"

@implementation Ball

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.size = ballSize;
    }
    return self;
}

- (void)drawAtField:(NSView *)field {
    
    self.view = [[NSView alloc] initWithFrame:CGRectMake(field.bounds.size.width / 2 - ballSize / 2, field.bounds.size.height / 2 - ballSize / 2, ballSize, ballSize)];
    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = [[NSColor blackColor] CGColor];
    
    [field addSubview:self.view];
}

@end
