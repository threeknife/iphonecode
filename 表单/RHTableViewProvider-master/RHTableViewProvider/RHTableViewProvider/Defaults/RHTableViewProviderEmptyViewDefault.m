//
//  RHTableViewProviderEmptyViewDefault.m
//  RHTableViewProvider
//
//  Created by Rob Hayward on 18/01/2013.
//  Copyright (c) 2013 Rob Hayward. All rights reserved.
//

#import "RHTableViewProviderEmptyViewDefault.h"

@implementation RHTableViewProviderEmptyViewDefault

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 10.0f, self.bounds.size.width - 20.0f, self.bounds.size.height - 20.0f)];
    [self.label setBackgroundColor:[UIColor clearColor]];
    [self.label setFont:[UIFont boldSystemFontOfSize:16.0f]];
    [self.label setTextColor:[UIColor lightGrayColor]];
    [self.label setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:self.label];
  }
  return self;
}


@end
