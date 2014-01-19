//
//  3CardMatchingGame.m
//  Matchismo
//
//  Created by Jawinton Tang on 1/16/14.
//  Copyright (c) 2014 NJU. All rights reserved.
//

#import "ThreeCardMatchingGame.h"

@interface ThreeCardMatchingGame()

@property (nonatomic, readwrite) NSUInteger score;
@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic, readwrite) NSInteger gainScore;
@property (strong, nonatomic, readwrite) NSString *cardNames;
@property (strong, nonatomic, readwrite) NSString *cardName;

@end

@implementation ThreeCardMatchingGame;

- (NSMutableArray *) cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}


static const int MAGIC_NUMBER = 6;
static const int MISMATCH_PENALTY = 1;
static const int COST_TO_CHOOSE = 1;
-(void) chooseCardAtIndex:(NSUInteger)index
{
    NSUInteger preScore = self.score;
    Card *card = [self cardAtIndex:index];
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            NSMutableArray *otherTwoCards = [[NSMutableArray alloc] init];
            for (Card *otherCard in self.cards) {
                if (!otherCard.isMatched && otherCard.isChosen) {
                    [otherTwoCards addObject:otherCard];
                }
            }
            if ([otherTwoCards count] == 2) {
                NSUInteger matchScore = MAGIC_NUMBER * [self matchTwoChoosenCards:otherTwoCards withCard:card];
                if (matchScore > 0) {
                    self.score += matchScore;
                    ((Card *)otherTwoCards[0]).matched = YES;
                    ((Card *)otherTwoCards[1]).matched = YES;
                    card.matched = YES;
                } else {
                    self.score -= MISMATCH_PENALTY;
                    ((Card *)otherTwoCards[0]).chosen = NO;
                    ((Card *)otherTwoCards[1]).chosen = NO;
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
    NSUInteger postScore = self.score;
    self.gainScore = postScore - preScore + 1;
    self.cardName = card.contents;
}

-(NSUInteger) matchTwoChoosenCards:(NSMutableArray *)otherTwoCards withCard:(Card *)card
{
    NSUInteger score = 0;
    Card *firstCard = otherTwoCards[0];
    Card *secondCard = otherTwoCards[1];
    if ([card match:@[firstCard]] == 1 && [card match:@[secondCard]] == 1) {
        score += 3;
    }
    
    if ([card match:@[firstCard]] == 4 && [card match:@[secondCard]] == 4) {
        score += 12;
    }
    return score;
}

@end
