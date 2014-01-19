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
- (void)resetGame;
- (NSString *)infoString;

@property (nonatomic, readonly) NSUInteger score;
@property (nonatomic, readonly) NSInteger gainScore;
@property (strong, nonatomic, readonly) NSString *cardName;
@property (strong, nonatomic, readonly) NSString *cardNames;

@end
