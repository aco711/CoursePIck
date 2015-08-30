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

@interface CoursePickMenuTVC () <CourseCommunicatorDelagate>


@property (strong, nonatomic) CourseCommunicator * courseCommunicator;



@end

const static NSString* APIKEY = @"hwlBH18ncBVs8sPz";

@implementation CoursePickMenuTVC


-(void)loadView
{
    self.tableView = [[UITableView alloc] init];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Menu Cell"];
    self.courseCommunicator = [[CourseCommunicator alloc]init];
    self.courseCommunicator.delegate = self;
    [self.courseCommunicator retrieveJSONDataFromURL:[self createURLToBeginSearchWithTerm:@"fall" Subject:@"SPANISH"]];
    //NSLog(@"%@",self.courseCommunicator.test);
    
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

-(void)recievedJSONCourseData:(NSDictionary *)dict
{
    // NSLog(@"%@", dict);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    return 2;
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *colors = [NSArray arrayWithObjects:@"Fall", @"Winter", @"Spring", @"Summer", nil];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell.textLabel.text isEqualToString:@"Term"])
    {
        [ActionSheetStringPicker showPickerWithTitle:@"Select a Term"
                                                rows:colors
                                    initialSelection:0
                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                               UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:indexPath];
                                               cell.textLabel.text = (NSString*)selectedValue;
                                               
                                           }
                                         cancelBlock:^(ActionSheetStringPicker *picker) {
                                             NSLog(@"Block Picker Canceled");
                                         }
                                              origin:self.view];
    }
    else if ([cell.textLabel.text isEqualToString:@"Subject"])
    {
        [ActionSheetStringPicker showPickerWithTitle:@"Select a Subject"
                                                rows:colors
                                    initialSelection:0
                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                               UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:indexPath];
                                               cell.textLabel.text = (NSString*)selectedValue;
                                               [tableView deselectRowAtIndexPath:indexPath animated:YES];
                                           }
                                         cancelBlock:^(ActionSheetStringPicker *picker) {
                                             NSLog(@"Block Picker Canceled");
                                         }
                                              origin:self.view];
    }
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
