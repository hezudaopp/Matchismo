 //
//  Deck.m
//  Matchismo
//
//  Created by Jawinton Tang on 1/11/14.
//  Copyright (c) 2014 NJU. All rights reserved.
//

#import "Deck.h"

@interface Deck()

@property (strong, nonatomic) NSMutableArray *cards;

@end

@implementation Deck

- (NSMutableArray *) cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (void)addCard:(Card *)card atTop:(BOOL)atTop
{
    if (atTop) {
        [self.cards insertObject:card atIndex:0];
    } else {
        [self.cards addObject:card];
    }
}

- (void)addCard:(Card *)card
{
    [self addCard:card atTop:NO];
}

- (Card *)drawRandomCard
{
    Card *card = Nil;
    if ([self.cards count]) {
        unsigned index = arc4random() % [self.cards count];
        card = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    return card;
}

@end
