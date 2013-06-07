//
//  ExperimentView.m
//  Experiment
//
//  Created by Terry Lin on 12-5-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ExperimentView.h"
#import "UIImage+SplitImageIntoTwoParts.h"
@implementation ExperimentView
@synthesize image = _image;
@synthesize isSpliting = _isSpliting;
@synthesize left = _left;
@synthesize right = _right;




-(void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    if ([animationID isEqualToString:@"split"] && finished) {
        self.image.hidden = NO;
        [self.left removeFromSuperview];
        [self.right removeFromSuperview];
    }  
}
-(void)pinch:(UIPinchGestureRecognizer*)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        if (recognizer.scale>1) {
            self.isSpliting = YES;
            NSArray *array = [UIImage splitImageIntoTwoParts:self.image.image];
            self.left = [[UIImageView alloc] initWithImage:[array objectAtIndex:0]];
            self.right = [[UIImageView alloc] initWithImage:[array objectAtIndex:1]];
            [self addSubview:self.left];
            [self addSubview:self.right];
            [self.image setHidden:YES];
            
        }else{
            self.isSpliting = NO;
        }        
    }else if (recognizer.state == UIGestureRecognizerStateChanged) {
        if (self.isSpliting) {
            self.left.transform = CGAffineTransformMakeTranslation(-160*(recognizer.scale-1), 0);
            self.right.transform = CGAffineTransformMakeTranslation(160*(recognizer.scale-1), 0);            
        }
    }else if (recognizer.state == UIGestureRecognizerStateEnded){
        [UIView beginAnimations:@"split" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
        self.left.transform = CGAffineTransformIdentity;
        self.right.transform = CGAffineTransformIdentity;
        [UIView commitAnimations];

    }

}



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"test6.jpg"]];
//        self.image.center = self.center;//CGPointMake(160, 240);
        [self addSubview:self.image];
        
        UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
        [self addGestureRecognizer:pinchRecognizer];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
