//
//  LLSplitViewController.h
//  splitViewTest
//
//  Created by kindy_imac on 12-3-14.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


//#define kCGRectLeftView  CGRectMake(0, 0, 320, 460)

@class LLOverlayView;
@protocol LLOverlayViewDelegate;


typedef enum
{
	KLLSplitViewStatu_Normal = 1,
	KLLSplitViewStatu_Left , //左边的视图出来
	KLLSpiliViewStatu_Rigth
}LLSplitViewStatu;

@interface LLSplitViewController : UIViewController
<LLOverlayViewDelegate,
UINavigationControllerDelegate>
{
    UIViewController *_controllerLeft;
	UIViewController *_controllerRight;
	UINavigationController *_controllerHome;
	
	LLOverlayView *_overlayView;
	LLSplitViewStatu _viewStatu;
	
	UIViewController *_controllerShouldShow;
	
	CGPoint ptBegin; //拖动的时候的最开始的位置
	CGPoint currentCenter; //home当前的中心
}

@property (nonatomic, retain) UIViewController *controllerLeft;
@property (nonatomic, retain) UIViewController *controllerRight;
@property (nonatomic, retain) UINavigationController *controllerHome;
@property (nonatomic, retain) LLOverlayView *overlayView;
@property (nonatomic, assign) LLSplitViewStatu viewStatu;

@property (nonatomic, retain) UIViewController *controllerShouldShow;

- (id)initWithLeftController:(UIViewController *)leftController_ rigthController:(UIViewController *)rigthController_  homeController:(UIViewController *)homeController_;

- (void)genHomeViewControllerFromController:(UIViewController *)controller_;

- (void)showViewController:(UIViewController *)viewController_  animated:(BOOL)animated;

- (void)pushViewController:(UIViewController *)viewController_  animated:(BOOL)animated;

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context;


- (void)showLeftView;

- (void)showLeftView:(BOOL)animated;

- (void)showRightView:(BOOL)animated;

- (void)showHomeView:(BOOL)animated;

@end





//overlayview
//----------------------------------------------------------------------------------------
//
//      LLOverlayView
//
//----------------------------------------------------------------------------------------
@protocol LLOverlayViewDelegate;
@interface LLOverlayView:UIView
{
	BOOL bTaped; //是否是点击儿不是拖动
	CGPoint _pointStart;
	id<LLOverlayViewDelegate> _delegate;
}

@property (nonatomic, assign) id<LLOverlayViewDelegate> delegate;

@end


//----------------------------------------------------------------------------------------
//
//      LLOverlayViewDelegate
//
//----------------------------------------------------------------------------------------
@protocol LLOverlayViewDelegate<NSObject>
@optional
- (void)overLayViewCenterChanged:(CGPoint)offset_;
- (void)overLayViewTouchEnd:(CGPoint)offset_;
- (void)overLayViewTap:(LLOverlayView *)overlayView_;
@end