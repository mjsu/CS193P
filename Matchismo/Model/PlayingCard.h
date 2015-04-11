//
//  PlayingCard.h
//  Matchismo
//
//  Created by Matthew Suggit on 23/09/2014.
//  Copyright (c) 2014 Matthew Suggit. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
