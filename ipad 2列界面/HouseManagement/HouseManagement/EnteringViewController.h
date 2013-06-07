//
//  EnteringViewController.h
//  HouseManagement
//
//  Created by  on 12-5-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserTableView.h"
#import "User.h"
@interface EnteringViewController : UIViewController<UIPopoverControllerDelegate>
{
    IBOutlet UITextField*userName;
    IBOutlet UITextField*userPassword;
    IBOutlet UISwitch*rememberPassword;
    UserTableView*userRemembered;
    //user setting
    UIPopoverController*currentPopView;
}
@property(nonatomic,strong)NSManagedObjectContext*context;
@property(nonatomic,strong)IBOutlet UITextField*userName;
@property(nonatomic,strong)IBOutlet UITextField*userPassword;
@property(nonatomic,strong)IBOutlet UISwitch*rememberPassword;
@property(nonatomic,strong) UserTableView*userRemembered;
@property(nonatomic,strong)UIPopoverController*currentPopView;
//method
-(IBAction)enter:(id)sender;
-(IBAction)resign:(id)sender;
-(IBAction)popUserList:(id)sender;
@end