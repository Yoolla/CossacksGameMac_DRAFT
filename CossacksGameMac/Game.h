//
//  Game.h
//  CossacksGameMac
//
//  Created by Alexander Yolkin on 11/11/15.
//  Copyright © 2015 Oleksandr Iolkin. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "Ball.h"
#import "GoalKeeper.h"
#import "GameField.h"

@interface Game : NSObject

+ (Game *)sharedGame;

@end
