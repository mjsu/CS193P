//
//  ViewController.m
//  Matchismo
//
//  Created by Matthew Suggit on 22/09/2014.
//  Copyright (c) 2014 Matthew Suggit. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardGameHistoryViewController.h"
#import "Model/CardMatchingGame.h"

@interface CardGameViewController ()
@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end

@implementation CardGameViewController

- (void)viewDidLoad {
    self.resultsLabel.text = @"";
}

- (CardMatchingGame *)game {
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
        _game.numberOfCardsToMatch = self.numberOfMatchingCards;
    }
    return _game;
}

- (Deck *)createDeck {
    return nil; // abstract
}

- (NSMutableArray *)resultsHistory {
    if (!_resultsHistory) {
        _resultsHistory = [[NSMutableArray alloc] init];
    }
    return _resultsHistory;
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
    
    if ([self.game.lastChosenCards count] == self.game.numberOfCardsToMatch) {
        NSAttributedString *results = [[NSAttributedString alloc] init];
        results = [self resultsForMatch:self.game.lastChosenCards];
        self.resultsLabel.attributedText = results;
        
        if (![results isEqualToAttributedString:[[NSAttributedString alloc] initWithString:@""]] &
            ![[self.resultsHistory lastObject] isEqualToAttributedString:results]) {
            [self.resultsHistory addObject:results];
        }
    }
    
}

- (NSAttributedString *)resultsForMatch:(NSArray *)lastChosenCards
{
    NSMutableAttributedString *results = [[NSMutableAttributedString alloc] init];
    for (Card *card in lastChosenCards) {
        [results appendAttributedString:[self labelForCard:card]];
        [results appendAttributedString:[[NSAttributedString alloc] initWithString:@", "]];
    }
    if (self.game.score > self.game.lastScore) {
        [results appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"matched for %ld points", self.game.score - self.game.lastScore]]];
    } else {
        [results appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"do not match, %ld penalty", self.game.lastScore - self.game.score]]];
    }
    return results;
}


- (NSAttributedString *)titleForCard:(Card *)card {
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:card.isChosen ? card.contents : @""];
    return title;
}

- (NSAttributedString *)labelForCard:(Card *)card {
    return [[NSAttributedString alloc] initWithString:card.contents];
}

- (UIImage *)backgroundForCard:(Card *)card {
    return [UIImage imageNamed:(card.isChosen ? @"cardfront" : @"cardback")];
}

- (IBAction)touchDealButton:(id)sender {
    self.game = nil;
    self.resultsHistory = nil;
    [self updateUI];
    self.resultsLabel.text = @"";
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Show History"]) {
        if ([segue.destinationViewController isKindOfClass:[CardGameHistoryViewController class]]) {
            [segue.destinationViewController setHistory:self.resultsHistory];
        }
    }
}


@end
