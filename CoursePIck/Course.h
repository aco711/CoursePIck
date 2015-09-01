//
//  Course.h
//  CoursePIck
//
//  Created by Alex Cohen on 8/31/15.
//  Copyright (c) 2015 Alex Cohen. All rights reserved.
//

#import <Realm/Realm.h>

@interface Course : RLMObject

@property NSString * scheduleName;
@property NSString * meeting_days;
@property NSString * start_time;
@property NSString * end_time;
@property NSString * instructor;
@property NSInteger * catalog_num;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<Course>
RLM_ARRAY_TYPE(Course)
