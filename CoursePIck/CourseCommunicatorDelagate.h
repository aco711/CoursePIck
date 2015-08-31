//
//  CourseCommunicatorDelagate.h
//  CoursePIck
//
//  Created by Alex Cohen on 8/30/15.
//  Copyright (c) 2015 Alex Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CourseCommunicatorDelagate

- (void)recievedJSONCourseData:(id)dict;

@end
