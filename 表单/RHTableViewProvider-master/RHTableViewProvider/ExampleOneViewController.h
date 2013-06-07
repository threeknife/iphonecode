//
//  ExampleOneViewController.h
//  RHTableViewProvider
//
//  Created by Rob Hayward on 07/02/2013.
//  Copyright (c) 2013 Rob Hayward. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RHTableViewProviderDelegate.h"
#import "RHTableViewProvider.h"

@interface ExampleOneViewController : UIViewController <RHTableViewProviderDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) RHTableViewProvider *provider;

@end
