//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Matthew Suggit on 17/11/2014.
//  Copyright (c) 2014 Matthew Suggit. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "Model/SetCardDeck.h"
#import "Model/SetCard.h"

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self updateUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSUInteger)numberOfMatchingCards
{
    return 3;
}

- (Deck *)createDeck
{
    return [[SetCardDeck alloc] init];
}

- (UIImage *)backgroundForCard:(Card *)card {
    return [UIImage imageNamed:(card.isChosen ? @"setCardSelected" : @"setCard")];
}

- (NSAttributedString *)titleForCard:(Card *)card
{
    NSString *title = @"";
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
    
    NSDictionary *symbols = [[NSDictionary alloc] initWithObjects:@[@"●", @"▲", @"■"] forKeys:[SetCard validSymbols]];

    NSDictionary *colors = [[NSDictionary alloc] initWithObjects:@[[UIColor redColor], [UIColor greenColor], [UIColor purpleColor]] forKeys:[SetCard validColors]];
    
    if ([card isKindOfClass:[SetCard class]]) {
        SetCard *setCard = (SetCard *)card;
        
        if (symbols[setCard.symbol] && colors[setCard.color]) {
            title = [symbols[setCard.symbol] stringByPaddingToLength:setCard.number withString:symbols[setCard.symbol] startingAtIndex:0];
            [attributes setObject:colors[setCard.color] forKey:NSForegroundColorAttributeName];
        }
        
        if ([setCard.shading isEqualToString:@"solid"]) {
            [attributes setObject:@-5 forKey:NSStrokeWidthAttributeName];
        } else if ([setCard.shading isEqualToString:@"striped"]) {
            [attributes addEntriesFromDictionary:@{NSStrokeWidthAttributeName : @-5, NSStrokeColorAttributeName : attributes[NSForegroundColorAttributeName], NSForegroundColorAttributeName : [attributes[NSForegroundColorAttributeName] colorWithAlphaComponent:0.1]}];
        } else if ([setCard.shading isEqualToString:@"open"]) {
            [attributes setObject:@5 forKey:NSStrokeWidthAttributeName];
        }
    }
    
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}

- (NSAttributedString *)labelForCard:(Card *)card
{
    // For Set cards the title is the same whether isChosen or not so just return titleForCard
    return [self titleForCard:card];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
