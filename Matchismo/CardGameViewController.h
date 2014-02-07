//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Jawinton Tang on 1/11/14.
//  Copyright (c) 2014 NJU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController : UIViewController

@property (nonatomic, strong) Deck *deck;
@property (strong, nonatomic) CardMatchingGame *game;

- (Deck *) createDeck;
- (CardMatchingGame *) createCardMatchingGame;
- (void)updateUI;
- (NSString *)titleForCard:(Card *)card;

@end
