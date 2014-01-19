//
//  PlayDeck.m
//  Matchismo
//
//  Created by Jawinton Tang on 1/11/14.
//  Copyright (c) 2014 NJU. All rights reserved.
//

#import "PlayDeck.h"
#import "PlayCard.h"

@implementation PlayDeck

- (instancetype)init
{
    self = [super init];
    if (self) {
        for (NSString *suit in [PlayCard validSuits]) {
            for (NSUInteger rank = 1; rank <= [PlayCard maxRank]; rank++) {
                PlayCard *card = [[PlayCard alloc] init];
                card.suit = suit;
                card.rank = rank;
                [self addCard:card];
            }
        }
    }
    return self;
}

@end
