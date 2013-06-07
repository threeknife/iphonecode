//
//  UIView+RHTVP.m
//  RHTableViewProvider
//
//  Created by Rob Hayward on 11/02/2013.
//  Copyright (c) 2013 Rob Hayward. All rights reserved.
//

#import "UIView+RHTVP.h"

@implementation UIView (RHTVP)

- (void)disableUserInteractionOnSubviews
{
  for (UIView *view in [self subviews])
  {
    [view setUserInteractionEnabled:NO];
  }
}

@end
