//
//  pitchitViewController.m
//  Pitch It
//
//  Created by heron on 9/17/13.
//  Copyright (c) 2013 heron & minnie. All rights reserved.
//

#import "pitchitViewController.h"
#import "musicNotePlayer.h"

@interface pitchitViewController ()

@property (strong, nonatomic) musicNotePlayer *myPlayer;

@end

@implementation pitchitViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

// getter, constructor
- (musicNotePlayer *)myPlayer {
    if (_myPlayer == nil) {
        _myPlayer = [[musicNotePlayer alloc] init];
    }
    return _myPlayer;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)playButton:(id)sender {
    [self.myPlayer playNote:40];
}

@end
