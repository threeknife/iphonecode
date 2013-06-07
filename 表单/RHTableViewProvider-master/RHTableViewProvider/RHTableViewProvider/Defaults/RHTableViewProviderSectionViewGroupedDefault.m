//
//  RHTableViewProviderSectionViewGroupedDefault.m
//  RHTableViewProvider
//
//  Created by Rob Hayward on 07/02/2013.
//  Copyright (c) 2013 Rob Hayward. All rights reserved.
//

#import "RHTableViewProviderSectionViewGroupedDefault.h"
#import <QuartzCore/QuartzCore.h>

@implementation RHTableViewProviderSectionViewGroupedDefault

+ (CGFloat)height
{
  return 30.0f;
}

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 5.0f, self.bounds.size.width - 40.0f, self.bounds.size.height - 10.0f)];
    [self.label setBackgroundColor:[UIColor clearColor]];
    [self.label setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [self.label setTextColor:[UIColor colorWithRed:71/255.0 green:83/255.0 blue:98/255.0 alpha:1.0]];
    [[self.label layer] setShadowRadius:0.5];
    [[self.label layer] setShadowOpacity:1];
    [[self.label layer] setShadowOffset:CGSizeMake(0.5, 0.5)];
    [[self.label layer] setShadowColor:[[UIColor whiteColor] CGColor]];
    [self addSubview:self.label];
  }
  return self;
}

- (void)willDisplay
{
  
}

- (void)didEndDisplay
{
  
}

- (void)populateWithObject:(id)theObject
{
  self.object = theObject;
  [self.label setText:self.object];
}

@end