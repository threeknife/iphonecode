//
//  LLViewExtend.m
//  newjiudian
//
//  Created by kindy_imac on 12-3-21.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "LLViewExtend.h"


//-------------------------------------------------------------------------------------------------------------
//
// UINavigationBar(clm)
//
//--------------------------------------------------------------------------------------------------------------
@implementation UINavigationBar(clm)
-(void)drawRect:(CGRect)rect
{
	//导航栏阴影 (这样做好山寨啊  ！！！！！）
	UIImageView *ivShadow_ = (UIImageView *)[self viewWithTag:999];
	if(ivShadow_ == nil)
	{	UIImageView *ivShadow_ = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, 320, 2)];
		ivShadow_.tag = 999;
		ivShadow_.image = [UIImage imageNamed:@"nav_shadow.png"];
		[self addSubview:ivShadow_];
		[ivShadow_ release];
	}
	
	self.backgroundColor = [UIColor clearColor];
	[super drawRect:rect];
	//UIImage *image = [UIImage imageNamed:@"Navigation_bg.png"];
	UIImage *image = [UIImage imageNamed:@"nav-bar.png"];
	[image drawInRect:CGRectMake(0.0, 0, 320.0, 44.0)];
	
}
@end



@implementation UIToolbar (CustomImage)  
- (void)drawRect:(CGRect)rect {  
	//	self.tintColor=[UIColor colorWithRed:74.0/255 green:75.0/255 blue:86.0/255 alpha:1.0];
    UIImage *image = [[UIImage imageNamed:@"toolbar_bg_icon.png"] stretchableImageWithLeftCapWidth:9 topCapHeight:0];  
    [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
	
}  
@end




//-------------------------------------------------------------------------------------------------------------
//
// LLTNavTitleLabel
//
//--------------------------------------------------------------------------------------------------------------
@implementation LLTNavTitleLabel
+ (UILabel *)labelWithTitle:(NSString *)title
{
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 7, 200, 30)];
	label.backgroundColor = [UIColor clearColor];
	label.font = [UIFont boldSystemFontOfSize:20];
	label.text = title;
	[label sizeToFit];
	label.textColor = [UIColor whiteColor];
	label.shadowColor = [UIColor blackColor];
	label.shadowOffset = CGSizeMake(0, -0.5);
	return [label autorelease];
}
@end


//-------------------------------------------------------------------------------------------------------------
//
// UIBarButtonItem(clm)
//
//--------------------------------------------------------------------------------------------------------------
@implementation UIBarButtonItem(clm)
float fHeight = 30;
float fMinWidth = 51 - 3;
+(id)BarButtonItemWithTitle:(NSString *)title  type:(Nav_bar_type)barType target:(id)target action:(SEL)selector
{
	
	
	UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 4, 60, fHeight)];
	btn.backgroundColor = [UIColor clearColor];
	[btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
	[btn setTitle:title forState:UIControlStateNormal];
	btn.titleLabel.font = [UIFont systemFontOfSize:13];
	btn.titleLabel.backgroundColor =[UIColor clearColor];
	//	btn.titleLabel.frame = CGRectMake(20, 5, 5, 40);
	
    CGSize cs = [title sizeWithFont:[UIFont boldSystemFontOfSize:14]];
	
	float width = 0;
	
	if(barType == KNAV_BARBUTTONITEM_TYPE_LEFT_Arrow)
	{
		[btn setBackgroundImage:[[UIImage imageNamed:@"nav-bar-back-button.png"] stretchableImageWithLeftCapWidth:17 topCapHeight:0] forState:UIControlStateNormal];
		[btn setBackgroundImage:[[UIImage imageNamed:@"nav-bar-back-button-pressed.png"] stretchableImageWithLeftCapWidth:17 topCapHeight:0] forState:UIControlStateHighlighted];
		
		width = cs.width > 43 ? (14 + cs.width) : (43 + 14);
		
		btn.frame = CGRectMake(0, 5.0, width, fHeight);
		btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0); 
	}
	
	else
	{
		[btn setBackgroundImage:[[UIImage imageNamed:@"nav_roundrect_iconN.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:10] forState:UIControlStateNormal];
		[btn setBackgroundImage:[[UIImage imageNamed:@"nav_roundrect_iconH.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:10] forState:UIControlStateHighlighted];
		
		width = cs.width > (fMinWidth - 20) ?  cs.width + 20 : fMinWidth;
		
		NSLog(@"barbuttonitem width = %f", width);
		btn.frame = CGRectMake(0, 5.0, width, fHeight);
	}
	
	btn.titleLabel.shadowColor = [UIColor blackColor];
	btn.titleLabel.shadowOffset = CGSizeMake(0.2, -1);
	btn.titleLabel.textAlignment = UITextAlignmentCenter;
	//[btn sizeToFit];
	
	UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
	[btn release];
	
	return [backItem autorelease];
}

+(id)BarButtonItemWithImage:(UIImage *)img  type:(Nav_bar_type)barType target:(id)target action:(SEL)selector
{
	UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, fMinWidth, fHeight)];
	[btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
	
	
	if (barType != KNAV_BARBUTTONITEM_TYPE_NONE) 
	{
		[btn setBackgroundImage:[[UIImage imageNamed:@"nav-bar-button.png"] stretchableImageWithLeftCapWidth:9 topCapHeight:10] forState:UIControlStateNormal];
		[btn setBackgroundImage:[[UIImage imageNamed:@"nav-bar-button-pressed.png"] stretchableImageWithLeftCapWidth:9 topCapHeight:10] forState:UIControlStateHighlighted];
	}
	
	/*
	else 
	{
		[btn setBackgroundImage:img stretchableImageWithLeftCapWidth:15 topCapHeight:10] forState:UIControlStateNormal];
		[btn setBackgroundImage:[[UIImage imageNamed:@"nav_roundrect_iconH.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:10] forState:UIControlStateHighlighted];
	}
	 */

	UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake((btn.frame.size.width - img.size.width) / 2.0 , (btn.frame.size.height - img.size.height) / 2.0 , img.size.width, img.size.height)];
	iv.image  = img;
	[btn addSubview:iv];
	iv.tag = 400;
	iv.center = CGPointMake(fMinWidth / 2.0 , fHeight / 2.0 -0.5);
	[iv release];
	
	UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
	[btn release];
	
	return [backItem autorelease];
}

@end

//-------------------------------------------------------------------------------------------------------------
//
// UINavigationController(clm)
//
//--------------------------------------------------------------------------------------------------------------
@implementation UINavigationController(clm)
-(void)popBackAnimated;
{
	[self popViewControllerAnimated:YES];
}
@end


//-------------------------------------------------------------------------------------------------------------
//
// LLLineView
//
//--------------------------------------------------------------------------------------------------------------
@implementation LLLineView
+(id)viewWithFrame:(CGRect)frame backgroundColor:(UIColor *)bgColor
{
	LLLineView *view_ = [[LLLineView alloc] initWithFrame:frame];
	view_.backgroundColor = bgColor;
	return [view_ autorelease];
}

+(id)whiteLineView
{
	LLLineView *view_ = [[LLLineView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
	view_.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.2];
	return [view_ autorelease];
}

+(id)grayLineView
{
	LLLineView *view_ = [[LLLineView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
	view_.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.2];
	return [view_ autorelease];
}
+(id)grayLineView:(CGRect)frame
{
	LLLineView *view_ = [[LLLineView alloc] initWithFrame:frame];
	view_.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.2];
	return [view_ autorelease];

}

@end

//-------------------------------------------------------------------------------------------------------------
//
// UIAlertView(aligment)
//
//--------------------------------------------------------------------------------------------------------------
@implementation UIAlertView(LLAligment)

-(void)showWithLeftAligment
{
	[self show];
	
	for(UIView *label in [self subviews])
	{
		if([label isKindOfClass:[UILabel class]] && label.frame.size.height > 40)
		{
			((UILabel *)label).textAlignment = UITextAlignmentLeft;
			break;
		}
	}
}


@end


