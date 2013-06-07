//
//  NSDictionary+RHTVP.m
//  RHTableViewProvider
//
//  Created by Rob Hayward on 14/01/2013.
//  Copyright (c) 2013 Rob Hayward. All rights reserved.
//

#import "NSDictionary+RHTVP.h"

@implementation NSDictionary (RHTVP)

- (id)objectForKeyNotNull:(id)key
{
  id object = [self objectForKey:key];
  if (object == [NSNull null])
    return nil;
  
  return object;
}

@end
