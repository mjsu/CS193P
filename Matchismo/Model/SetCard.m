//
//  SetCard.m
//  Matchismo
//
//  Created by Matthew Suggit on 19/11/2014.
//  Copyright (c) 2014 Matthew Suggit. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard


- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if ([otherCards count] == 2) {
        NSMutableArray *colors = [[NSMutableArray alloc] init];
        NSMutableArray *symbols = [[NSMutableArray alloc] init];
        NSMutableArray *shadings = [[NSMutableArray alloc] init];
        NSMutableArray *numbers = [[NSMutableArray alloc] init];
        
        [colors addObject:self.color];
        [symbols addObject:self.symbol];
        [shadings addObject:self.shading];
        [numbers addObject:@(self.number)];
        
        for (id otherCard in otherCards) {
            if ([otherCard isKindOfClass:[SetCard class]]) {
                SetCard *otherSetCard = (SetCard *)otherCard;
                
                if (![colors containsObject:otherSetCard.color]) {
                    [colors addObject:otherSetCard.color];
                }
                if (![symbols containsObject:otherSetCard.symbol]) {
                    [symbols addObject:otherSetCard.symbol];
                }
                if (![shadings containsObject:otherSetCard.shading]) {
                    [shadings addObject:otherSetCard.shading];
                }
                if (![numbers containsObject:@(otherSetCard.number)]) {
                    [numbers addObject:@(otherSetCard.number)];
                }
            }
        }
        
        if (([colors count] == 1 || [colors count] == 3) &&
            ([symbols count] == 1 || [symbols count] == 3) &&
            ([shadings count] == 1 || [shadings count] == 3) &&
            ([numbers count] == 1 || [numbers count] == 3)) {
            score = 4;
        }
    }
    
    return score;
}


- (NSString *)contents
{
    return [NSString stringWithFormat:@"%@:%@:%@:%lu", self.color,
            self.symbol, self.shading, (unsigned long)self.number];
}

@synthesize color = _color;

- (NSString *)color
{
    return _color ? _color : @"?";
}

- (void)setColor:(NSString *)color
{
    if ([[SetCard validColors] containsObject:color]) {
        _color = color;
    }
}

@synthesize symbol = _symbol;

- (NSString *)symbol
{
    return _symbol ? _symbol : @"?";
}

- (void)setSymbol:(NSString *)symbol
{
    if ([[SetCard validSymbols] containsObject:symbol]) {
        _symbol = symbol;
    }
}

@synthesize shading = _shading;

- (NSString *)shading
{
    return _shading ? _shading : @"?";
}

- (void)setShading:(NSString *)shading
{
    if ([[SetCard validShadings] containsObject:shading]) {
        _shading = shading;
    }
}

- (void)setNumber:(NSUInteger)number
{
    if (number <= [SetCard maxNumber]) {
        _number = number;
    }
}


+ (NSArray *)validColors {
    return @[@"red",@"green",@"purple"];
}

+ (NSArray *)validSymbols {
    return @[@"diamond",@"squiggle",@"oval"];
}

+ (NSArray *)validShadings {
    return @[@"solid", @"striped", @"open"];
}

+ (NSUInteger)maxNumber {
    return 3;
}

+ (NSArray *)cardsFromText:(NSString *)text
{
    NSString *pattern = [NSString stringWithFormat:@"(%@):(%@):(%@):(\\d+)",
                         [[SetCard validSymbols] componentsJoinedByString:@"|"],
                         [[SetCard validColors] componentsJoinedByString:@"|"],
                         [[SetCard validShadings] componentsJoinedByString:@"|"]];
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    if (error) return nil;
    NSArray *matches = [regex matchesInString:text
                                      options:0
                                        range:NSMakeRange(0, [text length])];
    //NSLog(@"%@", text);
    //NSLog(@"matches %ld", (unsigned long)[matches count]);
    if (![matches count]) return nil;
    
    NSMutableArray *setCards = [[NSMutableArray alloc] init];
    for (NSTextCheckingResult *match in matches) {
        SetCard *setCard = [[SetCard alloc] init];
        setCard.symbol = [text substringWithRange:[match rangeAtIndex:1]];
        setCard.color = [text substringWithRange:[match rangeAtIndex:2]];
        setCard.shading = [text substringWithRange:[match rangeAtIndex:3]];
        setCard.number = [[text substringWithRange:[match rangeAtIndex:4]] intValue];
        [setCards addObject:setCard];
    }
    
    return setCards;
}

@end
