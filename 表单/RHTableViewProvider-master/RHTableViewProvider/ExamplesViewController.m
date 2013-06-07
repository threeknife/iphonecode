//
//  ExamplesViewController.m
//  RHTableViewProvider
//
//  Created by Rob Hayward on 07/02/2013.
//  Copyright (c) 2013 Rob Hayward. All rights reserved.
//

#import "ExamplesViewController.h"
#import "ExampleOneViewController.h"
#import "ExampleTwoViewController.h"
#import "ExampleThreeViewController.h"
#import "ExampleFourViewController.h"
#import "ExampleFiveViewController.h"
#import "ExampleSixViewController.h"

@implementation ExamplesViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self setTitle:@"Examples"];
  
  // Create a table view and add it to your view (Conveinience)
  self.tableView = [RHTableViewProvider tableViewWithFrame:self.view.bounds style:UITableViewStyleGrouped forSuperView:self.view];
  
  // Setup your table view provider
  self.provider = [[RHTableViewProvider alloc] initWithTableView:_tableView delegate:self customise:NO];
  
  // Update your content
  [_provider setContent:@[@"Grouped", @"Grouped Customized", @"Plain", @"Plain Customized", @"Editable", @"Pull to Refresh Cusomized"] withSections:NO];
}

#pragma mark - RHTableViewProviderDelegate

- (void)RHTableViewProvider:(RHTableViewProvider *)provider didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  id object = [_provider objectAtIndexPath:indexPath];
  
  switch (indexPath.row)
  {
    case 0:
    {
      ExampleOneViewController *example = [[ExampleOneViewController alloc] initWithNibName:nil bundle:nil];
      [example setTitle:object];
      [[self navigationController] pushViewController:example animated:YES];
    }
      break;
    case 1:
    {
      ExampleTwoViewController *example = [[ExampleTwoViewController alloc] initWithNibName:nil bundle:nil];
      [example setTitle:object];
      [[self navigationController] pushViewController:example animated:YES];
    }
      break;
    case 2:
    {
      ExampleThreeViewController *example = [[ExampleThreeViewController alloc] initWithNibName:nil bundle:nil];
      [example setTitle:object];
      [[self navigationController] pushViewController:example animated:YES];
    }
      break;
    case 3:
    {
      ExampleFourViewController *example = [[ExampleFourViewController alloc] initWithNibName:nil bundle:nil];
      [example setTitle:object];
      [[self navigationController] pushViewController:example animated:YES];
    }
      break;
    case 4:
    {
      ExampleFiveViewController *example = [[ExampleFiveViewController alloc] initWithNibName:nil bundle:nil];
      [example setTitle:object];
      [example setContext:self.context];
      [[self navigationController] pushViewController:example animated:YES];
    }
      break;
    case 5:
    {
      ExampleSixViewController *example = [[ExampleSixViewController alloc] initWithNibName:nil bundle:nil];
      [example setTitle:object];
      [[self navigationController] pushViewController:example animated:YES];
    }
      break;
  }
}

@end
