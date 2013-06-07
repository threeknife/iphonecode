//
//  ____statusBarAppDelegate.h
//  可点击的statusBar
//
//  Created by jianghui.liu on 12-7-2.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ____statusBarViewController;

@interface ____statusBarAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ____statusBarViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ____statusBarViewController *viewController;

@end

