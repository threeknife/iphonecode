//
//  MainViewController.h
//  HouseManagement
//
//  Created by  on 12-5-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface MainViewController : UIViewController
{
    
}
-(IBAction)showHouseManageView:(id)sender;
-(IBAction)ShowSearchView:(id)sender;
-(void)showDetailView:(NSMutableDictionary *)dic;
-(void)showEditHouseVIew:(NSMutableDictionary*)dic;
@end
