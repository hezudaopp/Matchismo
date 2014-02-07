//
//  SetCard.h
//  Matchismo
//
//  Created by Jawinton Tang on 1/24/14.
//  Copyright (c) 2014 NJU. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (nonatomic) NSUInteger number;
@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) UIColor *shading;
@property (strong, nonatomic) UIColor *color;

+ (NSArray *) validSymbols;
+ (NSArray *) validShadings;
+ (NSArray *) validColors;

@end
