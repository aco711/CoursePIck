//
//  CoursePickMenuTVC.m
//  CoursePIck
//
//  Created by Alex Cohen on 8/29/15.
//  Copyright (c) 2015 Alex Cohen. All rights reserved.
//

#import "CoursePickMenuTVC.h"
#import "PureLayout/PureLayout.h"
#import "ActionSheetPicker.h"
#import "CourseCommunicator.h"
#import "CourseCommunicatorDelagate.h"
#import "AddToCalenderTVC.h"
#import "CourseManagerDelegate.h"
#import "CourseManager.h"

@interface CoursePickMenuTVC () <CourseCommunicatorDelagate, CourseManagerDelegate>


@property (strong, nonatomic) CourseCommunicator * courseCommunicator;
@property (strong, nonatomic) CourseManager * courseManager;
@property (strong, nonatomic) UIButton* findCoursesButton;
@property (strong, nonatomic) NSString* term;
@property (strong, nonatomic) NSString* subject;
@property (strong, nonatomic) NSArray* availableSubjects; // of NSDictionary


@end

const static NSString* APIKEY = @"hwlBH18ncBVs8sPz";

@implementation CoursePickMenuTVC

#pragma mark - ViewController

-(void)loadView
{
    self.tableView = [[UITableView alloc] init];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Menu Cell"];
    self.courseManager = [[CourseManager alloc] init];
    self.courseManager.delegate = self;
    self.courseCommunicator = [[CourseCommunicator alloc]init];
    self.courseCommunicator.delegate = self;
    [self makeFindCoursesButton];
    //NSLog(@"%@",self.courseCommunicator.test);
    
}

-(NSArray*)availableSubjects
{
    if (!_availableSubjects)
    {
        _availableSubjects = [[NSArray alloc] init];
    }
    return _availableSubjects;
}

#pragma mark - CourseCommunicator Delegate

-(void)recievedJSONCourseData:(id)dict
{
    
    [self presentAvailableCoursesWithData:dict];
    //NSLog(@"%@", dict);
}

#pragma mark - CourseManager Delegate

-(void)recievedAvailableCourses:(NSArray *)availableSubjects
{
    self.availableSubjects = availableSubjects;
}




-(NSString*)createURLToBeginSearchWithTerm:(NSString*)term Subject:(NSString*)subject
{
    if ([term isEqualToString:@"fall"])
    {
        term = @"4600";
    }
    NSString* url = [NSString stringWithFormat:@"http://api.asg.northwestern.edu/courses/?key=%@&term=%@&subject=%@",APIKEY, term, subject];
    
    return url;
}

#pragma mark - Navigation

-(void)presentAvailableCoursesWithData:(id)data
{
    AddToCalenderTVC* avTVC = [[AddToCalenderTVC alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:avTVC];
    avTVC.availableCourses = data;
    [navController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self showDetailViewController:navController sender:self];
}

#pragma mark - Buttons

-(void)loadDataButtonClicked
{
    
    [self.courseCommunicator retrieveJSONDataFromURL:[self createURLToBeginSearchWithTerm:[self.term lowercaseString] Subject:self.subject]];
}

-(void)makeFindCoursesButton
{
    self.findCoursesButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
    self.findCoursesButton.backgroundColor = [UIColor blackColor];
    //self.findCoursesButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.findCoursesButton addTarget:self action:@selector(loadDataButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.findCoursesButton setTitle:@"Find Courses" forState:UIControlStateNormal];
    self.tableView.tableFooterView = self.findCoursesButton;
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == 0) {return 2;}
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Menu Cell" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Menu Cell"];
    }
    
    if (indexPath.section == 0) {
        NSArray *titles = @[@"Term", @"Subject"];
        cell.textLabel.text = titles[indexPath.row];
    }
    
    return cell;
}

#pragma mark - UITableView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *terms = [NSArray arrayWithObjects:@"Fall", nil];
    if (indexPath.row == 0)
    {
        [ActionSheetStringPicker showPickerWithTitle:@"Select a Term"
                                                rows:terms
                                    initialSelection:0
                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                               UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:indexPath];
                                               cell.textLabel.text = (NSString*)selectedValue;
                                               self.term = selectedValue;
                                               [self.courseManager findTermIDsGivenTermString:selectedValue];
                                               
                                           }
                                         cancelBlock:^(ActionSheetStringPicker *picker) {
                                             NSLog(@"Block Picker Canceled");
                                         }
                                              origin:self.view];
    }
    else if (indexPath.row == 1)
    {
        if ([self.availableSubjects count] >0)
        {
            [ActionSheetStringPicker showPickerWithTitle:@"Select a Subject"
                                                    rows:[self createArrayOfAvailableSubjectStrings]
                                        initialSelection:0
                                               doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                                   UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:indexPath];
                                                   cell.textLabel.text = (NSString*)selectedValue;
                                                   self.subject = selectedValue;
                                                   [tableView deselectRowAtIndexPath:indexPath animated:YES];
                                               }
                                             cancelBlock:^(ActionSheetStringPicker *picker) {
                                                 NSLog(@"Block Picker Canceled");
                                             }
                                                  origin:self.view];
        }
    }
    
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

#pragma mark - Helper Functions
-(NSMutableArray*)createArrayOfAvailableSubjectStrings
{
    NSMutableArray * availableCourses = [[NSMutableArray alloc] init];
    for (NSDictionary* dict in self.availableSubjects)
    {
        [availableCourses addObject:[dict valueForKey:@"symbol"]];
    }
    return availableCourses;
}




/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */




@end
