//
//  CourseManagerDelegate.h
//  CoursePIck
//
//  Created by Alex Cohen on 8/31/15.
//  Copyright (c) 2015 Alex Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CourseManagerDelegate

//- (void)recievedTermIDs:(NSArray*)termIDs;
- (void)recievedAvailableCourses:(NSArray*)availableSubjects;

@end