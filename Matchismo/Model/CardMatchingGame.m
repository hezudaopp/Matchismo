//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Jawinton Tang on 1/12/14.
//  Copyright (c) 2014 NJU. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (nonatomic, readwrite) NSUInteger score;
@property (nonatomic, strong) NSMutableArray *cards; // of Cards
@property (nonatomic, readwrite) NSInteger gainScore;
@property (strong, nonatomic, readwrite) NSString *cardNames;
@property (strong, nonatomic, readwrite) NSString *cardName;

@end

@implementation CardMatchingGame

// designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    self.score = 0;
    if (self) {
        for (int i=1; i<=count; i++) {
            Card *randCard = [deck drawRandomCard];
            if (randCard) {
                [self.cards addObject:randCard];
            } else {
                self = nil;
                break;
            }
        }
    }
    return self;
}

- (NSString *)cardNames
{
    return _cardNames ? _cardNames : @"";
}

- (NSString *)cardName
{
    return _cardName ? _cardName : @"";
}

- (void)resetGame
{
    for (Card *card in self.cards) {
        card.chosen = NO;
        card.matched = NO;
    }
    self.score = 0;
    self.cardName = @"";
    self.cardNames = @"";
}

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

static const int MAGIC_NUMBER = 4;
static const int MISMATCH_PENALTY = 2;
static const int COST_TO_CHOOSE = 1;
-(void)chooseCardAtIndex:(NSUInteger)index
{
    NSUInteger preScore = self.score;
    Card *card = [self cardAtIndex:index];
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    NSUInteger score = [card match:@[otherCard]];
                    if (score > 0) {
                        self.score += score * MAGIC_NUMBER;
                        card.matched = YES;
                        otherCard.matched = YES;
                    } else {
                        self.score -= MISMATCH_PENALTY;
                        otherCard.chosen = NO;
                    }
                    break;
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

- (NSString *)infoString
{
    NSString *result;
    if (self.gainScore > 1) {
        self.cardNames = [self.cardNames stringByAppendingString:self.cardName];
        result = [NSString stringWithFormat:@"Matched %@ for %d points.", self.cardNames, self.gainScore];
        self.cardNames = nil;
    } else if (self.gainScore < 0) {
        self.cardNames = [self.cardNames stringByAppendingString:self.cardName];
        result = [NSString stringWithFormat:@"%@ don’t match! %d point penalty!", self.cardNames, self.gainScore];
        self.cardNames = nil;
        self.cardNames = [self.cardNames stringByAppendingString:self.cardName];
    } else if (self.gainScore == 0){
        self.cardNames = [self.cardNames stringByAppendingString:self.cardName];
        result = self.cardNames;
    } else if (self.gainScore == 1){
        self.cardNames = [self.cardNames substringToIndex:[self.cardNames length] - [self.cardName length]];
        result = @"";
    }
    return result;
}

-(Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

@end
