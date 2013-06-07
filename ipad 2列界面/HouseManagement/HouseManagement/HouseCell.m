//
//  HouseCell.m
//  HouseManagement
//
//  Created by  on 12-5-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HouseCell.h"

@implementation HouseCell
@synthesize ttarea;
@synthesize floor;
@synthesize houseNumber;
@synthesize salePrice;
@synthesize uptown;
@synthesize address;
@synthesize perPrice;
@synthesize price;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
