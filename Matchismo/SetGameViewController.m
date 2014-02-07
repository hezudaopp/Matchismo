//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Jawinton Tang on 1/24/14.
//  Copyright (c) 2014 NJU. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetDeck.h"
#import "SetCard.h"
#import "SetThreeCardMatchingGame.h"

@interface SetGameViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@end

@implementation SetGameViewController
- (IBAction)TouchResetButton:(UIButton *)sender {
    self.game = nil;
    [self initView];
    [self updateUI];
}


- (IBAction)TouchCardButton:(UIButton *)sender {
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
    [self.game appendAttributedStringToHistory:self.infoLabel.attributedText];
    [self.game appendStringToHistory:@"\n"];
}

- (void) updateUI
{
    for (UIButton *button in self.cardButtons) {
        NSUInteger buttonIndex = [self.cardButtons indexOfObject:button];
        Card *card = [self.game cardAtIndex:buttonIndex];
        if (!card.isMatched && card.isChosen) {
            button.layer.borderWidth = 3;
        } else {
            button.layer.borderWidth = 0;
        }
        button.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score : %d", self.game.score];
    NSUInteger chosenCardsCount = [self.game.chosenCardsStack count];
    if (chosenCardsCount == 0) {
        [self.infoLabel setAttributedText:[[NSAttributedString alloc] initWithString:@""]];
    } else if (chosenCardsCount == 1) {
        [self.infoLabel setAttributedText:[self getAttributedStringFromCard:[self.game.chosenCardsStack firstObject]]];
    } else if (chosenCardsCount == 2) {
        NSMutableAttributedString *info = [[NSMutableAttributedString alloc] init];
        [info appendAttributedString:[self getAttributedStringFromCard:[self.game.chosenCardsStack firstObject]]];
        [info appendAttributedString:[[NSAttributedString alloc] initWithString:@"&"]];
        [info appendAttributedString:[self getAttributedStringFromCard:self.game.chosenCardsStack[1]]];
        [self.infoLabel setAttributedText:info];
    } else if (chosenCardsCount == 3) {
        NSMutableAttributedString *info = [[NSMutableAttributedString alloc] init];
        [info appendAttributedString:[self getAttributedStringFromCard:[self.game.chosenCardsStack firstObject]]];
        [info appendAttributedString:[[NSAttributedString alloc] initWithString:@"&"]];
        [info appendAttributedString:[self getAttributedStringFromCard:self.game.chosenCardsStack[1]]];
        [info appendAttributedString:[[NSAttributedString alloc] initWithString:@"&"]];
        [info appendAttributedString:[self getAttributedStringFromCard:self.game.chosenCardsStack[2]]];
        [self.game removeAllObjectsFromChosenCardsStack];
        if (((Card *)[self getAttributedStringFromCard:[self.game.chosenCardsStack firstObject]]).isMatched) {
            [info appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" matched! %d points gained.", self.game.gainScore]]];
            [self.infoLabel setAttributedText:info];
        } else {
            [info appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" mismatched! %d points penalty.", -self.game.gainScore]]];
            [self.infoLabel setAttributedText:info];
            [self.game addObjectToChosenCardsStack:[[self.game getChosenCards] firstObject]];
        }
    }
}

- (Deck *) createDeck
{
    return [[SetDeck alloc] init];
}

- (CardMatchingGame *) createCardMatchingGame
{
    return [self createCardMatchingGameWithCardButtonsCounts:[self.cardButtons count]];
}

- (CardMatchingGame *)createCardMatchingGameWithCardButtonsCounts:(NSUInteger)count
{
    return [[SetThreeCardMatchingGame alloc] initWithCardCount:count usingDeck:[self createDeck]];
}

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
    [self initView];
}

- (void) initView
{
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger buttonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:buttonIndex];
        if ([card isKindOfClass:[SetCard class]]) {
            SetCard *setCard = (SetCard *)[self.game cardAtIndex:buttonIndex];
            [self setupCardButtonAtrributions:cardButton forCard:setCard];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setupCardButtonAtrributions:(UIButton *)cardButton forCard:(SetCard *)setCard
{
    NSAttributedString *attributedTitle = [self getAttributedStringFromCard:setCard];
    [cardButton setAttributedTitle:attributedTitle forState:UIControlStateNormal];
    cardButton.layer.borderColor = [UIColor blueColor].CGColor;
}

- (NSAttributedString *) getAttributedStringFromCard:(SetCard *)setCard
{
    if (setCard) {
        return [[NSAttributedString alloc]
                initWithString:setCard.contents
                attributes:@{NSForegroundColorAttributeName:setCard.color,
                             NSStrokeWidthAttributeName:@-5,
                             NSStrokeColorAttributeName:setCard.shading,
                             NSFontAttributeName:[UIFont boldSystemFontOfSize:20]}];

    }
    return nil;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [super prepareForSegue:segue sender:sender];
}

@end
