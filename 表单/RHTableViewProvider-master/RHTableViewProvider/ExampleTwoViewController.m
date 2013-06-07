//
//  ExampleTwoViewController.m
//  RHTableViewProvider
//
//  Created by Rob Hayward on 07/02/2013.
//  Copyright (c) 2013 Rob Hayward. All rights reserved.
//

#import "ExampleTwoViewController.h"

@implementation ExampleTwoViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.tableView = [RHTableViewProvider tableViewWithFrame:self.view.bounds style:UITableViewStyleGrouped forSuperView:self.view];
  self.provider = [[RHTableViewProvider alloc] initWithTableView:_tableView delegate:self customise:YES];
  
  NSDictionary *section = @{RHTableViewProviderSectionRows:@[@"One", @"Two", @"Three", @"Four", @"Five", @"Six"], RHTableViewProviderSectionHeader:@"Section Name"};
  
  [self.provider setContent:@[section] withSections:YES];
}

#pragma mark - RHTableViewProviderDelegate

- (void)RHTableViewProvider:(RHTableViewProvider *)provider didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  id object = [provider objectAtIndexPath:indexPath];
  
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Row Selected" message:object delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
  [alert show];
}

- (NSString *)tableCellClassForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return @"ExampleTwoCell";
}

@end
