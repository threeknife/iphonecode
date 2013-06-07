//
//  splitViewTestAppDelegate.h
//  splitViewTest
//
//  Created by kindy_imac on 12-3-14.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLSplitViewController.h"

@class splitViewTestViewController;

@interface splitViewTestAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    LLSplitViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet LLSplitViewController *viewController;

@end

#define theApp ((splitViewTestAppDelegate *)[[UIApplication sharedApplication] delegate])
