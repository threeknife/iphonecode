//
//  ExampleTwoCell.m
//  RHTableViewProvider
//
//  Created by Rob Hayward on 07/02/2013.
//  Copyright (c) 2013 Rob Hayward. All rights reserved.
//

#import "ExampleTwoCell.h"

@implementation ExampleTwoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 10.0f, self.bounds.size.width - 20.0f, self.bounds.size.height - 20.0f)];
    [self.label setBackgroundColor:[UIColor clearColor]];
    [self.label setFont:[UIFont boldSystemFontOfSize:16.0f]];
    [self.customView addSubview:self.label];
    
    self.borderColor = [UIColor whiteColor];
    self.backgroundColorDefault = [UIColor darkGrayColor];
    self.backgroundColorDefaultHighlighted = [UIColor lightGrayColor];
    self.textColor = [UIColor orangeColor];
    self.textColorHighlighted = [UIColor yellowColor];
    self.borderWidth = 2.0f;
  }
  return self;
}

@end
