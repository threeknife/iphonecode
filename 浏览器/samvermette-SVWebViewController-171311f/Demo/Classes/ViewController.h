//
//  RootViewController.h
//  SVWebViewController
//
//  Created by Sam Vermette on 21.02.11.
//  Copyright 2011 Sam Vermette. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SVWebViewController;
@interface ViewController : UIViewController
{
    SVWebViewController *webViewController;
}

- (IBAction)pushWebViewController;
- (IBAction)presentWebViewController;
- (IBAction)release:(id)sender;
@end
