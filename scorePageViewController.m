//
//  scorePageViewController.m
//  Pitch It
//
//  Created by heron on 10/10/13.
//  Copyright (c) 2013 heron & minnie. All rights reserved.
//

#define STANDARD_OFFSET		40

#import "scorePageViewController.h"
#import "brain.h"

@interface scorePageViewController ()
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutlet UIImageView *scoreImage;
@property (strong, nonatomic) brain *myBrain;

@property (strong, nonatomic) NSMutableArray *noteImages;
@property (strong, nonatomic) NSMutableArray *keyImages;

@property (strong, nonatomic) IBOutlet UIImageView *noteImage01;
@property (strong, nonatomic) IBOutlet UIImageView *noteImage02;
@property (strong, nonatomic) IBOutlet UIImageView *noteImage03;
@property (strong, nonatomic) IBOutlet UIImageView *noteImage04;
@property (strong, nonatomic) IBOutlet UIImageView *noteImage05;
@property (strong, nonatomic) IBOutlet UIImageView *noteImage06;
@property (strong, nonatomic) IBOutlet UIImageView *noteImage07;
@property (strong, nonatomic) IBOutlet UIImageView *noteImage08;
@property (strong, nonatomic) IBOutlet UIImageView *noteImage09;
@property (strong, nonatomic) IBOutlet UIImageView *noteImage10;

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


@end

@implementation scorePageViewController

// constructures
- (brain *)myBrain {
	if (_myBrain == nil) {
		_myBrain = [[brain alloc] init];
	}
	return _myBrain;
}

- (NSMutableArray *)noteImages {
	if (_noteImages == nil) {
		_noteImages = [[NSMutableArray alloc] init];
		[_noteImages addObject:self.noteImage01];
		[_noteImages addObject:self.noteImage02];
		[_noteImages addObject:self.noteImage03];
		[_noteImages addObject:self.noteImage04];
		[_noteImages addObject:self.noteImage05];
		[_noteImages addObject:self.noteImage06];
		[_noteImages addObject:self.noteImage07];
		[_noteImages addObject:self.noteImage08];
		[_noteImages addObject:self.noteImage09];
		[_noteImages addObject:self.noteImage10];
	}
	
	return _noteImages;
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

// update images
- (void)updateNoteImages {
	for (int i=0 ; i<10 ; i++) {
		NSNumber *noteQuestionNum = (NSNumber *)[self.questions objectAtIndex:i];
		NSInteger noteQuestion = [noteQuestionNum intValue];
		NSNumber *noteUserNumClear = (NSNumber *)[self.userAnswer objectAtIndex:i];
		NSInteger noteUser = [noteUserNumClear intValue] + STANDARD_OFFSET;
		BOOL isSame;
		isSame = [self.myBrain sameNoteOrNot:noteQuestion compareWith:noteUser];
		UIImageView *note = [self.noteImages objectAtIndex:i];
		if (isSame) {
			NSLog(@"[%d] same", i);
			[note setImage:[UIImage imageNamed:@"pppcorrect.png"]];
		} else {
			NSLog(@"[%d] not same", i);
			[note setImage:[UIImage imageNamed:@"pppwrong.png"]];
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
	[self.scoreLabel setText:[[NSString alloc] initWithFormat:@"Score: %d", self.score]];
	
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
