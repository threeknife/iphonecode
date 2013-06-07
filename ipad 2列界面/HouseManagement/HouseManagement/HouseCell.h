//
//  HouseCell.h
//  HouseManagement
//
//  Created by  on 12-5-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HouseCell : UITableViewCell
{
    IBOutlet UILabel*houseNumber;
    IBOutlet UILabel*uptown;
    IBOutlet UILabel*salePrice;
    IBOutlet UILabel*floor;
    IBOutlet UILabel*ttarea;
    IBOutlet UILabel*address;
    IBOutlet UILabel*perPrice;
    IBOutlet UILabel*price;
}
@property(nonatomic,retain)IBOutlet UILabel*price;
@property(nonatomic,retain)IBOutlet UILabel*perPrice;
@property(nonatomic,retain)IBOutlet UILabel*address;
@property(nonatomic,retain)IBOutlet UILabel*houseNumber;
@property(nonatomic,retain)IBOutlet UILabel*uptown;
@property(nonatomic,retain)IBOutlet UILabel*salePrice;
@property(nonatomic,retain)IBOutlet UILabel*floor;
@property(nonatomic,retain)IBOutlet UILabel*ttarea;
@end
