//
//  MENUViewController.m
//  Pitch It
//
//  Created by heng shumin on 13/9/24.
//  Copyright (c) 2013年 heron & minnie. All rights reserved.
//

#import "MENUViewController.h"
#import "stageOneViewController.h"

#define WIDTH	200
#define HEIGHT	200
#define X		160
#define Y		200

#define LIMIE_SCALE		15
#define START_SHIFTING	10

@interface MENUViewController ()
@property (weak, nonatomic)	IBOutlet	UIButton *start;
@property (strong, nonatomic)			UIImageView *backgroundImage;
@property (strong, nonatomic)			NSTimer *myTimer;
@property (nonatomic)					float currentScale;
@property (nonatomic)					NSInteger selectedStage;

@property (nonatomic)					float yOffset;

@end

@implementation MENUViewController

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
	
	self.yOffset = Y;
	[self loadBackgroundImage];
	[self startAnimation];
}

- (void)loadBackgroundImage {
	self.backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(X, self.yOffset, WIDTH, HEIGHT)];
    self.backgroundImage.image=[UIImage imageNamed:@"largeBackground.png"];
    [self.view addSubview:self.backgroundImage];
}

- (void)startAnimation {
	self.myTimer = [NSTimer scheduledTimerWithTimeInterval:0.01
													target:self
												  selector:@selector(moving:)
												  userInfo:nil
												   repeats:YES];
}

- (void)resizeImage:(float)scale{
	UIImage *original = self.backgroundImage.image;
	UIImage *smallImage = [UIImage imageWithCGImage:original.CGImage scale:scale orientation:original.imageOrientation];
	
	[self.backgroundImage setImage:smallImage];
	[self.backgroundImage setFrame:CGRectMake(X - WIDTH * scale / 2.0, self.yOffset - HEIGHT * scale / 2.0, WIDTH * scale, HEIGHT * scale)];
	[self.backgroundImage setNeedsDisplay];
}

- (void)moving:(NSTimer *)timer{
	[self resizeImage:self.currentScale];
	self.currentScale += 0.02;
	NSLog(@"scale >> %f", self.currentScale);
	
	if (self.currentScale >= START_SHIFTING) {
		self.yOffset += 6;
	}
	
	if (self.currentScale >= LIMIE_SCALE) {
		[self.myTimer invalidate];
		self.myTimer = nil;
		[self showButtons];
	}
}

- (void)showButtons {
	
	// level one
    UIButton *levelOne=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    levelOne.frame=CGRectMake(50, 230, 60, 40);
    [levelOne setTitle:@"Stage 1" forState:UIControlStateNormal];
    [levelOne setTitle:@"Go!" forState:UIControlStateSelected];
    
    [levelOne addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventAllTouchEvents];
	[levelOne setTag:1];
    
    [self.view addSubview:levelOne];
    
    
    //level two
    UIButton *levelTwo=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    levelTwo.frame=CGRectMake(185, 200, 60, 40);
    [levelTwo setTitle:@"Stage 2" forState:UIControlStateNormal];
    [levelTwo setTitle:@"Go!" forState:UIControlStateSelected];
    
    [levelTwo addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventAllTouchEvents];
	[levelTwo setTag:2];
    
    [self.view addSubview:levelTwo];
    
    
    //level three
    UIButton *levelThree=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    levelThree.frame=CGRectMake(50, 170, 60, 40);
    [levelThree setTitle:@"Stage 3" forState:UIControlStateNormal];
    [levelThree setTitle:@"Go!" forState:UIControlStateSelected];
	[levelThree setTag:3];
    
    [levelThree addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventAllTouchEvents];
    
    [self.view addSubview:levelThree];
}

- (IBAction)levelOne:(id)sender{
    [self performSegueWithIdentifier:@"startGame" sender:self];
}

- (IBAction)buttonClicked:(id)sender {
    // new button clicked handler
    NSLog(@"pressed, game start here");
	NSInteger levelNumber = ((UIView*)sender).tag;
	self.selectedStage = levelNumber;
    [self performSegueWithIdentifier:@"startGame" sender:self];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"startGame"]) {
        stageOneViewController *dest= [segue destinationViewController ];
        dest.stage = self.selectedStage;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
