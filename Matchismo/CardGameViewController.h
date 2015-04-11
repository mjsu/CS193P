//
//  ViewController.h
//  Matchismo
//
//  Created by Matthew Suggit on 22/09/2014.
//  Copyright (c) 2014 Matthew Suggit. All rights reserved.
//
// Abstract class

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardGameViewController : UIViewController


// Protected for subclasses
- (Deck *)createDeck;
- (NSAttributedString *)titleForCard:(Card *)card;
- (NSAttributedString *)labelForCard:(Card *)card; // same as titleForCard but ignores isChosen
- (UIImage *)backgroundForCard:(Card *)card;
- (void)updateUI;

@property (nonatomic) NSUInteger numberOfMatchingCards;
@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;
@property (strong, nonatomic) NSMutableArray *resultsHistory; // of NSString

@end

