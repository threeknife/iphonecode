//
//  xmlData.h
//  FuJingChat
//
//  Created by angel li on 10-12-13.
//  Copyright 2010 Lixf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface xmlData : NSObject {
	NSString *user;
	NSString *title;
	NSString *content;
}
@property (nonatomic, retain)  NSString *user;
@property (nonatomic, retain)  NSString *title;
@property (nonatomic, retain)  NSString *content;
@end
