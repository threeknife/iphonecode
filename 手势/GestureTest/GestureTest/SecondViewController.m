//
//  SecondViewController.m
//  GestureTest
//
//  Created by gamy on 11-12-30.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "SecondViewController.h"
#import "FirstViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation SecondViewController
@synthesize image;

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/
- (void)performAlert:(NSString *)msg
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"手势" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alertView show];
    [alertView release];
}
- (void)performSwipeGesture:(UISwipeGestureRecognizer *)recognizer
{
    NSLog(@"performSwipeGesture:");
    if(recognizer.state != UIGestureRecognizerStateEnded){
        NSLog(@"not UIGestureRecognizerStateEnded");
    }else {
        [self performAlert:@"轻扫"];
    }
}
- (void)performRotationSwipeGesture:(UIRotationGestureRecognizer *)recognizer
{
    
    NSLog(@"PerformRotationSwipeGesture:");
    if(recognizer.state == UIGestureRecognizerStateChanged){
        CGFloat rotation = recognizer.rotation;
        NSLog(@"rotation = %f",rotation);
        image.layer.anchorPoint = CGPointMake(0.5, 0.5);
        image.layer.transform = CATransform3DRotate(oldTransform, rotation, 0, 0, 1);

    }else if(recognizer.state == UIGestureRecognizerStateEnded){
        oldTransform = image.layer.transform;
    }
}

- (void)performLongPressGesture:(UILongPressGestureRecognizer *)recognizer
{
    NSLog(@"performLongPressGesture:");
    
    
    if(recognizer.state == UIGestureRecognizerStateBegan){
        
        CABasicAnimation * animation = [CABasicAnimation 
                                        animationWithKeyPath:@"opacity"]; 
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        animation.toValue = [NSNumber numberWithFloat:0.05];
        animation.duration = 2 ;
        animation.repeatCount = 100;
        animation.autoreverses = YES;
        [image.layer addAnimation:animation forKey:@"opacity"];

    }else if(recognizer.state == UIGestureRecognizerStateEnded){
        [image.layer removeAllAnimations];
    }
}
- (void)performTapGesture:(UITapGestureRecognizer *)recognizer
{
    NSLog(@"performTapGesture:");
    if(recognizer.state != UIGestureRecognizerStateEnded){
        NSLog(@"not UIGestureRecognizerStateEnded");
    }else {
        [self performAlert:@"点击"];
    }
}
- (void)performPinchGesture:(UIPinchGestureRecognizer *)recognizer
{
    NSLog(@"performPinchGesture: state: %d",recognizer.state);
    
    if(recognizer.state == UIGestureRecognizerStateChanged){
        CGFloat scale = recognizer.scale;
        NSLog(@"scale = %f",scale);
        image.layer.transform = CATransform3DScale(oldTransform, scale, scale, scale);
    }else if(recognizer.state == UIGestureRecognizerStateEnded){
        oldTransform = image.layer.transform;
    }
}
- (void)performPanGesture:(UIPanGestureRecognizer *)recognizer
{
    if(recognizer.state == UIGestureRecognizerStateChanged){
        CGPoint point = [recognizer translationInView:image];
        image.layer.position = CGPointMake(oldPisition.x + point.x, oldPisition.y + point.y);
    }
    if(recognizer.state == UIGestureRecognizerStateEnded)
    {
        oldPisition = image.layer.position;
    }
}

- (void)view:(UIView *)view addGestureRecognizer:(NSInteger)type 
    delegate:(id<UIGestureRecognizerDelegate>)delegate
{
    UIGestureRecognizer *recognizer = nil;
    SEL action = nil;
    switch (type) {
        case LongPressGestureRecognizer:
            action = @selector(performLongPressGesture:);
            recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:action];
            break;
        case PanGestureRecognizer:
            action = @selector(performPanGesture:);
            recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:action];
            break;
        case PinchGestureRecognizer:
            action = @selector(performPinchGesture:);
            recognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:action];
            break;
        case RotationGestureRecognizer:
            action = @selector(performRotationSwipeGesture:);
            recognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:action];
            break;
        case SwipeGestureRecognizer:
            action = @selector(performSwipeGesture:);
            recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:action];
            break;
        case TapGestureRecognizer:
            action = @selector(performTapGesture:);
            recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:action];
            ((UITapGestureRecognizer *)recognizer).numberOfTapsRequired = 1;
            break;
        default:
            return;
    }
    recognizer.delegate = delegate;
    [view addGestureRecognizer:recognizer];
    [recognizer release];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    for (int i = 0; i < RecognizerTypeCount; ++ i) {
        [self view:image addGestureRecognizer:i delegate:self];
    }
    image.userInteractionEnabled = YES;
    image.multipleTouchEnabled = YES;
    oldPisition = image.layer.position;
    oldTransform = image.layer.transform;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (touch.view == image) {
        return YES;
    }
    return NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload
{
    [self setImage:nil];
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc
{
    [image release];
    [super dealloc];
}

@end
