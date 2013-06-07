//
//  House.h
//  HouseManagement
//
//  Created by  on 12-5-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>
@interface House : NSManagedObject{
@private
}
@property(nonatomic,retain)NSString*area;
@property(nonatomic,retain)NSString*balcony;
@property(nonatomic,retain)NSString*commissionNumber;
@property(nonatomic,retain)NSString*decoration;
@property(nonatomic,retain)NSString*delegate;
@property(nonatomic,retain)NSString*furniutre;
@property(nonatomic,retain)NSString*floor;
@property(nonatomic,retain)NSString*hall;
@property(nonatomic,retain)NSString*houseApplication;
@property(nonatomic,retain)NSString*houseNumber;
@property(nonatomic,retain)NSString*onCommission;
@property(nonatomic,retain)NSString*person;
@property(nonatomic,retain)NSString*region;
@property(nonatomic,retain)NSString*remark;
@property(nonatomic,retain)NSString*room;
@property(nonatomic,retain)NSString*shop;
@property(nonatomic,retain)NSString*status;
@property(nonatomic,retain)NSDate*submitted;
@property(nonatomic,retain)NSString*supporting;
@property(nonatomic,retain)NSString*toilet;
@property(nonatomic,retain)NSString*transaction;
@property(nonatomic,retain)NSString*ttfloor;
@property(nonatomic,retain)NSString*uptown;
@property(nonatomic,retain)NSString*address;
@property(nonatomic,retain)NSNumber*salePrice;
@property(nonatomic,retain)NSNumber*ttarea;
@property(nonatomic,retain)NSNumber*rentPrice;
@property(nonatomic,retain)NSData*housePicture1;
@property(nonatomic,retain)NSData*housePicture2;
@property(nonatomic,retain)NSData*housePicture3;
@property(nonatomic,retain)NSData*housePicture4;
@property(nonatomic,retain)NSData*housePicture5;
@end
