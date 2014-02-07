//
//  SetThreeCardMatchingGame.m
//  Matchismo
//
//  Created by Jawinton Tang on 1/24/14.
//  Copyright (c) 2014 NJU. All rights reserved.
//

#import "SetThreeCardMatchingGame.h"

@implementation SetThreeCardMatchingGame

-(NSUInteger) matchTwoChoosenCards:(NSMutableArray *)otherTwoCards withCard:(Card *)card
{
    NSUInteger score = 0;
    Card *firstCard = otherTwoCards[0];
    Card *secondCard = otherTwoCards[1];
    int firstMatchScore = [card match:@[firstCard]];
    int secondMatchScore = [card match:@[secondCard]];
    int thirdMatchScore = [firstCard match:@[secondCard]];
    
    bool isNumberMatch = ((firstMatchScore & secondMatchScore & thirdMatchScore & 0x1000) == 0x1000) || ((firstMatchScore | secondMatchScore | thirdMatchScore) & 0x1000) == 0x0000;
    bool isSymbolMatch = ((firstMatchScore & secondMatchScore & thirdMatchScore & 0x0100) == 0x0100) || ((firstMatchScore | secondMatchScore | thirdMatchScore) & 0x0100) == 0x0000;
    bool isShadingMatch = ((firstMatchScore & secondMatchScore & thirdMatchScore & 0x0010) == 0x0010) || ((firstMatchScore | secondMatchScore | thirdMatchScore) & 0x0010) == 0x0000;
    bool isColorMatch = ((firstMatchScore & secondMatchScore & thirdMatchScore & 0x0001) == 0x0001) || ((firstMatchScore | secondMatchScore | thirdMatchScore) & 0x0001) == 0x0000;
    if (isNumberMatch && isSymbolMatch && isShadingMatch &&isColorMatch) {
        score += 20;
    }
    return score;
}

@end
