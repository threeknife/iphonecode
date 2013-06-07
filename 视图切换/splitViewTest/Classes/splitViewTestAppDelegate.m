//
//  splitViewTestAppDelegate.m
//  splitViewTest
//
//  Created by kindy_imac on 12-3-14.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "splitViewTestAppDelegate.h"
#import "splitViewTestViewController.h"
#import "leftViewController.h"
#import "RightViewController.h"
#import "HomeViewController.h"
#import <QuartzCore/QuartzCore.h>
@implementation splitViewTestAppDelegate

@synthesize window;
@synthesize viewController;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.

    // Add the view controller's view to the window and display.
    [self.window addSubview:viewController.view];
    [self.window makeKeyAndVisible];
	
	
	leftViewController *conLeft_ = [[leftViewController alloc] init];
	RightViewController *conRight_ = [[RightViewController alloc] init];
	HomeViewController *conHome_ = [[HomeViewController alloc] init];
	
	viewController = [[LLSplitViewController alloc] initWithLeftController:conLeft_ 
																		 rigthController:conRight_ 
																		  homeController:conHome_];
	
	//viewController.view.frame = CGRectMake(0, 0, 320, 460);
	
	UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:viewController];
	[nc setNavigationBarHidden:YES animated:YES];
	
	
	self.window.autoresizesSubviews = NO;
	[self.window addSubview:viewController.view];
	
	
	//[self.window addSubview:nc.view];
	
	UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 320, 460)];
	iv.image = [UIImage imageNamed:@"Default.png"];
	[window addSubview:iv];

	
	
	iv.layer.anchorPoint = CGPointMake(0, 0);
	iv.frame = CGRectMake(0, 20, 320, 460);

	CATransform3D aTransform = CATransform3DIdentity;
    aTransform.m34 = 1.0 / -2000;
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform"];
    anim.duration = 2;
    anim.fromValue= [NSValue valueWithCATransform3D:CATransform3DRotate(aTransform, 0, 0, 1, 0)];
    anim.toValue=[NSValue valueWithCATransform3D:CATransform3DRotate(aTransform, -3.14, 0, 1, 0)];
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	
    anim.removedOnCompletion = NO;
	anim.fillMode = kCAFillModeForwards;
    
    [iv.layer addAnimation:anim forKey:@"transformAnimation"];
	 

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
