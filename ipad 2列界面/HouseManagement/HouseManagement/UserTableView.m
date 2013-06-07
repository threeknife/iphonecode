//
//  UserTableView.m
//  HouseManagement
//
//  Created by  on 12-5-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UserTableView.h"
#import "AppDelegate.h"
#import "User.h"
@interface UserTableView ()

@end

@implementation UserTableView
@synthesize userArray;
@synthesize selectUser;
@synthesize selectPassword;
@synthesize userPop;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    AppDelegate*appDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext*manageContext=appDelegate.managedObjectContext;
    NSFetchRequest*request=[[NSFetchRequest alloc] init];
    NSEntityDescription*entity=[NSEntityDescription entityForName:@"User" inManagedObjectContext:manageContext];
    [request setEntity:entity];
    NSSortDescriptor*sortDescriptor=[[NSSortDescriptor alloc] initWithKey:@"name" ascending:NO];
    NSArray*sortArray=[[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortArray];
    NSError*error;
    NSMutableArray*result=[[manageContext executeFetchRequest:request error:&error] mutableCopy];
    self.userArray=result;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [userArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    User*user=[userArray objectAtIndex:indexPath.row];
    cell.textLabel.text=user.name;
    if ([self.selectUser isEqualToString:user.name]) {
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
        NSLog(@"YES");
    }
    else {
        cell.accessoryType=UITableViewCellAccessoryNone;
    }
    // Configure the cell...
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger selectNumber=[userArray indexOfObject:self.selectUser];
    if (selectNumber!=indexPath.row) {
        NSArray*indexPaths;
        if (selectNumber!=NSNotFound) {
            NSIndexPath*previousIndexPath=[NSIndexPath indexPathForRow:selectNumber inSection:0];
            indexPaths=[NSArray arrayWithObjects:indexPath,previousIndexPath, nil];
        }
        else {
            indexPaths=[NSArray arrayWithObjects:indexPath, nil];
        }
    
    User *user=[userArray objectAtIndex:indexPath.row];
    selectUser=user.name;
    selectPassword=user.password;
    [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UserPick" object:self];
    }
}
/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
     if (editingStyle == UITableViewCellEditingStyleDelete) {
         AppDelegate*appDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
         User*removeUser=[userArray objectAtIndex:indexPath.row];
         [appDelegate.managedObjectContext deleteObject:removeUser];
         [userArray removeObjectAtIndex:indexPath.row];
         [appDelegate saveContext];
         [self.tableView reloadData];
 // Delete the row from the data source
         //[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
     }   
     else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }   
 }
 

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

/*- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Navigation logic may go here. Create and push another view controller.
 // ...
 // Pass the selected object to the new view controller.
 [self.navigationController pushViewController:detailViewController animated:YES];
 
 }*/
@end
