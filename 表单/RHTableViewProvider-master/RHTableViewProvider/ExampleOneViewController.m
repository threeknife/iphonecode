//
//  ExampleOneViewController.m
//  RHTableViewProvider
//
//  Created by Rob Hayward on 07/02/2013.
//  Copyright (c) 2013 Rob Hayward. All rights reserved.
//

#import "ExampleOneViewController.h"

@implementation ExampleOneViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  // Create a table view and add it to your view (Conveinience)
  self.tableView = [RHTableViewProvider tableViewWithFrame:self.view.bounds style:UITableViewStyleGrouped forSuperView:self.view];
  
  // Setup your table view provider
  self.provider = [[RHTableViewProvider alloc] initWithTableView:_tableView delegate:self customise:NO];
  
  // Update your content
  [_provider setContent:@[@"One", @"Two", @"Three"] withSections:NO];
}

#pragma mark - RHTableViewProviderDelegate

- (void)RHTableViewProvider:(RHTableViewProvider *)provider didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  id object = [provider objectAtIndexPath:indexPath];
  
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Row Selected" message:object delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
  [alert show];
}

@end
