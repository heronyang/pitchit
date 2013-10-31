//
//  scorePageViewController.h
//  Pitch It
//
//  Created by heron on 10/10/13.
//  Copyright (c) 2013 heron & minnie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface scorePageViewController : UIViewController

@property (nonatomic) NSInteger score;
@property (nonatomic) NSInteger selectedStage;
@property (strong, nonatomic)	NSMutableArray *questions;
@property (strong, nonatomic)	NSMutableArray *userAnswer;

@end
