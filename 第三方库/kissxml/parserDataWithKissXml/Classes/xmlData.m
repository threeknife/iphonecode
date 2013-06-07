//
//  xmlData.m
//  FuJingChat
//
//  Created by angel li on 10-12-13.
//  Copyright 2010 Lixf. All rights reserved.
//

#import "xmlData.h"

@implementation xmlData
@synthesize user, title, content;

- (void)dealloc {
	[user release];
	[title release];
    [content release];
    [super dealloc];
}
@end
