//
//  SecondViewController.h
//  GestureTest
//
//  Created by gamy on 11-12-30.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface SecondViewController : UIViewController<UIGestureRecognizerDelegate> {
    
    UIImageView *image;
    CGPoint oldPisition;
    CATransform3D oldTransform;
}
@property (nonatomic, retain) IBOutlet UIImageView *image;

@end
