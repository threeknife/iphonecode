//
//  ____statusBarViewController.h
//  可点击的statusBar
//
//  Created by jianghui.liu on 12-7-2.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTStatusBarOverlay.h"

@interface ____statusBarViewController : UIViewController<MTStatusBarOverlayDelegate> {
    UITextField             *immediateField;
    UITextField             *clickField;
}
@property (nonatomic, retain) IBOutlet UITextField			*immediateField;
@property (nonatomic, retain) IBOutlet UITextField			*clickField;

-(IBAction)postImmediateMsg:(UIButton*)sender;
-(IBAction)postClickMsg:(UIButton*)sender;

@end

