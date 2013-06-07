//
//  ExampleSixViewController.m
//  RHTableViewProvider
//
//  Created by Rob Hayward on 12/02/2013.
//  Copyright (c) 2013 Rob Hayward. All rights reserved.
//

#import "ExampleSixViewController.h"

@implementation ExampleSixViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editTableAction:)];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  if (!self.tableView)
  {
    self.tableView = [RHTableViewProvider tableViewWithFrame:self.view.bounds style:UITableViewStylePlain forSuperView:self.view];
    self.provider = [[RHTableViewProviderEditable alloc] initWithTableView:_tableView delegate:self customise:NO];
    
    [_provider setShouldPullToRefresh:YES];
    [_provider setPullToRefreshTimeout:5.0f];
    [_provider setPullToRefreshDistance:80.0f];

    [_provider setContent:@[@"One", @"Two", @"Three"] withSections:NO];
  }
}

#pragma mark - Actions

- (void)editTableAction:(id)sender
{
  if ([_tableView isEditing])
  {
    [_tableView setEditing:NO animated:NO];
  }
  else
  {
    [_tableView setEditing:YES animated:YES];
  }
}

#pragma mark - RHTableViewProviderDelegate

- (void)RHTableViewProviderDidPullToRefresh:(RHTableViewProvider *)provider
{
  
}

- (void)RHTableViewProviderDidCancelPullToRefresh:(RHTableViewProvider *)provider
{
  [_provider setContent:@[@"One", @"Two", @"Three", @"Four", @"Five", @"Six"] withSections:NO];
}

@end
