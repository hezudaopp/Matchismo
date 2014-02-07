//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Jawinton Tang on 1/11/14.
//  Copyright (c) 2014 NJU. All rights reserved.
//

#import "CardGameViewController.h"
#import "HistoryViewController.h"

@interface CardGameViewController ()


@end

@implementation CardGameViewController

- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [self createCardMatchingGame];
    }
    return _game;
}

- (CardMatchingGame *) createCardMatchingGame;
{
    return nil;
}

- (Deck *)deck
{
    if (!_deck) {
        _deck = [self createDeck];
    }
    return _deck;
}

- (Deck *)createDeck
{
    return nil;
}

- (void)updateUI
{
    
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"history"]) {
        if ([segue.destinationViewController isKindOfClass:[HistoryViewController class]]) {
            HistoryViewController *hvc = (HistoryViewController *)segue.destinationViewController;
            hvc.historyText = self.game.history;
        }
    }
}

@end
