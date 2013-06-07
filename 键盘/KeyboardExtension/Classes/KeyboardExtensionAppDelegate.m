/*
 * KeyboardExtension
 *
 * Copyright 2008/2009 Neoos GmbH. All rights reserved.
 *
 */

#import "KeyboardExtensionAppDelegate.h"
#import "DemoViewController.h"

@implementation KeyboardExtensionAppDelegate

@synthesize window;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
    viewController = [[DemoViewController alloc] init];
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
