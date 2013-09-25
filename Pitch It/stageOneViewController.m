//
//  stageOneViewController.m
//  Pitch It
//
//  Created by heng shumin on 13/9/24.
//  Copyright (c) 2013年 heron & minnie. All rights reserved.
//

#import "stageOneViewController.h"

@interface stageOneViewController ()

@property (nonatomic)   NSInteger magicNumber;





@end

@implementation stageOneViewController

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
    if (self.stage=='1') {
        self.magicNumber=arc4random()%11;
        self.magicNumber+=40;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
