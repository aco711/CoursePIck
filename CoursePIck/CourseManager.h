//
//  CourseManager.h
//  CoursePIck
//
//  Created by Alex Cohen on 8/31/15.
//  Copyright (c) 2015 Alex Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CourseManagerDelegate.h"

@protocol CourseManagerDelegate;

@interface CourseManager : NSObject

@property (weak, nonatomic) id<CourseManagerDelegate> delegate;

-(void)findTermIDsGivenTermString:(NSString*)termString;
-(void)findAvailableSubjectsGivenTermID:(NSString*)termID;

@end
