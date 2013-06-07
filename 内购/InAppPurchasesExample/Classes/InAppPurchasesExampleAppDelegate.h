//
//  InAppPurchasesExampleAppDelegate.h
//  InAppPurchasesExample
//
//  Created by  Yakov Ilyin on 2/13/10.
//  Copyright Glosculptor, ISDS 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InAppPurchasesExampleViewController;

@interface InAppPurchasesExampleAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    InAppPurchasesExampleViewController *viewController;
	UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet InAppPurchasesExampleViewController *viewController;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@end

