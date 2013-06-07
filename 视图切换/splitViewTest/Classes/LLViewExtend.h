//
//  LLViewExtend.h
//  newjiudian
//
//  Created by kindy_imac on 12-3-21.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
//-------------------------------------------------------------------------------------------------------------
//
// UINavigationBar(clm)
//
//--------------------------------------------------------------------------------------------------------------
@interface UINavigationBar(clm)
-(void)drawRect:(CGRect)rect;
@end



//-------------------------------------------------------------------------------------------------------------
//
// UIToolbar (CustomImage)  
//
//--------------------------------------------------------------------------------------------------------------
@interface  UIToolbar (CustomImage)
-(void)drawRect:(CGRect)rect;
@end

//-------------------------------------------------------------------------------------------------------------
//
// LLTNavTitleLabel
//
//--------------------------------------------------------------------------------------------------------------
@interface LLTNavTitleLabel : UILabel
+ (UILabel *)labelWithTitle:(NSString *)title;
@end



typedef enum
{
	KNAV_BARBUTTONITEM_TYPE_LEFT_Arrow = 1, //左邊有箭頭
	KNAV_BARBUTTONITEM_TYPE_RIGHT_Arrow,    //右边有箭头
	KNAV_BARBUTTONITEM_TYPE_ROUNDRECT,      //无箭头
	KNAV_BARBUTTONITEM_TYPE_NONE            //无边框
}Nav_bar_type;

//-------------------------------------------------------------------------------------------------------------
//
// UIBarButtonItem(clm)
//
//--------------------------------------------------------------------------------------------------------------
@interface UIBarButtonItem(clm)
+(id)BarButtonItemWithTitle:(NSString *)title  type:(Nav_bar_type)barType target:(id)target action:(SEL)selector;
+(id)BarButtonItemWithImage:(UIImage *)img  type:(Nav_bar_type)barType target:(id)target action:(SEL)selector;
@end

//-------------------------------------------------------------------------------------------------------------
//
// UIBarButtonItem(clm)
//
//--------------------------------------------------------------------------------------------------------------
//返回
@interface UINavigationController(clm)
-(void)popBackAnimated;
@end

//-------------------------------------------------------------------------------------------------------------
//
// LLLineView
//
//--------------------------------------------------------------------------------------------------------------
@interface LLLineView : UIView
+(id)viewWithFrame:(CGRect)frame backgroundColor:(UIColor *)bgColor;
+(id)whiteLineView;
+(id)grayLineView;
+(id)grayLineView:(CGRect)frame;
@end


//-------------------------------------------------------------------------------------------------------------
//
// UIAlertView(aligment)
//
//--------------------------------------------------------------------------------------------------------------

@interface UIAlertView(LLAligment)


-(void)showWithLeftAligment;


@end


