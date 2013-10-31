//
//  stageOneViewController.m
//  Pitch It
//
//  Created by heng shumin on 13/9/24.
//  Copyright (c) 2013年 heron & minnie. All rights reserved.
//

#import "stageOneViewController.h"
#import "musicNotePlayer.h"
#import "scorePageViewController.h"
#import "brain.h"

#define STANDARD_OFFSET		40
#define RECORD_SIGN_WIDTH	15
#define RECORD_SIGN_HEIGHT	30
#define REST_DIST			25
#define REST_OFFSET			30

#define STATE_EMPTY			0
#define STATE_CORRECT		1
#define STATE_WRONG			2

#define NUMBER_QUESTIONS	10

@interface stageOneViewController ()

@property (strong, nonatomic) brain *myBrain;

@property (nonatomic)	NSInteger magicNoteNumber;
@property (strong, nonatomic) musicNotePlayer *myPlayer;
@property (strong, nonatomic) IBOutlet UILabel *debugLabel;
@property (strong, nonatomic) NSMutableArray *recordSignsArray;
@property (nonatomic)	NSInteger currentIndex;

@property (nonatomic)	NSInteger score;

@property (strong, nonatomic)	NSMutableArray *questions;
@property (strong, nonatomic)	NSMutableArray *userAnswer;

@property (strong, nonatomic) IBOutlet UIButton *whiteKey1;
@property (strong, nonatomic) IBOutlet UIButton *whiteKey2;
@property (strong, nonatomic) IBOutlet UIButton *whiteKey3;
@property (strong, nonatomic) IBOutlet UIButton *whiteKey4;
@property (strong, nonatomic) IBOutlet UIButton *whiteKey5;
@property (strong, nonatomic) IBOutlet UIButton *whiteKey6;
@property (strong, nonatomic) IBOutlet UIButton *whiteKey7;

@end

@implementation stageOneViewController

// getter, constructor
- (brain *)myBrain {
	if (_myBrain == nil) {
		_myBrain = [[brain alloc] init];
	}
	return _myBrain;
}

- (musicNotePlayer *)myPlayer {
    if (_myPlayer == nil) {
        _myPlayer = [[musicNotePlayer alloc] init];
    }
    return _myPlayer;
}

- (NSMutableArray *)recordSignsArray {
	if (_recordSignsArray == nil) {
		_recordSignsArray = [[NSMutableArray alloc] init];
	}
	return _recordSignsArray;
}

- (NSMutableArray *)questions {
	if (_questions == nil) {
		_questions = [[NSMutableArray alloc] init];
	}
	return _questions;
}

- (NSMutableArray *)userAnswer {
	if (_userAnswer == nil) {
		_userAnswer = [[NSMutableArray alloc] init];
	}
	return _userAnswer;
}

#pragma view loading relate
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
	NSLog(@"we're here");
    [super viewDidLoad];
	// Do any additional setup after loading the view.

	[self drawRecordSigns];
	self.currentIndex = 0;
	self.score = 0;
	
	//
	[self setupKeys];
	
	[self refreshMagicNoteNumber];
	[self.myPlayer playNote:self.magicNoteNumber];
}

- (void)setupKeys {
	UIImage *pressedWhiteKey = [UIImage imageNamed:@"pressed_white_key.png"];
	UIImage *whiteKey = [UIImage imageNamed:@"white_key.png"];
	//UIImage *clearImage = [UIImage imageNamed:@"clear.png"];
	self.whiteKey1.adjustsImageWhenHighlighted = NO;
	self.whiteKey1.showsTouchWhenHighlighted = NO;
	[self.whiteKey1 setBackgroundImage:pressedWhiteKey forState:UIControlStateSelected | UIControlStateHighlighted];
	[self.whiteKey2 setBackgroundImage:pressedWhiteKey forState:UIControlStateSelected | UIControlStateHighlighted];
	[self.whiteKey3 setBackgroundImage:pressedWhiteKey forState:UIControlStateSelected | UIControlStateHighlighted];
	[self.whiteKey4 setBackgroundImage:pressedWhiteKey forState:UIControlStateSelected | UIControlStateHighlighted];
	[self.whiteKey5 setBackgroundImage:pressedWhiteKey forState:UIControlStateSelected | UIControlStateHighlighted];
	[self.whiteKey6 setBackgroundImage:pressedWhiteKey forState:UIControlStateSelected | UIControlStateHighlighted];
	[self.whiteKey7 setBackgroundImage:pressedWhiteKey forState:UIControlStateSelected | UIControlStateHighlighted];
	
	[self.whiteKey1 setBackgroundImage:pressedWhiteKey forState:UIControlStateSelected];
	[self.whiteKey2 setBackgroundImage:pressedWhiteKey forState:UIControlStateSelected];
	[self.whiteKey3 setBackgroundImage:pressedWhiteKey forState:UIControlStateSelected];
	[self.whiteKey4 setBackgroundImage:pressedWhiteKey forState:UIControlStateSelected];
	[self.whiteKey5 setBackgroundImage:pressedWhiteKey forState:UIControlStateSelected];
	[self.whiteKey6 setBackgroundImage:pressedWhiteKey forState:UIControlStateSelected];
	[self.whiteKey7 setBackgroundImage:pressedWhiteKey forState:UIControlStateSelected];
	
	[self.whiteKey1 setBackgroundImage:whiteKey forState:UIControlStateNormal];
	[self.whiteKey2 setBackgroundImage:whiteKey forState:UIControlStateNormal];
	[self.whiteKey3 setBackgroundImage:whiteKey forState:UIControlStateNormal];
	[self.whiteKey4 setBackgroundImage:whiteKey forState:UIControlStateNormal];
	[self.whiteKey5 setBackgroundImage:whiteKey forState:UIControlStateNormal];
	[self.whiteKey6 setBackgroundImage:whiteKey forState:UIControlStateNormal];
	[self.whiteKey7 setBackgroundImage:whiteKey forState:UIControlStateNormal];
}

#pragma draw ten record signs on the screen
- (void)drawRecordSigns {
	for (int i=1 ; i<=NUMBER_QUESTIONS ; i++) {
		UIImage *image = [UIImage imageNamed:@"pppempty.png"];
		CGRect frame = CGRectMake(i*REST_DIST + REST_OFFSET, 35, RECORD_SIGN_WIDTH, RECORD_SIGN_HEIGHT);
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
		[imageView setImage:image];
		[self.view addSubview:imageView];
		[self.recordSignsArray addObject:imageView];
	}
}

- (void)changeRecord:(NSInteger)index toState:(NSInteger)state {
	UIImageView *currentImageView = [self.recordSignsArray objectAtIndex:index];
	switch (state) {
		case STATE_EMPTY:
			[currentImageView setImage:[UIImage imageNamed:@"pppempty.png"]];
			break;
		case STATE_CORRECT:
			[currentImageView setImage:[UIImage imageNamed:@"pppcorrect.png"]];
			break;
		case STATE_WRONG:
			[currentImageView setImage:[UIImage imageNamed:@"pppwrong.png"]];
			break;
			
		default:
			NSLog(@"error in changeRecord");
			break;
	}
}

#pragma event handler
- (IBAction)keyPressed:(UIButton *)sender {
	NSInteger keyNumber = ((UIView*)sender).tag;
	NSLog(@"key number >> %d", keyNumber);
	
	[self.myPlayer playNote:(STANDARD_OFFSET+keyNumber)];
	
	// check if they are the same
	if ([self.myBrain sameNoteOrNot:(STANDARD_OFFSET+keyNumber) compareWith:self.magicNoteNumber]) {
		NSLog(@"current");
		[self changeRecord:self.currentIndex toState:STATE_CORRECT];
		self.score += 10;
	} else {
		NSLog(@"wrong");
		[self changeRecord:self.currentIndex toState:STATE_WRONG];
	}
	
	// stores the records including the current answer and the user's answer
	[self.userAnswer addObject:[NSNumber numberWithInt:keyNumber]];
	[self.questions addObject:[NSNumber numberWithInt:self.magicNoteNumber]];
	
	// for next question
	self.currentIndex += 1;
	if (self.currentIndex >= NUMBER_QUESTIONS) {
		NSLog(@"game ends");
		[self performSegueWithIdentifier:@"showScore" sender:self];
	}
	[self refreshMagicNoteNumber];
}

- (IBAction)playMagicNote:(UIButton *)sender {
	[self.myPlayer playNote:self.magicNoteNumber];
}

#pragma tools
- (void)refreshMagicNoteNumber {
	NSLog(@"stage >> %d", self.stage);
	
	NSInteger magicNoteNumberTmp = self.magicNoteNumber;
	do {
		switch (self.stage) {
		case 1:
			self.magicNoteNumber = arc4random()%12 + 40;
			break;
		case 2:
			self.magicNoteNumber = arc4random()%(12*2) + 28;
			break;
		case 3:
			self.magicNoteNumber = arc4random()%(12*4) + 16;
			break;
		default:
			self.magicNoteNumber = 40;
			NSLog(@"error!");
			break;
		}
	} while (self.magicNoteNumber == magicNoteNumberTmp);
	
	NSLog(@"new magic note number >> %d", self.magicNoteNumber);
	[self.debugLabel setText:[self.myBrain noteNumberToText:self.magicNoteNumber]];
}

/*
- (NSString *)noteNumberToText:(NSInteger)noteNumber {
	NSArray *noteTextArr = [NSArray arrayWithObjects: @"C", @"C#/Db", @"D", @"D#/Eb", @"E", @"F", @"F#/Gb", @"G", @"G#/Ab", @"A", @"A#/Bb", @"B", nil];
	return [noteTextArr objectAtIndex:((noteNumber-4)%12)];
}


- (BOOL)sameNoteOrNot:(NSInteger)note1 compareWith:(NSInteger)note2 {
	NSLog(@"note1 >> %d\tnote2 >> %d", note1, note2);
	return ((note1-note2) % 12) == 0;
}
 */

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"showScore"]) {
        scorePageViewController *dest= [segue destinationViewController ];
        dest.score = self.score;
		dest.questions = self.questions;
		dest.userAnswer = self.userAnswer;
		dest.selectedStage = self.stage;
    }
}
- (IBAction)goBack:(UIButton *)sender {
	[self performSegueWithIdentifier:@"backMenu" sender:self];
}

#pragma memory
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
