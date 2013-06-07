//
//  UIToolBarCell.m
//  Cells
//
//  Created by Peng Lingzhe on 6/8/10.
//  Copyright 2010 Ericsson. All rights reserved.
//

#import "UIToolBarCell.h"


@implementation UIToolBarCell

@synthesize buttonList, backgroundName, cellCollapseHeight, cellExpandHeight;

- (int)getExtraHeight
{
	return cellExpandHeight - cellCollapseHeight;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	
	static int kSubViewFlag = 223456;

	self.selectionStyle = UITableViewCellSelectionStyleNone;
	
    [super setSelected:selected animated:animated];
	
	if (selected) {
		
		// set frame rect
		CGRect rect = CGRectMake(0, cellCollapseHeight, self.contentView.frame.size.width, [self getExtraHeight]);

		// set background image
		UIImageView* image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:backgroundName]];
		image.frame = rect;
		image.tag = kSubViewFlag;		
		[self addSubview:image];
		
		if ([buttonList count] <= 0)
			return;
		
		// add button on top of image background
		int buttonMaxWidth = self.contentView.frame.size.width / [buttonList count];		
		CGRect buttonRect = rect;
		int startX = 0;
		int startY = cellCollapseHeight;		
		for (UIButton* button in buttonList){
			
			int buttonStartIndent = ( buttonMaxWidth - button.frame.size.width ) / 2;
			
			buttonRect.origin.x    = startX + buttonStartIndent;
			buttonRect.origin.y	   = startY + ( [self getExtraHeight] - button.frame.size.height ) / 2;			
			buttonRect.size.width = button.frame.size.width;
			buttonRect.size.height = button.frame.size.height;						
			button.frame = buttonRect;
			button.tag   = kSubViewFlag;
			[self addSubview:button];
			
			startX += buttonMaxWidth;
		}
				
		return;		
		
	} else {
				
		// remove all extra expand subview
		for (UIView *v in [self subviews]) {			
			if (v.tag == kSubViewFlag) {				
				[v removeFromSuperview];
			}						
		}
		
		
	}
}

- (void)dealloc {
	
	[buttonList release];
	[backgroundName release];
    [super dealloc];
}

@end
