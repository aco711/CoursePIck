//
//  CourseManager.m
//  CoursePIck
//
//  Created by Alex Cohen on 8/31/15.
//  Copyright (c) 2015 Alex Cohen. All rights reserved.
//

#import "CourseManager.h"
#import "CourseManagerDelegate.h"
#import <AFNetworking/AFNetworking.h>

@interface CourseManager ()

@end

//http://api.asg.northwestern.edu/subjects/?key=hwlBH18ncBVs8sPz&term=4600

@implementation CourseManager

-(void)findTermIDsGivenTermString:(NSString*)termString
{
    [self findAvailableSubjectsGivenTermID:@"4600"];
}

-(void)findAvailableSubjectsGivenTermID:(NSString *)termID
{
    NSString * urlString = [NSString stringWithFormat:@"http://api.asg.northwestern.edu/subjects/?key=hwlBH18ncBVs8sPz&term=%@",termID];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.delegate recievedAvailableCourses:responseObject];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error");
    }];
}



@end
