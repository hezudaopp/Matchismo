//
//  PlayCard.m
//  Matchismo
//
//  Created by Jawinton Tang on 1/11/14.
//  Copyright (c) 2014 NJU. All rights reserved.
//

#import "PlayCard.h"

@implementation PlayCard

- (NSString *) contents
{
    return [[PlayCard rankStrings][self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

- (NSString *) suit
{
    return _suit ? _suit : @"?";
}

- (void) setSuit:(NSString *) suit
{
    if ([[PlayCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

+ (NSArray *) validSuits
{
    return @[@"♠︎", @"♥︎", @"♣︎", @"♦︎"];
}

+ (NSArray *) rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8",@"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger) maxRank
{
    return [[self rankStrings] count] - 1;
}

- (void) setRank:(NSUInteger)rank
{
    if (rank <= [PlayCard maxRank]) {
        _rank = rank;
    }
}

@end
