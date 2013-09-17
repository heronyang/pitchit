//
//  musicNotePlayer.m
//  Pitch It
//
//  Created by heng shumin on 13/9/17.
//  Copyright (c) 2013年 heron & minnie. All rights reserved.
//

#import "musicNotePlayer.h"


#import "musicNotePlayer.h"
#import <AVFoundation/AVFoundation.h>

#define VOLUME 1.0f
#define NOTE_LOWER_BOUND	1
#define NOTE_UPPER_BOUND	88

@interface musicNotePlayer()
@property (strong, nonatomic)AVAudioPlayer *player;
@end

@implementation musicNotePlayer
// constructor
- (id)init {
	self = [super init];
	if (self) {
		NSLog(@"[Note Player] note player is loaded.");
	}
	return self;
}

- (AVAudioPlayer *)player {
	if (_player == nil) {
		NSString *mp3Path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"40.mp3"];
		NSURL *mp3Url = [NSURL fileURLWithPath:mp3Path];
		
		NSError *err;
		_player = [[AVAudioPlayer alloc] initWithContentsOfURL:mp3Url error:&err];
		_player.volume = 1.0f;
		_player.numberOfLoops = 0;
		[_player prepareToPlay];
	}
	return _player;
}

- (void)playerResetToNote:(NSString *)audioFilename{
	NSString	*mp3Path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:audioFilename];
	NSURL	*mp3Url = [NSURL fileURLWithPath:mp3Path];
	NSError	*err;
	
	self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:mp3Url error:&err];
	self.player.volume = 1.0f;
	self.player.numberOfLoops = 0;
	[self.player prepareToPlay];
}

- (void)playNote:(NSInteger)noteNumber {
	// check input valid
	if (noteNumber < NOTE_LOWER_BOUND || noteNumber > NOTE_UPPER_BOUND) {
		NSLog(@"[Note Player] input range error");
	}
	
	// setup player
	NSString *audioFilename = [[NSString alloc] initWithFormat:@"%02d.mp3", noteNumber];
	NSLog(@"[Note Player] %@ is played", audioFilename);
	[self playerResetToNote:audioFilename];
	
	// play
	[self.player play];
}

@end