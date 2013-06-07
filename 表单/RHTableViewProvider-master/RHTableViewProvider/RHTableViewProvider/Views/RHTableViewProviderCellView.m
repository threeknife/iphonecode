//
//  RHTableViewProviderCellView.m
//  RHTableViewProvider
//
//  Created by Rob Hayward on 11/01/2013.
//  Copyright (c) 2013 Rob Hayward. All rights reserved.
//

#import "RHTableViewProviderCellView.h"
#import "RHTableViewProviderCell.h"

@implementation RHTableViewProviderCellView

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [self setContentMode:UIViewContentModeRedraw];
    [self setClearsContextBeforeDrawing:YES];
    [self setBackgroundColor:[UIColor clearColor]];
  }
  return self;
}

- (void)drawRect:(CGRect)rect
{
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextClearRect(context, self.frame);
  RHTableViewProviderCell *cell = (RHTableViewProviderCell *)[self superview];
  [cell drawContentView:rect];
}

@end
