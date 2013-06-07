//
//  ExampleFourViewController.m
//  RHTableViewProvider
//
//  Created by Rob Hayward on 07/02/2013.
//  Copyright (c) 2013 Rob Hayward. All rights reserved.
//

#import "ExampleFourViewController.h"

@implementation ExampleFourViewController

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  if (!self.tableView)
  {
    [self setupTableView];
  }
}

- (void)setupTableView
{
  self.tableView = [RHTableViewProvider tableViewWithFrame:self.view.bounds style:UITableViewStylePlain forSuperView:self.view];
  self.provider = [[RHTableViewProvider alloc] initWithTableView:_tableView delegate:self customise:YES];
  
  [_provider setDefaultCellClassName:@"ExampleFourCell"];
  [_provider setSectionIndexTitles:@[@"A", @"B"]];
  
  NSDictionary *sectionA = @{ RHTableViewProviderSectionRows:@[@"One", @"Two", @"Three", @"Four", @"Five", @"Six", @"Seven", @"Eight", @"Nine", @"Ten"], RHTableViewProviderSectionHeader:@"Section A" };
  NSDictionary *sectionB = @{ RHTableViewProviderSectionRows:@[@"One", @"Two", @"Three", @"Four", @"Five", @"Six", @"Seven", @"Eight", @"Nine", @"Ten"], RHTableViewProviderSectionHeader:@"Section B", RHTableViewProviderSectionFooter:@"Section B Footer" };
  
  [_provider setContent:@[sectionA, sectionB] withSections:YES];
}

#pragma mark - RHTableViewProviderDelegate

- (void)RHTableViewProvider:(RHTableViewProvider *)provider didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  id object = [provider objectAtIndexPath:indexPath];
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Row Selected" message:object delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
  [alert show];
}

@end
