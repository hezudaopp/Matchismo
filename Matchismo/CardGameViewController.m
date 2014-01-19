//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Jawinton Tang on 1/11/14.
//  Copyright (c) 2014 NJU. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayDeck.h"
#import "ThreeCardMatchingGame.h"

@interface CardGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *FlipLabel;
@property (nonatomic) int flipCount;
@property (nonatomic, strong) Deck *deck;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchModelSegmentedControl;
@property (nonatomic) NSUInteger matchModelSegmentedIndex;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@end

@implementation CardGameViewController

- (CardMatchingGame *)game
{
    if (!_game) {
        if (self.matchModelSegmentedIndex == 0) {
            _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                      usingDeck:[self createDeck]];
        } else {
            _game = [[ThreeCardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                      usingDeck:[self createDeck]];
        }
    }
    return _game;
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
    return [[PlayDeck alloc] init];
}

- (IBAction)TouchCardButton:(UIButton *)sender
{
    
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
    self.matchModelSegmentedControl.enabled = NO;
    self.flipCount++;
}

- (IBAction)TouchResetButton:(UIButton *)sender {
    self.flipCount = 0;
    [self.game resetGame];
    [self updateUI];
    self.matchModelSegmentedControl.enabled = YES;
}

- (IBAction)MatchModelValueChanged:(UISegmentedControl *)sender {
    self.game = nil;
    self.matchModelSegmentedIndex = [sender selectedSegmentIndex];
    [self updateUI];
}


- (void)updateUI
{
    for (UIButton *button in self.cardButtons) {
        NSUInteger buttonIndex = [self.cardButtons indexOfObject:button];
        Card *card = [self.game cardAtIndex:buttonIndex];
        [button setTitle:[self titleForCard:card]
                forState:UIControlStateNormal];
        [button setBackgroundImage:[self backgroundImageForCard:card]
                          forState:UIControlStateNormal];
        button.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Current Score: %d", self.game.score];
    self.infoLabel.text = [self.game infoString];
    [self setFlipCount:self.flipCount];
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"CardFront" : @"CardBack"];
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    [self.FlipLabel setText:[NSString stringWithFormat:
                             @"Flips: %d",flipCount]];
}

@end
