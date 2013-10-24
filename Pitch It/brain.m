//
//  brain.m
//  Pitch It
//
//  Created by heron on 10/21/13.
//  Copyright (c) 2013 heron & minnie. All rights reserved.
//

#import "brain.h"

@implementation brain

- (NSString *)noteNumberToText:(NSInteger)noteNumber {
	NSArray *noteTextArr = [NSArray arrayWithObjects: @"C", @"C#/Db", @"D", @"D#/Eb", @"E", @"F", @"F#/Gb", @"G", @"G#/Ab", @"A", @"A#/Bb", @"B", nil];
	return [noteTextArr objectAtIndex:((noteNumber-4)%12)];
}


- (BOOL)sameNoteOrNot:(NSInteger)note1 compareWith:(NSInteger)note2 {
	NSLog(@"note1 >> %d\tnote2 >> %d", note1, note2);
	return ((note1-note2) % 12) == 0;
}

@end
