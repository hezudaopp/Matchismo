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
@property (strong, nonatomic, readwrite) NSMutableArray *chosenCardsStack;
@property (strong, nonatomic, readwrite) NSMutableAttributedString *history;


@end

@implementation CardMatchingGame

// designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    self.score = 0;
    self.chosenCardsStack = [[NSMutableArray alloc] init];
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

- (NSMutableAttributedString *)history
{
    if (!_history) _history = [[NSMutableAttributedString alloc] init];
    return _history;
}

- (void) appendAttributedStringToHistory:(NSAttributedString *) attributedString
{
    [self.history appendAttributedString:attributedString];
}

- (void) appendStringToHistory:(NSString *) string
{
    [self.history appendAttributedString:[[NSAttributedString alloc] initWithString:string]];
}

- (NSString *)cardNames
{
    return _cardNames ? _cardNames : @"";
}

- (NSString *)cardName
{
    return _cardName ? _cardName : @"";
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
            [self.chosenCardsStack removeObject:card];
            card.chosen = NO;
        } else {
            [self.chosenCardsStack addObject:card];
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

//- (NSString *)infoString
//{
//    NSString *result;
//    if (self.gainScore > 1) {
//        self.cardNames = [self.cardNames stringByAppendingString:self.cardName];
//        result = [NSString stringWithFormat:@"Matched %@ for %d points.", self.cardNames, self.gainScore];
//        self.cardNames = nil;
//    } else if (self.gainScore < 0) {
//        self.cardNames = [self.cardNames stringByAppendingString:self.cardName];
//        result = [NSString stringWithFormat:@"%@ don’t match! %d point penalty!", self.cardNames, self.gainScore];
//        self.cardNames = nil;
//        self.cardNames = [self.cardNames stringByAppendingString:self.cardName];
//    } else if (self.gainScore == 0){
//        self.cardNames = [self.cardNames stringByAppendingString:self.cardName];
//        result = self.cardNames;
//    } else if (self.gainScore == 1){
//        self.cardNames = [self.cardNames substringToIndex:[self.cardNames length] - [self.cardName length]];
//        result = @"";
//    }
//    return result;
//}

-(Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (NSArray *) getChosenCards
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (Card *card in self.cards) {
        if (!card.isMatched && card.isChosen) {
            [result addObject:card];
        }
    }
    return result;
}

- (void) removeAllObjectsFromChosenCardsStack
{
    [self.chosenCardsStack removeAllObjects];
}

- (void) addObjectToChosenCardsStack:(Card *)card
{
    if (card) {
        [self.chosenCardsStack addObject:card];
    }
}

@end
