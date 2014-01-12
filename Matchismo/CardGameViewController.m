//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Jawinton Tang on 1/11/14.
//  Copyright (c) 2014 NJU. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayDeck.h"

@interface CardGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *FlipLabel;
@property (nonatomic) int flipCount;
@property (nonatomic, strong) Deck *deck;

@end

@implementation CardGameViewController

- (Deck *) deck
{
    if (!_deck) {
        _deck = [[PlayDeck alloc] init];
    }
    return _deck;
}

- (IBAction)TouchCardButton:(UIButton *)sender {
    
    if ([sender.currentTitle length] == 0) {
        Card *curCard = [self.deck drawRandomCard];
        if (curCard) {
            NSString *cardTitle = curCard.contents;
            [sender setBackgroundImage:[UIImage imageNamed:@"CardFront"]
                              forState:(UIControlStateNormal)];
            [sender setTitle:cardTitle forState:UIControlStateNormal];
            self.flipCount++;
        }
    } else {
        [sender setBackgroundImage:[UIImage imageNamed:@"CardBack"]
                          forState:(UIControlStateNormal)];
        [sender setTitle:@"" forState:UIControlStateNormal];
        self.flipCount++;
    }
}

-(void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    [self.FlipLabel setText:[NSString stringWithFormat:@"Flips: %d",
                             flipCount]];
}


@end
