//
//  brain.h
//  Pitch It
//
//  Created by heron on 10/21/13.
//  Copyright (c) 2013 heron & minnie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface brain : NSObject

- (NSString *)noteNumberToText:(NSInteger)noteNumber;
- (BOOL)sameNoteOrNot:(NSInteger)note1 compareWith:(NSInteger)note2;

@end
