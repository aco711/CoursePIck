//
//  CourseCommunicator.m
//  CoursePIck
//
//  Created by Alex Cohen on 8/29/15.
//  Copyright (c) 2015 Alex Cohen. All rights reserved.
//

#import "CourseCommunicator.h"
#import <AFNetworking/AFNetworking.h>
#import "CourseCommunicatorDelagate.h"

@implementation CourseCommunicator

//http://api.asg.northwestern.edu/courses/?key=YOUR_KEY&term=4530&subject=SPANISH


-(void)retrieveJSONDataFromURL:(NSString*)url
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.delegate recievedJSONCourseData:responseObject];
        

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error");
    }];
}

@end

