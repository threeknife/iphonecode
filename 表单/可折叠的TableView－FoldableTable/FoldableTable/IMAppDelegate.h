//
//  IMAppDelegate.h
//  FoldableTable
//
//  Created by huogh on 12-12-26.
//  Copyright (c) 2012年 infomedia. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IMViewController;

@interface IMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) IMViewController *viewController;

@end
