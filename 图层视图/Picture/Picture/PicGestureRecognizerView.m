//
//  PicGestureRecognizerView.m
//  Picture
//
//  Created by ruijuan kang on 12-2-3.
//  Copyright (c) 2012年 NetQin. All rights reserved.
//

#import "PicGestureRecognizerView.h"

@implementation PicGestureRecognizerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.userInteractionEnabled = YES;
        self.multipleTouchEnabled = YES;
        self.backgroundColor = [UIColor purpleColor];
        photoImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        photoImage.image = [UIImage imageNamed:@"new.png"];
        [self addSubview:photoImage];
        photoImage.userInteractionEnabled = YES;
        UIPinchGestureRecognizer *pinchRecognizer = [[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scale:)] autorelease];
        [pinchRecognizer setDelegate:self];
        [self addGestureRecognizer:pinchRecognizer]; 
        
        UIRotationGestureRecognizer *rotationRecognizer = [[[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotate:)] autorelease];
        [rotationRecognizer setDelegate:self];
        [self addGestureRecognizer:rotationRecognizer];

        UIPanGestureRecognizer *panRecognizer = [[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(move:)] autorelease];
	    [panRecognizer setMinimumNumberOfTouches:1];
	    [panRecognizer setMaximumNumberOfTouches:1];
	    [panRecognizer setDelegate:self];
	    [photoImage addGestureRecognizer:panRecognizer];
	 
	    UITapGestureRecognizer *tapProfileImageRecognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)] autorelease];
	    [tapProfileImageRecognizer setNumberOfTapsRequired:1];
	    [tapProfileImageRecognizer setDelegate:self];
	    [photoImage addGestureRecognizer:tapProfileImageRecognizer];
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

- (void)showOverlayWithFrame:(CGRect)changeframe
{
    self.bounds = changeframe;
}

-(void)scale:(id)sender {
	 
    if([(UIPinchGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
      _lastScale = 1.0;
    }
 
    CGFloat scale = 1.0 - (_lastScale - [(UIPinchGestureRecognizer*)sender scale]);
 
    CGAffineTransform currentTransform = photoImage.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, scale, scale);
 
    [photoImage setTransform:newTransform];
 
    _lastScale = [(UIPinchGestureRecognizer*)sender scale];
    [self showOverlayWithFrame:photoImage.frame];
}
 
// 旋转
-(void)rotate:(id)sender {
 
    if([(UIRotationGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
 
      _lastRotation = 0.0;
      return;
    }
 
    CGFloat rotation = 0.0 - (_lastRotation - [(UIRotationGestureRecognizer*)sender rotation]);
    CGAffineTransform currentTransform = photoImage.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform,rotation);
 
    [photoImage setTransform:newTransform];
 
    _lastRotation = [(UIRotationGestureRecognizer*)sender rotation];
    [self showOverlayWithFrame:photoImage.frame];
}
 
// 移动
-(void)move:(id)sender {
 
  CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView:self];
 
  if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
    _firstX = [photoImage center].x;
    _firstY = [photoImage center].y;
  }
 
  translatedPoint = CGPointMake(_firstX+translatedPoint.x, _firstY+translatedPoint.y);
 
  [photoImage setCenter:translatedPoint];
  [self showOverlayWithFrame:photoImage.frame];
}

@end
