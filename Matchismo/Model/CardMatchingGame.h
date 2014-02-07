//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Jawinton Tang on 1/12/14.
//  Copyright (c) 2014 NJU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;
- (NSArray *) getChosenCards;
- (void) removeAllObjectsFromChosenCardsStack;
- (void) addObjectToChosenCardsStack:(Card *)card;
//- (NSString *)infoString;
- (void) appendStringToHistory:(NSString *) string;
- (void) appendAttributedStringToHistory:(NSAttributedString *) attributedString;

@property (nonatomic, readonly) NSUInteger score;
@property (nonatomic, readonly) NSInteger gainScore;
@property (strong, nonatomic, readonly) NSString *cardName;
@property (strong, nonatomic, readonly) NSString *cardNames;
@property (strong, nonatomic, readonly) NSMutableArray *chosenCardsStack;
@property (strong, nonatomic, readonly) NSMutableAttributedString *history;

@end
