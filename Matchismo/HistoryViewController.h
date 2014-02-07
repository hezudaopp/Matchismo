//
//  HistoryViewController.h
//  Matchismo
//
//  Created by Jawinton Tang on 2/1/14.
//  Copyright (c) 2014 NJU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *historyDisplayTextView;
@property (strong, nonatomic) NSAttributedString *historyText;
@end
