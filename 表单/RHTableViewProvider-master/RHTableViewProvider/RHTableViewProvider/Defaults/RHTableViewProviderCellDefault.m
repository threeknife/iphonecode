//
//  RHTableViewProviderCellDefault.m
//  RHTableViewProvider
//
//  Created by Rob Hayward on 11/01/2013.
//  Copyright (c) 2013 Rob Hayward. All rights reserved.
//

#import "RHTableViewProviderCellDefault.h"
#import <QuartzCore/QuartzCore.h>

@implementation RHTableViewProviderCellDefault

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 10.0f, self.bounds.size.width - 20.0f, self.bounds.size.height - 20.0f)];
    [self.label setBackgroundColor:[UIColor whiteColor]];
    [self.label setFont:[UIFont boldSystemFontOfSize:16.0f]];
    [self.label setTextColor:[UIColor blackColor]];
    [self.customView addSubview:self.label];
  }
  return self;
}

- (void)populateWithObject:(id)object
{
  [super populateWithObject:object];
  [self.label setText:object];
}

- (void)drawContentView:(CGRect)rect
{
  [super drawContentView:rect];
}

@end
