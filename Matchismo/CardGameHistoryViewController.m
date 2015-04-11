//
//  CardGameHistoryViewController.m
//  Matchismo
//
//  Created by Matthew Suggit on 11/04/2015.
//  Copyright (c) 2015 Matthew Suggit. All rights reserved.
//

#import "CardGameHistoryViewController.h"

@interface CardGameHistoryViewController ()

@property (weak, nonatomic) IBOutlet UITextView *historyTextView;

@end

@implementation CardGameHistoryViewController

- (NSArray *)history {
    if (!_history) _history = [[NSArray alloc] init];
    return _history;
}

- (void)updateUI {
    if ([self.history count]) {
        NSMutableAttributedString *historyText = [[NSMutableAttributedString alloc] init];
        for (NSAttributedString *result in self.history) {
            [historyText appendAttributedString:result];
            [historyText appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
        }
        self.historyTextView.attributedText = historyText;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self updateUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
