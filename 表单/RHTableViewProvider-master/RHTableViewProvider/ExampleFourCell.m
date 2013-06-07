//
//  ExampleFourCell.m
//  RHTableViewProvider
//
//  Created by Rob Hayward on 08/02/2013.
//  Copyright (c) 2013 Rob Hayward. All rights reserved.
//

#import "ExampleFourCell.h"

@implementation ExampleFourCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    [self.label setBackgroundColor:[UIColor clearColor]];
    [self.label setTextColor:[UIColor blueColor]];
  }
  return self;
}

- (void)drawContentView:(CGRect)rect
{
  [super drawContentView:rect];
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSetFillColorWithColor(context, [[UIColor greenColor] CGColor]);
  CGContextFillRect(context, rect);
}



@end
