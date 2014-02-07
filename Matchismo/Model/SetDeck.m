//
//  SetDeck.m
//  Matchismo
//
//  Created by Jawinton Tang on 1/24/14.
//  Copyright (c) 2014 NJU. All rights reserved.
//

#import "SetDeck.h"
#import "SetCard.h"

@implementation SetDeck

- (instancetype)init
{
    self = [super init];
    if (self) {
        for (NSUInteger number = 1; number <= 3; number++) {
            for (NSString *symbol in [SetCard validSymbols]) {
                for (UIColor *shading in [SetCard validShadings]) {
                    for (UIColor *color in [SetCard validColors]) {
                        SetCard *card = [[SetCard alloc] init];
                        card.number = number;
                        card.symbol = symbol;
                        card.shading = shading;
                        card.color = color;
                        [self addCard:card];
                    }
                }
            }
        }
    }
    return self;
}

@end
