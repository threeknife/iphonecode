//
//  ExampleFiveCell.m
//  RHTableViewProvider
//
//  Created by Rob Hayward on 27/02/2013.
//  Copyright (c) 2013 Rob Hayward. All rights reserved.
//

#import "ExampleFiveCell.h"
#import <CoreData/CoreData.h>

@implementation ExampleFiveCell

- (void)populateWithObject:(id)object
{
  NSManagedObject *item = object;
  
  NSString *timestamp = [[item valueForKey:@"timestamp"] description];
  [self.label setText:timestamp];
}

@end
