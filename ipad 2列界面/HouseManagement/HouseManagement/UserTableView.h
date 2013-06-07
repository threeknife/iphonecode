//
//  UserTableView.h
//  HouseManagement
//
//  Created by  on 12-5-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
@interface UserTableView : UITableViewController
{
    NSMutableArray*userArray;
    NSString*fileLocation;
    NSString*selectUser;
    NSString*selectPassword;
    UIPopoverController*userPop;
}
@property(nonatomic,strong)NSMutableArray*userArray;
@property(nonatomic,strong)NSString*selectUser;
@property(nonatomic,strong)NSString*selectPassword;
@property(nonatomic,strong)UIPopoverController*userPop;
@end
