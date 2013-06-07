//
//  InAppPurchasesExampleAppDelegate.m
//  InAppPurchasesExample
//
//  Created by  Yakov Ilyin on 2/13/10.
//  Copyright Glosculptor, ISDS 2010. All rights reserved.
//

#import "InAppPurchasesExampleAppDelegate.h"
#import "InAppPurchasesExampleViewController.h"

@implementation InAppPurchasesExampleAppDelegate

@synthesize window;
@synthesize viewController;
@synthesize navigationController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
	navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
	[window addSubview:[navigationController view]];
	viewController.navigationController.navigationBarHidden = NO;
	[self.navigationController.navigationBar setBarStyle: UIStatusBarStyleDefault];
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
	
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
	[navigationController release];
    [viewController release];
    [window release];
    [super dealloc];
}


@end
