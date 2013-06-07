//
//  CellsAppDelegate.m
//  Cells
//
//  Created by nicky on 10-5-20.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "CellsAppDelegate.h"
#import "CellsViewController.h"

@implementation CellsAppDelegate

@synthesize window;
@synthesize viewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
	
	return YES;
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
