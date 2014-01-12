//
//  Card.h
//  Matchismo
//
//  Created by Jawinton Tang on 1/11/14.
//  Copyright (c) 2014 NJU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic, getter = isMatched) BOOL matched;

-(int) match:(NSArray *)others;

@end
