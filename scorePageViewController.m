//
//  scorePageViewController.m
//  Pitch It
//
//  Created by heron on 10/10/13.
//  Copyright (c) 2013 heron & minnie. All rights reserved.
//

#import "scorePageViewController.h"

@interface scorePageViewController ()
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;

@end

@implementation scorePageViewController

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
