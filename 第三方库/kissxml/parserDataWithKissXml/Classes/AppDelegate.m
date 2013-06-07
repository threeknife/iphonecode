//
//  AppDelegate.m
//  parserDataWithKissXml
//
//  Created by angel li on 11-1-17.
//  Copyright Lixf 2011. All rights reserved.
//

#import "AppDelegate.h"
#import "ParseXmlCtrl.h"

@implementation AppDelegate

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
