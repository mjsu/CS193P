//
//  Card.m
//  Matchismo
//
//  Created by Matthew Suggit on 23/09/2014.
//  Copyright (c) 2014 Matthew Suggit. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int)match:(NSArray *)otherCards {
    int score = 0;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    
    return score;
}

@end
