//
//  Game.m
//  CossacksGameMac
//
//  Created by Alexander Yolkin on 11/11/15.
//  Copyright © 2015 Oleksandr Iolkin. All rights reserved.
//

#import "Game.h"

@implementation Game

+ (Game *)sharedGame
{
    
    static Game * _sharedGame = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedGame = [[Game alloc] init];
    });
    return _sharedGame;
}

@end
