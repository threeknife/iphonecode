//
//  WebData.m
//  HouseManagement
//
//  Created by  on 12-5-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WebData.h"
#import "AppDelegate.h"
@implementation WebData
@synthesize houses;
-(BOOL)accessIntoDataBase:(NSString*)name password:(NSString*)password
{
    return YES;
}
#pragma mark saveData 
//House
-(void)saveHouse:(NSMutableDictionary*)dic deleteHouse:(House*)house
{
    if (house.houseNumber!=nil) {
    AppDelegate*appDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.managedObjectContext deleteObject:house];
    [appDelegate saveContext];
    }
    [self setIntoHouse:dic];
}
//Area
-(BOOL)saveArea:(NSMutableDictionary*)dic
{
    AppDelegate*appDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext*manageContext=appDelegate.managedObjectContext;
    NSFetchRequest*request=[[NSFetchRequest alloc ] init];
    NSEntityDescription*entity=[NSEntityDescription entityForName:@"Area" inManagedObjectContext:manageContext];
    [request setEntity:entity];
    NSSortDescriptor*sortDescriptor=[[NSSortDescriptor alloc] initWithKey:@"uptown" ascending:NO];
    NSArray*sortArray=[[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortArray];
    NSError*error;
    NSMutableArray*Dataresult=[[manageContext executeFetchRequest:request error:&error] mutableCopy];
    for (Area*oldArea in Dataresult) {
        if ([oldArea.uptown isEqualToString:[dic objectForKey:@"uptown"]]) {
            return NO;
        }
    }
    Area*newArea=(Area*)[NSEntityDescription insertNewObjectForEntityForName:@"Area" inManagedObjectContext:appDelegate.managedObjectContext];
    newArea.area=[dic objectForKey:@"area"];
    newArea.region=[dic objectForKey:@"region"];
    newArea.uptown=[dic objectForKey:@"uptown"];
    newArea.address=[dic objectForKey:@"address"];
    [appDelegate saveContext];
}
#pragma mark returnData
-(NSMutableArray*)returnAllData
{
    AppDelegate*appDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext*manageContext=appDelegate.managedObjectContext;
    NSFetchRequest*request=[[NSFetchRequest alloc ] init];
    NSEntityDescription*entity=[NSEntityDescription entityForName:@"House" inManagedObjectContext:manageContext];
    [request setEntity:entity];
    NSSortDescriptor*sortDescriptor=[[NSSortDescriptor alloc] initWithKey:@"houseNumber" ascending:NO];
    NSArray*sortArray=[[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortArray];
    NSError*error;
    NSMutableArray*Dataresult=[[manageContext executeFetchRequest:request error:&error] mutableCopy];
    NSMutableArray*AllHosue=[[NSMutableArray alloc] init];
    for (id newHouse in Dataresult) {
        NSMutableDictionary*dic=[[NSMutableDictionary alloc] init];
        dic=[self setIntoDic:newHouse];
        [AllHosue addObject:dic];
    }
    return AllHosue;
}
-(id)excuteHouse:(NSString*)key
{
    AppDelegate*appDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext*manageContext=appDelegate.managedObjectContext;
    NSFetchRequest*request=[[NSFetchRequest alloc ] init];
    NSEntityDescription*entity=[NSEntityDescription entityForName:@"House" inManagedObjectContext:manageContext];
    [request setEntity:entity];
    NSSortDescriptor*sortDescriptor=[[NSSortDescriptor alloc] initWithKey:@"houseNumber" ascending:NO];
    NSArray*sortArray=[[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortArray];
    NSError*error;
    NSMutableArray*Dataresult=[[manageContext executeFetchRequest:request error:&error] mutableCopy];
    for (House*newHouse in Dataresult) {
        if ([newHouse.houseNumber isEqualToString:key]) {
            return newHouse;
        }
    }
    return nil;
}
-(NSMutableDictionary*)setIntoDic:(House*)house
{
    NSMutableDictionary*dic=[[NSMutableDictionary alloc] init];
    [dic setValue:house.area forKey:@"area"];
    [dic setValue:house.balcony forKey:@"balcony"];
    [dic setValue:house.commissionNumber forKey:@"commissionNumber"];
    [dic setValue:house.decoration forKey:@"decoration"];
    [dic setValue:house.delegate forKey:@"delegate"];
    [dic setValue:house.furniutre forKey:@"furniture"];
    [dic setValue:house.floor forKey:@"floor"];
    [dic setValue:house.hall forKey:@"hall"];
    [dic setValue:house.houseApplication forKey:@"houseApplication"];
    [dic setValue:house.houseNumber forKey:@"houseNumber"];
    [dic setValue:house.onCommission forKey:@"onCommission"];
    [dic setValue:house.person forKey:@"person"];
    [dic setValue:house.region forKey:@"region"];
    [dic setValue:house.remark forKey:@"remark"];
    [dic setValue:house.rentPrice forKey:@"rentPrice"];
    [dic setValue:house.room forKey:@"room"];
    [dic setValue:house.salePrice forKey:@"salePrice"];
    [dic setValue:house.shop forKey:@"shop"];
    [dic setValue:house.status forKey:@"status"];
    [dic setValue:house.submitted forKey:@"submitted"];
    [dic setValue:house.supporting forKey:@"supporting"];
    [dic setValue:house.toilet forKey:@"toilet"];
    [dic setValue:house.transaction forKey:@"transaction"];
    [dic setValue:house.ttarea forKey:@"ttarea"];
    [dic setValue:house.address forKey:@"address"];
    [dic setValue:house.ttfloor forKey:@"ttfloor"];
    [dic setValue:house.uptown forKey:@"uptown"];
    [dic setValue:[UIImage imageWithData:house.housePicture1] forKey:@"housePicture1"];
    [dic setValue:[UIImage imageWithData:house.housePicture2] forKey:@"housePicture2"];
    [dic setValue:[UIImage imageWithData:house.housePicture3] forKey:@"housePicture3"];
    [dic setValue:[UIImage imageWithData:house.housePicture4] forKey:@"housePicture4"];
    [dic setValue:[UIImage imageWithData:house.housePicture5] forKey:@"housePicture5"];
    return dic;
}
-(void)setIntoHouse:(NSMutableDictionary*)dic
{
    AppDelegate*appDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext*manageContext=appDelegate.managedObjectContext;
    NSFetchRequest*request=[[NSFetchRequest alloc ] init];
    NSEntityDescription*entity=[NSEntityDescription entityForName:@"Area" inManagedObjectContext:manageContext];
    [request setEntity:entity];
    NSSortDescriptor*sortDescriptor=[[NSSortDescriptor alloc] initWithKey:@"area" ascending:NO];
    NSArray*sortArray=[[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortArray];
    NSError*error;
    NSMutableArray*Dataresult=[[manageContext executeFetchRequest:request error:&error] mutableCopy];
    House*newHouse=(House*)[NSEntityDescription insertNewObjectForEntityForName:@"House" inManagedObjectContext:appDelegate.managedObjectContext];
    newHouse.area=[dic objectForKey:@"area"];
    newHouse.balcony=[dic objectForKey:@"balcony"];
    newHouse.commissionNumber=[dic objectForKey:@"commissionNumber"];
    newHouse.decoration=[dic objectForKey:@"decoration"];
    newHouse.delegate=[dic objectForKey:@"delegate"];
    newHouse.furniutre=[dic objectForKey:@"furniture"];
    newHouse.floor=[dic objectForKey:@"floor"];
    newHouse.hall=[dic objectForKey:@"hall"];
    newHouse.houseApplication=[dic objectForKey:@"houseApplication"];
    newHouse.houseNumber=[dic objectForKey:@"houseNumber"];
    newHouse.onCommission=[dic objectForKey:@"onCommission"];
    newHouse.person=[dic objectForKey:@"person"];
    newHouse.region=[dic objectForKey:@"region"];
    newHouse.remark=[dic objectForKey:@"remark"];
    newHouse.rentPrice=[dic objectForKey:@"rentPrice"];
    newHouse.room=[dic objectForKey:@"room"];
    newHouse.salePrice=[dic objectForKey:@"salePrice"];
    newHouse.shop=[dic objectForKey:@"shop"];
    newHouse.status=[dic objectForKey:@"status"];
    newHouse.submitted=[dic objectForKey:@"submitted"];
    newHouse.supporting=[dic objectForKey:@"supporting"];
    newHouse.toilet=[dic objectForKey:@"toilet"];
    newHouse.transaction=[dic objectForKey:@"transaction"];
    newHouse.ttarea=[dic objectForKey:@"ttarea"];
    newHouse.ttfloor=[dic objectForKey:@"ttfloor"];
    newHouse.uptown =[dic objectForKey:@"uptown"];
    for (Area*area in Dataresult) {
        if ([area.uptown isEqualToString:newHouse.uptown]) {
            newHouse.address=area.address;
        }
    }    
    newHouse.housePicture1=UIImagePNGRepresentation([dic objectForKey:@"housePicture1"]);
    newHouse.housePicture2=UIImagePNGRepresentation([dic objectForKey:@"housePicture2"]);
    newHouse.housePicture3=UIImagePNGRepresentation([dic objectForKey:@"housePicture3"]);
    newHouse.housePicture4=UIImagePNGRepresentation([dic objectForKey:@"housePicture4"]);
    newHouse.housePicture5=UIImagePNGRepresentation([dic objectForKey:@"housePicture5"]);
   [appDelegate saveContext];
}

#pragma mark AreaData
-(NSMutableArray*)detailArea
{
    AppDelegate*appDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext*manageContext=appDelegate.managedObjectContext;
    NSFetchRequest*request=[[NSFetchRequest alloc ] init];
    NSEntityDescription*entity=[NSEntityDescription entityForName:@"Area" inManagedObjectContext:manageContext];
    [request setEntity:entity];
    NSSortDescriptor*sortDescriptor=[[NSSortDescriptor alloc] initWithKey:@"area" ascending:NO];
    NSArray*sortArray=[[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortArray];
    NSError*error;
    NSMutableArray*Dataresult=[[manageContext executeFetchRequest:request error:&error] mutableCopy];
    NSMutableArray*result=[[NSMutableArray alloc] init];
    for (Area*area in Dataresult) {
        BOOL newOne=YES;
        if ([result count]>0) {
        for (int i=0; i<[result count]; i++) 
        {
            NSString*oneArea=[result objectAtIndex:i];
            if([area.area isEqualToString:oneArea])
            {
                newOne=NO;
            }
        }
        }
        if (newOne==YES) {
            NSString*newArea=area.area;
            [result addObject:newArea];
        }
    }    
    return result;
}
-(NSMutableArray*)detailRegion:(NSString*)key
{
    AppDelegate*appDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext*manageContext=appDelegate.managedObjectContext;
    NSFetchRequest*request=[[NSFetchRequest alloc ] init];
    NSEntityDescription*entity=[NSEntityDescription entityForName:@"Area" inManagedObjectContext:manageContext];
    [request setEntity:entity];
    NSSortDescriptor*sortDescriptor=[[NSSortDescriptor alloc] initWithKey:@"area" ascending:NO];
    NSArray*sortArray=[[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortArray];
    NSError*error;
    NSMutableArray*Dataresult=[[manageContext executeFetchRequest:request error:&error] mutableCopy];
    NSMutableArray*result=[[NSMutableArray alloc] init];
    for (Area*area in Dataresult) {
        if([area.area isEqualToString:key])
        {
            BOOL newOne=YES;
            if ([result count]>0) {
                for (int i=0; i<[result count]; i++) 
                {
                    NSString*oneArea=[result objectAtIndex:i];
                    if([area.region isEqualToString:oneArea])
                    {
                        newOne=NO;
                    }
                }
            }
            if (newOne==YES) {
                NSString*newArea=area.region;
                [result addObject:newArea];
            }
 
        }
    }
    return result;
}
-(NSMutableArray*)detailUptown:(NSString*)key
{
    AppDelegate*appDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext*manageContext=appDelegate.managedObjectContext;
    NSFetchRequest*request=[[NSFetchRequest alloc ] init];
    NSEntityDescription*entity=[NSEntityDescription entityForName:@"Area" inManagedObjectContext:manageContext];
    [request setEntity:entity];
    NSSortDescriptor*sortDescriptor=[[NSSortDescriptor alloc] initWithKey:@"area" ascending:NO];
    NSArray*sortArray=[[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortArray];
    NSError*error;
    NSMutableArray*Dataresult=[[manageContext executeFetchRequest:request error:&error] mutableCopy];
    NSMutableArray*result=[[NSMutableArray alloc] init];
    for (Area*area in Dataresult) {
        if([area.region isEqualToString:key])
        {
            BOOL newOne=YES;
            if ([result count]>0) {
                for (int i=0; i<[result count]; i++) 
                {
                    NSString*oneArea=[result objectAtIndex:i];
                    if([area.uptown isEqualToString:oneArea])
                    {
                        newOne=NO;
                    }
                }
            }
            if (newOne==YES) {
                NSString*newArea=area.uptown;
                [result addObject:newArea];
            }
            
        }
    }
    return result;

}
//test insertData
-(void)insertData
{
    AppDelegate*appDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    //data Testing
    Area*addArea=(Area*)[NSEntityDescription insertNewObjectForEntityForName:@"Area" inManagedObjectContext:appDelegate.managedObjectContext];
    addArea.area=@"嘉定";
    addArea.region=@"北门";
    addArea.uptown=@"么么小区";
    addArea.address=@"福海路123号";
    [appDelegate saveContext];

}
@end
