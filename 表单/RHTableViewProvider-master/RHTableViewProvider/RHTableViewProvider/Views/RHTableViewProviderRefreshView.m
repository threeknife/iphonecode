//
//  RHTableViewProviderRefreshView.m
//  RHTableViewProvider
//
//  Created by Rob Hayward on 11/01/2013.
//  Copyright (c) 2013 Rob Hayward. All rights reserved.
//

#import "RHTableViewProviderRefreshView.h"

@implementation RHTableViewProviderRefreshView

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    
    [self setBackgroundColor:[UIColor blackColor]];
    
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 44.0f, 44.0f)];
    [activity startAnimating];
    [activity setCenter:CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2)];
    [self addSubview:activity];
  }
  return self;
}

@end
