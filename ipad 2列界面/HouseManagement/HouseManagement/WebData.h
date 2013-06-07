//
//  WebData.h
//  HouseManagement
//
//  Created by  on 12-5-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "House.h"
#import "Area.h"
@interface WebData : NSObject
{
    NSMutableArray*houses;
}
@property(nonatomic,strong)NSMutableArray*houses;
-(BOOL)accessIntoDataBase:(NSString*)name password:(NSString*)password;
-(NSMutableArray*)returnAllData;
-(NSMutableDictionary*)setTestData;
-(NSMutableArray*)TestData;
//house
-(void)saveHouse:(NSMutableDictionary*)dic deleteHouse:(House*)house;;
-(id)excuteHouse:(NSString*)key;
//Area
-(BOOL)saveArea:(NSMutableDictionary*)dic;
-(NSMutableArray*)detailRegion:(NSString*)key;
-(NSMutableArray*)detailArea;
-(NSMutableArray*)detailUptown:(NSString*)key;
@end
