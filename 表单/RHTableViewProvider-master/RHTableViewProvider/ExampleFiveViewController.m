//
//  ExampleFiveViewController.m
//  RHTableViewProvider
//
//  Created by Rob Hayward on 08/02/2013.
//  Copyright (c) 2013 Rob Hayward. All rights reserved.
//

#import "ExampleFiveViewController.h"

@implementation ExampleFiveViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self insertSomeObjectsInToCoreData];
  self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  [self setup];
  [self update];
}

#pragma mark - Setup

- (void)setup
{
  if (self.tableView) { return; }
  self.tableView = [RHTableViewProvider tableViewWithFrame:self.view.bounds style:UITableViewStylePlain forSuperView:self.view];
  self.provider = [[RHTableViewProviderEditable alloc] initWithTableView:_tableView delegate:self customise:YES];
  [_provider setDefaultCellClassName:@"ExampleFiveCell"];
}

#pragma mark - Update

- (void)update
{
  [_provider setContentWithFetchRequest:[self fetchRequest] sectionKeyPath:@"Name" context:self.context];
}

#pragma mark - RHTableViewProviderDelegate

- (void)RHTableViewProvider:(RHTableViewProvider *)provider tableViewShoudDeleteRowAtIndexPath:(NSIndexPath *)indexPath
{
  [_provider deleteObjectAtIndexPath:indexPath];
  [self.context save:nil];  
  [self update];
}

#pragma mark - Fetch Request

- (NSFetchRequest *)fetchRequest
{
  NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"DateItem"];
  NSSortDescriptor *name = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
  [request setSortDescriptors:@[name]];
  return request;
}

#pragma mark - Actions

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
  [super setEditing:editing animated:animated];
  [_tableView setEditing:editing animated:animated];
}



#pragma mark - Insert some objects into core data

- (void)insertSomeObjectsInToCoreData
{
  NSEntityDescription *entity = [NSEntityDescription entityForName:@"DateItem" inManagedObjectContext:self.context];
  
  NSArray *objects = [self.context executeFetchRequest:[self fetchRequest] error:nil];
  if ([objects count] > 0) { return; }
  
  for (NSInteger i = 0; i < 3; i++)
  {
    for (NSInteger j = 0; j < 3; j++)
    {
      NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:self.context];
      [newManagedObject setValue:[NSDate date] forKey:@"timestamp"];
      [newManagedObject setValue:[NSString stringWithFormat:@"Section %d", i] forKey:@"name"];
    }
  }
  [self.context save:nil];
}

@end
