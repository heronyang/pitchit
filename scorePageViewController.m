//
//  scorePageViewController.m
//  Pitch It
//
//  Created by heron on 10/10/13.
//  Copyright (c) 2013 heron & minnie. All rights reserved.
//

#define STANDARD_OFFSET		40

#import "scorePageViewController.h"
#import "stageOneViewController.h"
#import "brain.h"
#import "musicNotePlayer.h"

@interface scorePageViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *scoreImage;
@property (strong, nonatomic) brain *myBrain;

@property (strong, nonatomic) NSMutableArray *noteImages;
@property (strong, nonatomic) NSMutableArray *keyImages;
@property (strong, nonatomic) NSMutableArray *noteButtons;

@property (strong, nonatomic) musicNotePlayer *myPlayer;

@property (strong, nonatomic) IBOutlet UIImageView *keyImage01;
@property (strong, nonatomic) IBOutlet UIImageView *keyImage02;
@property (strong, nonatomic) IBOutlet UIImageView *keyImage03;
@property (strong, nonatomic) IBOutlet UIImageView *keyImage04;
@property (strong, nonatomic) IBOutlet UIImageView *keyImage05;
@property (strong, nonatomic) IBOutlet UIImageView *keyImage06;
@property (strong, nonatomic) IBOutlet UIImageView *keyImage07;
@property (strong, nonatomic) IBOutlet UIImageView *keyImage08;
@property (strong, nonatomic) IBOutlet UIImageView *keyImage09;
@property (strong, nonatomic) IBOutlet UIImageView *keyImage10;

@property (strong, nonatomic) IBOutlet UIButton *noteButton01;
@property (strong, nonatomic) IBOutlet UIButton *noteButton02;
@property (strong, nonatomic) IBOutlet UIButton *noteButton03;
@property (strong, nonatomic) IBOutlet UIButton *noteButton04;
@property (strong, nonatomic) IBOutlet UIButton *noteButton05;
@property (strong, nonatomic) IBOutlet UIButton *noteButton06;
@property (strong, nonatomic) IBOutlet UIButton *noteButton07;
@property (strong, nonatomic) IBOutlet UIButton *noteButton08;
@property (strong, nonatomic) IBOutlet UIButton *noteButton09;
@property (strong, nonatomic) IBOutlet UIButton *noteButton10;

@end

@implementation scorePageViewController

// constructures
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

- (NSMutableArray *)keyImages {
	if (_keyImages == nil) {
		_keyImages = [[NSMutableArray alloc] init];
		[_keyImages addObject:self.keyImage01];
		[_keyImages addObject:self.keyImage02];
		[_keyImages addObject:self.keyImage03];
		[_keyImages addObject:self.keyImage04];
		[_keyImages addObject:self.keyImage05];
		[_keyImages addObject:self.keyImage06];
		[_keyImages addObject:self.keyImage07];
		[_keyImages addObject:self.keyImage08];
		[_keyImages addObject:self.keyImage09];
		[_keyImages addObject:self.keyImage10];
	}
	
	return _keyImages;
}

- (NSMutableArray *)noteButtons {
	if (_noteButtons == nil) {
		_noteButtons = [[NSMutableArray alloc] init];
		[_noteButtons addObject:self.noteButton01];
		[_noteButtons addObject:self.noteButton02];
		[_noteButtons addObject:self.noteButton03];
		[_noteButtons addObject:self.noteButton04];
		[_noteButtons addObject:self.noteButton05];
		[_noteButtons addObject:self.noteButton06];
		[_noteButtons addObject:self.noteButton07];
		[_noteButtons addObject:self.noteButton08];
		[_noteButtons addObject:self.noteButton09];
		[_noteButtons addObject:self.noteButton10];
	}
	
	return _noteButtons;
}

// update images
- (void)updateNoteImages {
	for (int i=0 ; i<10 ; i++) {
		NSNumber *noteQuestionNum = (NSNumber *)[self.questions objectAtIndex:i];
		NSInteger noteQuestion = [noteQuestionNum intValue];
		NSNumber *noteUserNumClear = (NSNumber *)[self.userAnswer objectAtIndex:i];
		NSInteger noteUser = [noteUserNumClear intValue] + STANDARD_OFFSET;
		BOOL isSame;
		isSame = [self.myBrain sameNoteOrNot:noteQuestion compareWith:noteUser];
		//UIImageView *note = [self.noteImages objectAtIndex:i];
		UIButton *noteButton = [self.noteButtons objectAtIndex:i];
		UIImage *correct = [UIImage imageNamed:@"pppcorrect.png"];
		UIImage *wrong = [UIImage imageNamed:@"pppwrong.png"];
		if (isSame) {
			NSLog(@"[%d] same", i);
			//[note setImage:[UIImage imageNamed:@"pppcorrect.png"]];
			//[noteButton setImage:[UIImage imageNamed:@"pppcorrect.png"] forState:UIControlStateNormal];
			[noteButton setBackgroundImage:correct forState:UIControlStateNormal];
		} else {
			NSLog(@"[%d] not same", i);
			//[note setImage:[UIImage imageNamed:@"pppwrong.png"]];
			//[noteButton setImage:[UIImage imageNamed:@"pppwrong.png"] forState:UIControlStateNormal];
			[noteButton setBackgroundImage:wrong forState:UIControlStateNormal];
		}
	}
	//NSLog(self.questions);
}

- (void)updateKeyImages {
	for (int i=0 ; i<10 ; i++) {
		NSNumber *noteQuestionNum = (NSNumber *)[self.questions objectAtIndex:i];
		NSInteger noteQuestion = [noteQuestionNum intValue];
		NSString *imageFileName = [[NSString alloc] initWithFormat:@"%d.png", (noteQuestion+8)%12];
		NSLog(@"filename >> %@", imageFileName);
		UIImageView *key = [self.keyImages objectAtIndex:i];
		[key setImage:[UIImage imageNamed:imageFileName]];
	}
}

- (void)updateScoreImage {
	NSString *imageFileName = [[NSString alloc] initWithFormat:@"%d_percentage.png", self.score];
	[self.scoreImage setImage:[UIImage imageNamed:imageFileName]];
}

// event handlers
- (IBAction)retryPressed:(UIButton *)sender {
	[self performSegueWithIdentifier:@"retry" sender:self];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"retry"]) {
        stageOneViewController *dest= [segue destinationViewController];
        dest.stage = self.selectedStage;
		//NSLog(@"stage = %d", self.selectedStage);
    }
}

- (IBAction)notePlayPressed:(UIButton *)sender {
	NSInteger noteNum = sender.tag;
	NSLog(@"%@ is pressed", [self.questions objectAtIndex:noteNum]);
	NSInteger questionNoteNum = [[self.questions objectAtIndex:noteNum] intValue];
	[self.myPlayer playNote:questionNoteNum];
}

//
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	
	[self updateNoteImages];
	[self updateKeyImages];
	[self updateScoreImage];
}

- (IBAction)playAgainButtonPressed:(UIButton *)sender {
	[self performSegueWithIdentifier:@"restart" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
