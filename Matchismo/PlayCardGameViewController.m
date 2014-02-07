//
//  PlayCardGameViewController.m
//  Matchismo
//
//  Created by Jawinton Tang on 1/24/14.
//  Copyright (c) 2014 NJU. All rights reserved.
//

#import "PlayCardGameViewController.h"
#import "PlayDeck.h"
#import "ThreeCardMatchingGame.h"

@interface PlayCardGameViewController ()

//@property (weak, nonatomic) IBOutlet UILabel *FlipLabel;
//@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
//@property (weak, nonatomic) IBOutlet UISegmentedControl *matchModelSegmentedControl;
//@property (nonatomic) NSUInteger matchModelSegmentedIndex;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (strong, nonatomic) NSMutableString *info;


@end

@implementation PlayCardGameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (Deck *) createDeck
{
    return [[PlayDeck alloc] init];
}

- (CardMatchingGame *) createCardMatchingGame
{
    return [self createCardMatchingGameWithCardButtonsCounts:[self.cardButtons count]];
}

- (void) updateUI
{
    for (UIButton *button in self.cardButtons) {
        NSUInteger buttonIndex = [self.cardButtons indexOfObject:button];
        Card *card = [self.game cardAtIndex:buttonIndex];
        [button setTitle:[self titleForCard:card]
                forState:UIControlStateNormal];
        [button setBackgroundImage:[self backgroundImageForCard:card]
                          forState:UIControlStateNormal];
        button.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    NSUInteger chosenCardsCount = [self.game.chosenCardsStack count];
    if (chosenCardsCount == 0) {
        self.infoLabel.text = @"";
    } else if (chosenCardsCount == 1) {
        self.infoLabel.text = ((Card *)[self.game.chosenCardsStack firstObject]).contents;
    } else if (chosenCardsCount == 2) {
        if (((Card *)[self.game.chosenCardsStack firstObject]).isMatched) {
            self.infoLabel.text = [NSString stringWithFormat:@"%@ %@ matched! %d points gained!", ((Card *)[self.game.chosenCardsStack firstObject]).contents, ((Card *)self.game.chosenCardsStack[1]).contents, self.game.gainScore];
            [self.game removeAllObjectsFromChosenCardsStack];
        } else {
            self.infoLabel.text = [NSString stringWithFormat:@"%@ %@ mismatched! %d points penalty!", ((Card *)[self.game.chosenCardsStack firstObject]).contents, ((Card *)self.game.chosenCardsStack[1]).contents, -self.game.gainScore];
            [self.game removeAllObjectsFromChosenCardsStack];
            [self.game addObjectToChosenCardsStack:[[self.game getChosenCards] firstObject]];
        }
    }
//    [self setFlipCount:self.flipCount];
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"CardFront" : @"CardBack"];
}

- (CardMatchingGame *)createCardMatchingGameWithCardButtonsCounts:(NSUInteger)count
{
//    if (self.matchModelSegmentedIndex == 0) {
//        return [[CardMatchingGame alloc] initWithCardCount:count usingDeck:[self createDeck]];
//    } else {
//        return [[ThreeCardMatchingGame alloc] initWithCardCount:count usingDeck:[self createDeck]];
//    }
    return [[CardMatchingGame alloc] initWithCardCount:count usingDeck:[self createDeck]];
}

- (IBAction)TouchCardButton:(UIButton *)sender
{
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
    [self.game appendAttributedStringToHistory:self.infoLabel.attributedText];
    [self.game appendStringToHistory:@"\n"];
//    self.matchModelSegmentedControl.enabled = NO;
//    self.flipCount++;
}

- (IBAction)TouchResetButton:(UIButton *)sender {
//    self.flipCount = 0;
    self.game = nil;
    [self updateUI];
//    self.matchModelSegmentedControl.enabled = YES;
}

//- (IBAction)MatchModelValueChanged:(UISegmentedControl *)sender {
//    self.game = nil;
//    self.matchModelSegmentedIndex = [sender selectedSegmentIndex];
//    [self updateUI];
//}

//- (void)setFlipCount:(int)flipCount
//{
//    _flipCount = flipCount;
//    [self.FlipLabel setText:[NSString stringWithFormat:
//                             @"Flips: %d",flipCount]];
//}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [super prepareForSegue:segue sender:sender];
}

@end
