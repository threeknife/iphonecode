//
//  CustomCell.m
//  Cells
//
//  Created by nicky on 10-5-20.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CustomCell.h"


@implementation CustomCell

@synthesize nameLabel;
@synthesize colorLabel;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        // Initialization code
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

	if (selected) {
		
		UIImageView* image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.jpg"]];
		
		//create toolbar using new
		UIToolbar *toolbar = [[UIToolbar alloc] init];
		toolbar.barStyle = UIBarStyleDefault;
		//[toolbar sizeToFit];
		toolbar.frame = CGRectMake(0, 66, 320, 44);
		toolbar.tag = 1;
		
		toolbar.tintColor = [UIColor clearColor];
		toolbar.backgroundColor = [UIColor clearColor];
		toolbar.translucent = YES;
		
		//Add buttons
		UIBarButtonItem *systemItem1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
		                                                                             target:self
		                                                                             action:@selector(pressButton1:)];
		
		UIBarButtonItem *systemItem2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
		                                                                             target:self
		                                                                             action:@selector(pressButton2:)];
		
		UIBarButtonItem *systemItem3 = [[UIBarButtonItem alloc]
										initWithBarButtonSystemItem:UIBarButtonSystemItemCamera
										target:self action:@selector(pressButton3:)];
		
		UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
		[button setBackgroundImage:[UIImage imageNamed:@"button.jpg"] forState:UIControlStateNormal];
		[button sizeToFit];
		systemItem3.customView = button;
		
		//Use this to put space in between your toolbox buttons
		UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
																				  target:nil
																				  action:nil];
		
		//Add buttons to the array
		NSArray *items = [NSArray arrayWithObjects: systemItem1, flexItem, systemItem2, flexItem, systemItem3, nil];
		
		//release buttons
		[systemItem1 release];
		[systemItem2 release];
		[systemItem3 release];
		[flexItem release];
		
		//add array of buttons to toolbar
		[toolbar setItems:items animated:NO];
		
		CGRect rect = toolbar.frame;
		
//		CGRect rect = CGRectMake(self.contentView.frame.origin.x, 100, self.contentView.frame.size.width, toolbar.frame.size.height);
//		image.frame = rect;
		
		[image sizeToFit];
		rect.origin.y = 120;
		image.frame = rect;

		[self addSubview:image];
		[self addSubview:toolbar];
		
		[self sizeToFit];
		
		
		[image release];
		[toolbar release];
	
	} else {
		
		
		for (UIView *v in [self subviews]) {
			
			if (v.tag == 1) {
			
				[v removeFromSuperview];
			}
			
			
		}
		
	
	}
}

//Action methods for toolbar buttons:
- (void) pressButton1:(id)sender{
	//label.text = @"Add";
}
- (void) pressButton2:(id)sender{
	//label.text = @"Take Action";
}
- (void) pressButton3:(id)sender{
	//label.text = @"Camera";
}


- (void)dealloc {
	[nameLabel release];
	[colorLabel release];
    [super dealloc];
}


@end
