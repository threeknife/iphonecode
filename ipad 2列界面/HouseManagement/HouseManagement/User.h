//
//  User.h
//  HouseManagement
//
//  Created by  on 12-5-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@interface User : NSManagedObject{
@private
}

@property(nonatomic,retain)NSString *name;
@property(nonatomic,retain)NSString *password;
@end
