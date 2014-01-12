//
//  Card.m
//  Matchismo
//
//  Created by Jawinton Tang on 1/11/14.
//  Copyright (c) 2014 NJU. All rights reserved.
//

#import "Card.h"

@implementation Card

-(int) match:(NSArray *)others
{
    int result = 0;
    for (Card *that in others) {
        if ([that.contents isEqualToString:self.contents]) {
            result = 1;
            continue;
        }
    }
    return result;
}

@end
