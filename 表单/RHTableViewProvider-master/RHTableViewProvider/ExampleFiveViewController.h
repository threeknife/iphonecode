//
//  ExampleFiveViewController.h
//  RHTableViewProvider
//
//  Created by Rob Hayward on 08/02/2013.
//  Copyright (c) 2013 Rob Hayward. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RHTableViewProviderDelegate.h"
#import "RHTableViewProviderEditable.h"

@interface ExampleFiveViewController : UIViewController <RHTableViewProviderEditableDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) RHTableViewProviderEditable *provider;
@property (strong, nonatomic) NSMutableArray *content;
@property (strong, nonatomic) NSManagedObjectContext *context;

@end
