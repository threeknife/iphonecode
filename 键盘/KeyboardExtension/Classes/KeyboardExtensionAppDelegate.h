/*
 * KeyboardExtension
 *
 * Copyright 2008/2009 Neoos GmbH. All rights reserved.
 *
 */

#import <UIKit/UIKit.h>

@class DemoViewController;

@interface KeyboardExtensionAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    DemoViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

