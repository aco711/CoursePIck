//
//  CourseCommunicator.h
//  CoursePIck
//
//  Created by Alex Cohen on 8/29/15.
//  Copyright (c) 2015 Alex Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CourseCommunicatorDelagate;

@interface CourseCommunicator : NSObject

-(void)retrieveJSONDataFromURL:(NSString*)url;


@property (weak, nonatomic) id<CourseCommunicatorDelagate> delegate;


@end
