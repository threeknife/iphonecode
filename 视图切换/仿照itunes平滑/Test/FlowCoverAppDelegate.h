//
//  FlowCoverAppDelegate.h
//  FlowCover
//
//  Created by William Woody on 12/13/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlowCoverTest;

@interface FlowCoverAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    FlowCoverTest *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet FlowCoverTest *viewController;

@end

