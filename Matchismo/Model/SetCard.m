//
//  SetCard.m
//  Matchismo
//
//  Created by Jawinton Tang on 1/24/14.
//  Copyright (c) 2014 NJU. All rights reserved.
//

#import "SetCard.h"

@interface SetCard()

@end

@implementation SetCard


- (NSString *) contents
{
    NSMutableString *result = [[NSMutableString alloc] init];
    for (int i=0; i < self.number; i++) {
        [result appendString:self.symbol];
    }
    return result;
}

@synthesize number = _number;
@synthesize symbol = _symbol;
@synthesize shading = _shading;
@synthesize color = _color;

- (NSUInteger) number
{
    return _number ? _number : 0;
}

- (NSString *) symbol
{
    return _symbol ? _symbol : @"?";
}

- (UIColor *) _shading
{
    return _shading ? _shading : nil;
}

- (UIColor *) _color
{
    return _color ? _color : nil;
}

- (void) setNumber:(NSUInteger) number
{
    for (NSUInteger i = 1; i <= 3; i++) {
        if (i == number) {
            _number = i;
        }
    }
}

- (void) setSymbol:(NSString *)symbol
{
    if ([[SetCard validSymbols] containsObject:symbol]) {
        _symbol = symbol;
    }
}

- (void) setShading:(UIColor *)shading
{
    if ([[SetCard validShadings] containsObject:shading]) {
        _shading = shading;
    }
}

- (void) setColor:(UIColor *)color
{
    if ([[SetCard validColors] containsObject:color]) {
        _color = color;
    }
}

+ (NSArray *) validSymbols
{
    return @[@"▲", @"◼︎", @"●"];
}

+ (NSArray *) validShadings
{
    return @[[UIColor redColor], [UIColor greenColor], [UIColor blueColor]];
}

+ (NSArray *) validColors
{
    return @[[UIColor purpleColor], [UIColor yellowColor], [UIColor orangeColor]];
}

- (int) match:(NSArray *)others
{
    int matchResult = 0x0000;
    id obj = [others firstObject];
    if ([obj isKindOfClass:[SetCard class]]) {
        SetCard *other = (SetCard *)obj;
        if (self.number == other.number) {
            matchResult |= 0x1000;
        }
        if ([self.symbol isEqualToString:other.symbol]) {
            matchResult |= 0x0100;
        }
        if ([self.shading isEqual:(UIColor *)other.shading]) {
            matchResult |= 0x0010;
        }
        if ([self.color isEqual:(UIColor *)other.color]) {
            matchResult |= 0x0001;
        }
    }
    return matchResult;
}

@end
