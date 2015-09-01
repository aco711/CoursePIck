//
//  AddToCalenderTVC.m
//  CoursePIck
//
//  Created by Alex Cohen on 8/30/15.
//  Copyright (c) 2015 Alex Cohen. All rights reserved.
//

#import "AddToCalenderTVC.h"

@interface AddToCalenderTVC ()

@property (strong, nonatomic) UIBarButtonItem* cancelButton;


@end

@implementation AddToCalenderTVC


-(void)loadView
{
    self.tableView = [[UITableView alloc] init];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Course Cell"];
    self.cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(cancelSelection)];
    self.navigationItem.leftBarButtonItem = self.cancelButton;
}

-(void)cancelSelection
{
    [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.availableCourses count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Course Cell"];
    
    // Configure the cell...
    NSDictionary* classData = self.availableCourses[indexPath.row];
    NSString* subject = [classData valueForKey:@"subject"];
    NSString* catalog_num = [classData valueForKey:@"catalog_num"];
    NSString* classTitle = [classData valueForKey:@"title"];
    NSString* meeting_days = [classData valueForKey:@"meeting_days"];
    NSString* start_time = [classData valueForKey:@"start_time"];
    NSString* end_time = [classData valueForKey:@"end_time"];
    
    
    
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@: %@",subject, catalog_num, classTitle];
    cell.textLabel.font = [cell.textLabel.font fontWithSize:15];
    [cell.textLabel adjustsFontSizeToFitWidth];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@-%@",meeting_days, start_time, end_time];
    
    
    
    return cell;
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
