//
//  CustomCell.h
//  Cells
//
//  Created by nicky on 10-5-20.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomCell : UITableViewCell {
	IBOutlet UILabel *nameLabel;
	IBOutlet UILabel *colorLabel;
	IBOutlet NSInteger index;
}
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *colorLabel;


@end
