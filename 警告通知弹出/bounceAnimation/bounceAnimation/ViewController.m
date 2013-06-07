//
//  ViewController.m
//  bounceAnimation
//
//  Created by JianYe on 12-12-18.
//  Copyright (c) 2012年 JianYe. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface ViewController ()

@end

@implementation ViewController
@synthesize subview;

- (void)dealloc
{
    self.subview = nil;
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.subview.layer.borderWidth = 5.0f;
    self.subview.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.subview.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.6, 0.6);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showAnimation:(id)sender
{
    
    [UIView animateWithDuration:0.2 animations:
     ^(void){
         self.subview.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.1f, 1.1f);
         self.subview.alpha = 0.5;
    }
                     completion:^(BOOL finished){
                         [self bounceOutAnimationStoped];
                     }];
}
- (void)bounceOutAnimationStoped
{
    [UIView animateWithDuration:0.1 animations:
     ^(void){
         self.subview.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.9, 0.9);
         self.subview.alpha = 0.8;
     }
                     completion:^(BOOL finished){
                         [self bounceInAnimationStoped];
                     }];
}
- (void)bounceInAnimationStoped
{
    [UIView animateWithDuration:0.1 animations:
     ^(void){
         self.subview.transform = CGAffineTransformScale(CGAffineTransformIdentity,1, 1);
         self.subview.alpha = 1.0;
     }
                     completion:^(BOOL finished){
                         [self animationStoped];
                     }];
}
- (void)animationStoped
{
    
}

- (IBAction)hide:(id)sender
{
    self.subview.alpha = 0;
     self.subview.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.6, 0.6);
}
@end
