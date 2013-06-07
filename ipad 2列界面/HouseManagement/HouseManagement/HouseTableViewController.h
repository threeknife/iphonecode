//
//  HouseTableViewController.h
//  HouseManagement
//
//  Created by  on 12-5-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebData.h"
#import "MainViewController.h"
@interface HouseTableViewController : UITableViewController
{
    MainViewController*mainViewController;
    NSMutableArray*houseArray;
    NSMutableArray*regionArray;
    IBOutlet UIBarItem*showListBar;
    IBOutlet UIBarItem*search;
    IBOutlet UIBarItem*add;
    IBOutlet UIBarItem*edit;
    IBOutlet UITextField*searchBar;
    BOOL Editing;
}
@property(nonatomic,strong)IBOutlet UITextField*searchBar;
@property(nonatomic,strong)IBOutlet UIBarItem*edit;
@property(nonatomic,strong)IBOutlet UIBarItem*showListBar;
@property(nonatomic,strong)IBOutlet UIBarItem*add;
@property(nonatomic,strong)IBOutlet UIBarItem*search;
@property(nonatomic,strong)MainViewController*mainViewController;
@property(nonatomic,strong)NSMutableArray*houseArray;
-(NSMutableArray*)selfStatusSet:(NSMutableArray*)data;
-(void)selfReset;
@end
