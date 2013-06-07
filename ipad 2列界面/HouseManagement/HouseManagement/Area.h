//
//  Area.h
//  HouseManagement
//
//  Created by  on 12-5-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Area : NSManagedObject
{
@private
}
@property(nonatomic,strong)NSString*uptown;
@property(nonatomic,strong)NSString*region;
@property(nonatomic,strong)NSString*area;
@property(nonatomic,strong)NSString*address;
@end
