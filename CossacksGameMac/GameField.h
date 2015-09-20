//
//  KeyHandlingView.h
//  CossacksGameMac
//
//  Created by Alexander Yolkin on 9/19/15.
//  Copyright (c) 2015 Oleksandr Iolkin. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "GoalKeeper.h"

@interface GameField : NSView

@property (strong, nonatomic) GoalKeeper *manualGoalKeeper;

@end
