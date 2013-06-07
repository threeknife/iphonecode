//
//  NativeBridgeAppDelegate.h
//  NativeBridge
//
//  Created by NativeBridge on 14/09/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NativeBridgeViewController;

@interface NativeBridgeAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    NativeBridgeViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet NativeBridgeViewController *viewController;

@end

