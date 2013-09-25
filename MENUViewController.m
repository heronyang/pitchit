//
//  MENUViewController.m
//  Pitch It
//
//  Created by heng shumin on 13/9/24.
//  Copyright (c) 2013年 heron & minnie. All rights reserved.
//

#import "MENUViewController.h"
#import "stageOneViewController.h"

@interface MENUViewController ()
@property (weak, nonatomic) IBOutlet UIButton *start;

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
}
- (IBAction)startButton:(id)sender {
    
    UIButton *levelOne=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    levelOne.frame=CGRectMake(50, 230, 60, 40);
    [levelOne setTitle:@"Stage 1" forState:UIControlStateNormal];
    [levelOne setTitle:@"Go!" forState:UIControlStateSelected];
    
    [levelOne addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventAllTouchEvents];
    
    [self.view addSubview:levelOne];
    
    
    //level two
    UIButton *levelTwo=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    levelTwo.frame=CGRectMake(185, 200, 60, 40);
    [levelTwo setTitle:@"Stage 2" forState:UIControlStateNormal];
    [levelTwo setTitle:@"Go!" forState:UIControlStateSelected];
    
//    [levelTwo addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventAllTouchEvents];
    
    [self.view addSubview:levelTwo];
    
    
    //level three
    UIButton *levelThree=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    levelThree.frame=CGRectMake(50, 170, 60, 40);
    [levelThree setTitle:@"Stage 3" forState:UIControlStateNormal];
    [levelThree setTitle:@"Go!" forState:UIControlStateSelected];
    
//    [levelThree addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventAllTouchEvents];
    
    [self.view addSubview:levelThree];
}

- (IBAction)levelOne:(id)sender{
    [self performSegueWithIdentifier:@"startGame" sender:self];
}

- (IBAction)buttonClicked:(id)sender {
    // new button clicked handler
    NSLog(@"pressed, game start here");
    [self performSegueWithIdentifier:@"startGame" sender:self];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"startGame"]) {
        stageOneViewController *dest= [segue destinationViewController ];
        dest.stage = 1;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
