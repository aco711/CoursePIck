//
//  Course.h
//  CoursePIck
//
//  Created by Alex Cohen on 8/29/15.
//  Copyright (c) 2015 Alex Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Course : NSObject

@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSString* instructor;
@property (strong, nonatomic) NSString* room;
@property (strong, nonatomic) NSString* meetingDays;
@property (strong, nonatomic) NSString* startTime;
@property (strong, nonatomic) NSString* endTime;

@end
