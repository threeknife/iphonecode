//
//  KTAppDelegate.h
//  Picture
//
//  Created by Keggcalm on 12-1-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestViewController.h"

@interface KTAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) TestViewController *contentController;

@end
