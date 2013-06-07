//
//  AppDelegate.h
//  parserDataWithKissXml
//
//  Created by angel li on 11-1-17.
//  Copyright Lixf 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ParseXmlCtrl;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ParseXmlCtrl *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ParseXmlCtrl *viewController;

@end

