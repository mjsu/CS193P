//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Matthew Suggit on 17/11/2014.
//  Copyright (c) 2014 Matthew Suggit. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@implementation PlayingCardGameViewController

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (NSUInteger)numberOfMatchingCards
{
    return 2;
}

@end
