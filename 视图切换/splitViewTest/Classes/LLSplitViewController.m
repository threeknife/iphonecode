    //
//  LLSplitViewController.m
//  splitViewTest
//
//  Created by kindy_imac on 12-3-14.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "LLSplitViewController.h"
#import <QuartzCore/QuartzCore.h>

#define kOverlayWidth 44  //交叉不分的大小
#define kOverlayBufferWidth 10  //阻尼区间宽度

#define kGestureValideWidth 120 //拖动的时候判断显示的那个视图的 宽度

@implementation LLSplitViewController
@synthesize controllerLeft = _controllerLeft;
@synthesize controllerRight = _controllerRight;
@synthesize controllerHome = _controllerHome;
@synthesize overlayView = _overlayView;
@synthesize viewStatu = _viewStatu;
@synthesize controllerShouldShow = _controllerShouldShow;



- (id)initWithLeftController:(UIViewController *)leftController_ rigthController:(UIViewController *)rigthController_  homeController:(UIViewController *)homeController_
{
	if(self = [super init])
	{
		_controllerLeft = [leftController_ retain];
		//_controllerLeft.view.frame = self.view.bounds;
		_controllerRight = [rigthController_ retain];
		//_controllerRight.view.frame = self.view.bounds;
	//	_controllerHome = [[UINavigationController alloc] initWithRootViewController:homeController_]; // [homeController_ retain];
		[self genHomeViewControllerFromController:homeController_];
		_viewStatu = KLLSplitViewStatu_Normal;
	}
	
	return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	self.view.autoresizesSubviews = NO;
	self.view.autoresizingMask	= NO;

    if(_viewStatu == KLLSplitViewStatu_Normal)
	{
		[self.view addSubview:_controllerHome.view];
		
		
		_controllerHome.view.frame = CGRectMake(0, 0, 320, 460);
		
		/*
		UIViewController *vc = [[(UINavigationController *)_controllerHome viewControllers] objectAtIndex:0];
		
	    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"策划" style:UIBarButtonItemStylePlain target:self action:@selector(showLeftView:)];
		vc.navigationItem.leftBarButtonItem = leftItem;
		[leftItem release];
		 */
	}
	
	_controllerLeft.view.frame = self.view.bounds;
	_controllerLeft.view.hidden = NO;
	[self.view addSubview:_controllerLeft.view];
	_controllerRight.view.frame = self.view.bounds;
	_controllerRight.view.hidden = NO;
	[self.view addSubview:_controllerRight.view];

	
	[self.view bringSubviewToFront:_controllerHome.view];
    [super viewDidLoad];
}


-(void)viewWillAppear:(BOOL)animated
{
	//[self.navigationController setNavigationBarHidden:YES animated:NO];
	[super viewWillAppear:animated];
	[_controllerHome viewWillAppear:animated];
	[_controllerLeft viewWillAppear: animated];
	[_controllerRight viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	[_controllerHome viewDidAppear:animated];
	[_controllerLeft viewDidAppear:animated];
	[_controllerRight viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	[_controllerHome viewWillDisappear:animated];
	[_controllerLeft viewWillDisappear:animated];
	[_controllerRight viewWillDisappear:animated];
}

-(void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
	[_controllerHome viewDidDisappear:animated];
	[_controllerLeft viewDidDisappear:animated];
	[_controllerRight viewDidDisappear:animated];
}



//=================================================================================================================
#pragma mark public methods

-(void)pan:(UIPanGestureRecognizer *)pan_
{
	NSLog(@"UIPanGestureRecognizer");
	
	if([_controllerHome.viewControllers count] > 1)
		return;
	
	if(pan_.state == UIGestureRecognizerStateBegan)
	{
		ptBegin = [pan_ translationInView:[[UIApplication sharedApplication] keyWindow]];
		currentCenter = _controllerHome.view.center;
	}
	
	else if(pan_.state == UIGestureRecognizerStateChanged)
	{
		CGPoint ptEnd = [pan_ translationInView:[[UIApplication sharedApplication] keyWindow]];
		//CGPoint ptEnter = _controllerHome.view.center;
		currentCenter.x = 160 + ptEnd.x - ptBegin.x;
		_controllerHome.view.center = currentCenter;
		
		
		if(_controllerHome.view.center.x < 160)
		{
			_controllerLeft.view.hidden = YES;
			_controllerRight.view.hidden = NO;
		}
		else
		{
			_controllerLeft.view.hidden = NO;
			_controllerRight.view.hidden = YES;

		}
	}
	
	else if(pan_.state == UIGestureRecognizerStateEnded)
	{
		CGPoint ptEnter = _controllerHome.view.center;
		
		if(ptEnter.x > 320 - kGestureValideWidth)
		{
			[self showLeftView:YES];
		}
		
		//向左滑 不方便， 
		else if(ptEnter.x < kGestureValideWidth - 160 + 20 + 80)
		{
			[self showRightView:YES];
		}
		else
		{
			[self showHomeView:YES];
		}
	}
}

- (void)genHomeViewControllerFromController:(UIViewController *)controller_
{
	self.controllerHome = [[UINavigationController alloc] initWithRootViewController:controller_];
	[_controllerHome release];
	_controllerHome.delegate = self;
	
	
	
	//[controller_ setValue:self forKey:@"SplitViewController"];
	
	
	//如果是用xcode4.2的 同学请把这个注释打开⋯⋯ 
	/*
	if([self.controllerHome.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
	{
		
		[self.controllerHome.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav-bar.png"] forBarMetrics:UIBarMetricsDefault];
}
	 */
	
	
	UIImageView *ivLeftShadow = [[UIImageView alloc] initWithFrame:CGRectMake(-21, 0, 21, 460)];
	ivLeftShadow.image = [[UIImage imageNamed:@"menu-left-shadow.png"] stretchableImageWithLeftCapWidth:0 topCapHeight:5];
	[_controllerHome.view addSubview:ivLeftShadow];
	[ivLeftShadow release];
	
	//拖放手势
	UIPanGestureRecognizer *panG  = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
	[_controllerHome.view addGestureRecognizer:panG];
	[panG release];
	
	
	//UIGestureRecognizer

	/*
	UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"fafaff" style:UIBarButtonItemStylePlain target:self action:@selector(showLeftView:)];
	controller_.navigationItem.leftBarButtonItem = leftItem;
	[leftItem release];
	 */
	
	controller_.navigationItem.leftBarButtonItem = [UIBarButtonItem BarButtonItemWithImage:[UIImage imageNamed:@"nav-menu-icon.png"] type:KNAV_BARBUTTONITEM_TYPE_ROUNDRECT target:self action:@selector(showLeftView)];
	
}

- (void)showViewController:(UIViewController *)viewController_  animated:(BOOL)animated
{
	
	if(viewController_ == nil)
		return;
	
	self.controllerShouldShow = viewController_;
	
	[UIView beginAnimations:@"hide" context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDelegate: self];
	[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
	
	CGRect frame_ = CGRectMake(0, 0, 320, 460);
	frame_.origin.x = 320;
	_controllerHome.view.frame = frame_;
	[UIView commitAnimations];
}

- (void)pushViewController:(UIViewController *)viewController_  animated:(BOOL)animated
{
	//[self.navigationController setNavigationBarHidden:NO animated:NO];
	
	CATransition *transiton = [CATransition animation];
	transiton.type = kCATransitionPush;
	transiton.subtype = kCATransitionFromRight;

	//transiton.duration = 1.0;
	transiton.removedOnCompletion = NO;
	transiton.fillMode = kCAFillModeForwards;
	[_controllerHome pushViewController:viewController_ animated:NO];
	
	[self.view.layer addAnimation:transiton forKey:@"fjla"];
	
	CGPoint pt = _controllerHome.view.center;
	pt.x = 160;
	
	_controllerHome.view.center = pt;
}


- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
	if([animationID isEqualToString:@"hide"])
	{
		[self.controllerHome.view removeFromSuperview];
		
		[self genHomeViewControllerFromController:_controllerShouldShow];
		
		self.controllerHome.view.frame = CGRectMake(325, 0, 320, 460);
		[self.view addSubview:_controllerHome.view];
		
		[UIView beginAnimations:@"show" context:nil];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView setAnimationDelay:0.1];
		[UIView setAnimationDelegate: self];
		[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
		
		CGRect frame_ = _controllerHome.view.frame;
		frame_.origin.x = 0;
		_controllerHome.view.frame = frame_;
		[UIView commitAnimations];
	}
}

- (void)showLeftView
{
	[self showLeftView:YES];
}

//private
- (void)showLeftView:(BOOL)animated
{
	if(_controllerLeft.view.superview == nil)
	{
		[_controllerLeft viewWillAppear:animated];
	}
	
	[self.view addSubview:_controllerLeft.view];
	[_controllerLeft viewDidAppear:animated];	

	
	[self.view sendSubviewToBack:_controllerLeft.view];
	_controllerLeft.view.hidden = NO;
	
	_controllerRight.view.hidden = YES;
	
	if(animated)
	{
		NSLog(@"controllerhome.position = %@", NSStringFromCGPoint(_controllerHome.view.layer.position));
		
		CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
		animation.values = [NSArray arrayWithObjects:[NSNumber numberWithFloat:_controllerHome.view.center.x], [NSNumber numberWithFloat:320 + 160 - kOverlayWidth + kOverlayBufferWidth],\
							[NSNumber numberWithFloat:320 + 160 - kOverlayWidth], nil];
		animation.keyTimes = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0],[NSNumber numberWithFloat:0.7] , [NSNumber numberWithFloat:1.0], nil];
		animation.duration = 0.3;
		[_controllerHome.view.layer addAnimation:animation forKey:@"fja;f"];
		_controllerHome.view.layer.position = CGPointMake(320 + 160 - kOverlayWidth, _controllerHome.view.center.y);
	}
	
	
	if(self.overlayView == nil)
	{
		self.overlayView = [[LLOverlayView alloc] initWithFrame:_controllerHome.view.frame];
		[_overlayView release];
		_overlayView.delegate = self;
	}
	
	
	_overlayView.frame = _controllerHome.view.frame;
	_viewStatu = KLLSplitViewStatu_Left;
	[self.view addSubview:_overlayView];
}


- (void)showRightView:(BOOL)animated
{
	if(_controllerRight.view.superview == nil)
	{
		[_controllerRight viewWillAppear:animated];
	}
	
	[self.view addSubview:_controllerRight.view];
	[_controllerRight viewDidAppear:animated];
	
	
	[self.view sendSubviewToBack:_controllerRight.view];
	_controllerLeft.view.hidden = YES;
	_controllerRight.view.hidden = NO;
	
	
	if(animated)
	{
		NSLog(@"controllerhome.position = %@", NSStringFromCGPoint(_controllerHome.view.layer.position));
		
		CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
		animation.values = [NSArray arrayWithObjects:[NSNumber numberWithFloat:_controllerHome.view.center.x], [NSNumber numberWithFloat:-160 + kOverlayWidth - kOverlayBufferWidth],\
							[NSNumber numberWithFloat:- 160 + kOverlayWidth], nil];
		animation.keyTimes = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0],[NSNumber numberWithFloat:0.8] , [NSNumber numberWithFloat:1.0], nil];
		animation.duration = 0.3;
		[_controllerHome.view.layer addAnimation:animation forKey:@"fja;f"];
		_controllerHome.view.layer.position = CGPointMake(- 160 + kOverlayWidth, _controllerHome.view.center.y);
	}
	
	
	if(self.overlayView == nil)
	{
		self.overlayView = [[LLOverlayView alloc] initWithFrame:_controllerHome.view.frame];
		[_overlayView release];
		_overlayView.delegate = self;
	}
	
	_overlayView.frame = _controllerHome.view.frame;
	
	//_overlayView.backgroundColor = [UIColor clearColor];
	
	_viewStatu = KLLSpiliViewStatu_Rigth;
	[self.view addSubview:_overlayView];
}


- (void)showHomeView:(BOOL)animated
{
	if(animated)
	{
		NSLog(@"controllerhome.position = %@", NSStringFromCGPoint(_controllerHome.view.layer.position));
		
		CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
		animation.values = [NSArray arrayWithObjects:[NSNumber numberWithFloat:_controllerHome.view.center.x], [NSNumber numberWithFloat:160],\
							 nil];
		animation.keyTimes = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0] , [NSNumber numberWithFloat:1.0], nil];
		animation.duration = 0.3;
		[_controllerHome.view.layer addAnimation:animation forKey:@"fja;f"];
		_controllerHome.view.layer.position = CGPointMake(160, _controllerHome.view.center.y);
	}
	
	if(self.overlayView && self.overlayView.superview)
	{
		[_overlayView removeFromSuperview];
	}
}

#pragma mark  -
#pragma mark  LLOverlayViewDelegate methods 
- (void)overLayViewCenterChanged:(CGPoint)offset_
{
	CGPoint pt_ = _controllerHome.view.center;
	NSLog(@"pt = %@", NSStringFromCGPoint(pt_));
	
	NSLog(@"oofset = %@", NSStringFromCGPoint(offset_));
	
	CGPoint ptCurrent = CGPointMake(pt_.x + offset_.x, pt_.y);
	
	NSLog(@"ptcurrent = %@", NSStringFromCGPoint(ptCurrent));
	
	
	//最左边
	if(ptCurrent.x  < -320 + kOverlayWidth - kOverlayBufferWidth)
	{
		ptCurrent.x = -320 + kOverlayWidth - kOverlayBufferWidth;
	}
	
	//右边
	else  if(ptCurrent.x > 480 - kOverlayWidth + kOverlayBufferWidth)
	{
		ptCurrent.x = 480 - kOverlayWidth + kOverlayBufferWidth;
	}

	
	self.controllerHome.view.center = ptCurrent;
}

- (void)overLayViewTouchEnd:(CGPoint)offset_
{
	CGPoint pt_ = _controllerHome.view.center;
	CGPoint ptCurrent = CGPointMake(pt_.x + offset_.x, pt_.y);
	
	
	if(ptCurrent.x < 320)
	{
		[self showHomeView:YES];
	}
	
	else {
		[self showLeftView:YES];
	}

	
}

- (void)overLayViewTap:(LLOverlayView *)overlayView_
{
	[self showHomeView:YES];
}



#pragma mark UINavigationControllerDelegate methods
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	if(viewController.navigationItem.leftBarButtonItem == nil)
	{
		viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem BarButtonItemWithTitle:@"返回" type:KNAV_BARBUTTONITEM_TYPE_LEFT_Arrow target:navigationController action:@selector(popBackAnimated)];
	}
}
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
	self.controllerHome = nil;
	self.controllerRight = nil;
	self.controllerLeft = nil;
	self.overlayView = nil;
	self.controllerShouldShow = nil;
	
    [super dealloc];
}

@end





//----------------------------------------------------------------------------------------
//
//      LLOverlayView
//
//----------------------------------------------------------------------------------------
@implementation LLOverlayView
@synthesize delegate = _delegate;

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	bTaped = YES;
	UITouch *touch = [touches anyObject];
	
	if(touch.view == self)
	{
		_pointStart = [touch locationInView:[[UIApplication sharedApplication] keyWindow]];
	}
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	bTaped = NO;
	UITouch *touch = [touches anyObject];
	CGPoint ptPre_ = [touch previousLocationInView:[[UIApplication sharedApplication] keyWindow]];
	CGPoint pt_ = [touch locationInView:[[UIApplication sharedApplication] keyWindow]];
	//NSLog(@"touchesMoved   point = %@", NSStringFromCGPoint(pt_));
	
	if(_delegate  && [_delegate respondsToSelector:@selector(overLayViewCenterChanged:)])
	{
		[_delegate overLayViewCenterChanged:CGPointMake(pt_.x -  ptPre_.x, pt_.y - ptPre_.y)];
	}
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [touches anyObject];
	
	CGPoint pt_ = [touch locationInView:[[UIApplication sharedApplication] keyWindow]];
		//NSLog(@"touchesCancelled   point = %@", NSStringFromCGPoint(pt_));
	if(_delegate  && [_delegate respondsToSelector:@selector(overLayViewTouchEnd:)])
	{
		[_delegate overLayViewTouchEnd:CGPointMake(pt_.x -  _pointStart.x, pt_.y - _pointStart.y)];
	}
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [touches anyObject];
	CGPoint pt_ = [touch locationInView:[[UIApplication sharedApplication] keyWindow]];
		NSLog(@" touchesEnded  point = %@", NSStringFromCGPoint(pt_));
	
	if(!bTaped)
	{
		if(_delegate  && [_delegate respondsToSelector:@selector(overLayViewTouchEnd:)])
		{
			[_delegate overLayViewTouchEnd:CGPointMake(pt_.x -  _pointStart.x, pt_.y - _pointStart.y)];
		}
	}
	
	else {
		if(_delegate  && [_delegate respondsToSelector:@selector(overLayViewTap:)])
		{
			[_delegate overLayViewTap:self];
		}
	}
}


- (void)dealloc
{
	[super dealloc];
}

@end

