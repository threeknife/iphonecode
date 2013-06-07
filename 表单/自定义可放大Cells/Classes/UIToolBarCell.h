//
//  UIToolBarCell.h
//  Cells
//
//  Created by Peng Lingzhe on 6/8/10.
//  Copyright 2010 Ericsson. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIToolBarCell : UITableViewCell {

	// set by external
	NSMutableArray*	buttonList;
	NSString*		backgroundName;
	int				cellCollapseHeight;
	int				cellExpandHeight;
	
}

@property (nonatomic, retain) NSMutableArray*	buttonList;
@property (nonatomic, retain) NSString*			backgroundName;
@property (nonatomic)		  int				cellCollapseHeight;
@property (nonatomic)		  int				cellExpandHeight;

@end
