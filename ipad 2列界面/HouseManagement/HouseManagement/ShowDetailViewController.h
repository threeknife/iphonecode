//
//  ShowDetailViewController.h
//  HouseManagement
//
//  Created by  on 12-5-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ShowDetailViewController : UIViewController
{
    IBOutlet UILabel*area;
    IBOutlet UILabel*balcony;
    IBOutlet UILabel*commissionNumber;
    IBOutlet UILabel*decoration;
    IBOutlet UILabel*furniture;
    IBOutlet UILabel*floor;
    IBOutlet UILabel*hall;
    IBOutlet UILabel*houseApplication;
    IBOutlet UILabel*houseNumber;
    IBOutlet UILabel*onCommission;
    IBOutlet UILabel*person;
    IBOutlet UILabel*region;
    IBOutlet UITextView*remark;
    IBOutlet UILabel*rentPrice;
    IBOutlet UILabel*room;
    IBOutlet UILabel*salePrice;
    IBOutlet UILabel*shop;
    IBOutlet UILabel*status;
    IBOutlet UILabel*submitted;
    IBOutlet UILabel*supporting;
    IBOutlet UILabel*toilet;
    IBOutlet UILabel*transaction;
    IBOutlet UILabel*ttarea;
    IBOutlet UILabel*ttfloor;
    IBOutlet UILabel*uptown;
    IBOutlet UILabel*delegate;
    IBOutlet UILabel*perPrice;
    IBOutlet UILabel*balconyText;
    IBOutlet UIScrollView*mainScrollView;
    IBOutlet UIScrollView*pictureScrollView;
    NSMutableDictionary*dataResource;
}
@property(nonatomic,strong)NSMutableDictionary*dataResource;
@property(nonatomic,strong)IBOutlet UIScrollView*pictureScrollView;
@property(nonatomic,strong)IBOutlet UIScrollView*mainScrollView;
@property(nonatomic,strong)IBOutlet UILabel*balconyText;
@property(nonatomic,strong)IBOutlet UILabel*perPrice;
@property(nonatomic,strong)IBOutlet UILabel*delegate;
@property(nonatomic,strong)IBOutlet UILabel*area;
@property(nonatomic,strong)IBOutlet UILabel*balcony;
@property(nonatomic,strong)IBOutlet UILabel*commissionNumber;
@property(nonatomic,strong)IBOutlet UILabel*decoration;
@property(nonatomic,strong)IBOutlet UILabel*furniture;
@property(nonatomic,strong)IBOutlet UILabel*floor;
@property(nonatomic,strong)IBOutlet UILabel*hall;
@property(nonatomic,strong)IBOutlet UILabel*houseApplication;
@property(nonatomic,strong)IBOutlet UILabel*houseNumber;
@property(nonatomic,strong)IBOutlet UILabel*onCommission;
@property(nonatomic,strong)IBOutlet UILabel*person;
@property(nonatomic,strong)IBOutlet UILabel*region;
@property(nonatomic,strong)IBOutlet UITextView*remark;
@property(nonatomic,strong)IBOutlet UILabel*rentPrice;
@property(nonatomic,strong)IBOutlet UILabel*room;
@property(nonatomic,strong)IBOutlet UILabel*salePrice;
@property(nonatomic,strong)IBOutlet UILabel*shop;
@property(nonatomic,strong)IBOutlet UILabel*status;
@property(nonatomic,strong)IBOutlet UILabel*submitted;
@property(nonatomic,strong)IBOutlet UILabel*supporting;
@property(nonatomic,strong)IBOutlet UILabel*toilet;
@property(nonatomic,strong)IBOutlet UILabel*transaction;
@property(nonatomic,strong)IBOutlet UILabel*ttarea;
@property(nonatomic,strong)IBOutlet UILabel*ttfloor;
@property(nonatomic,strong)IBOutlet UILabel*uptown;
-(void)setTheData:(NSMutableDictionary*)resource;
@end
