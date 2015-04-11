//
//  SetCard.h
//  Matchismo
//
//  Created by Matthew Suggit on 19/11/2014.
//  Copyright (c) 2014 Matthew Suggit. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) NSString *shading;
@property (nonatomic) NSUInteger number;

+ (NSArray *)validColors;
+ (NSArray *)validSymbols;
+ (NSArray *)validShadings;
+ (NSUInteger)maxNumber;

+ (NSArray *)cardsFromText:(NSString *)text;

@end
