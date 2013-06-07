//
//  RHTableViewProviderCell.m
//  RHTableViewProvider
//
//  Created by Rob Hayward on 11/01/2013.
//  Copyright (c) 2013 Rob Hayward. All rights reserved.
//

#import "RHTableViewProviderCell.h"
#import "RHTableViewProviderCellView.h"
#import "RHTableViewProvider.h"
#import <QuartzCore/QuartzCore.h>

@implementation RHTableViewProviderCell

+ (CGFloat)height
{
  return 44.0f;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self)
  {
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self addObservers];
  }
  return self;
}

- (void)group
{
  [self setIsGrouped:YES];
  [self setBackgroundView:[UIView new]];
  [self setFrame:CGRectZero];
}

- (void)unGroup
{
  [self setIsGrouped:NO];
}

- (void)setFrame:(CGRect)frame
{
	[super setFrame:frame];
  CGRect customViewFrame = self.contentView.frame;
  if (self.isGrouped) { customViewFrame = [self groupedRect]; }
  self.customView.frame = customViewFrame;
	[self setNeedsDisplay];
}

#pragma mark - KVO

- (void)addObservers
{
  [self addObserver:self forKeyPath:@"parentTableView" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
  if ([keyPath isEqualToString:@"parentTableView"])
  {
    [self setFrame:CGRectMake(self.contentView.frame.origin.x, self.contentView.frame.origin.y, self.parentTableView.frame.size.width, self.contentView.frame.size.height)];
  }
}

#pragma mark - Getters

- (UIView *)customView
{
  if (_customView != nil) {
    return _customView;
  }
  self.customView = [[RHTableViewProviderCellView alloc] initWithFrame:CGRectZero];
  [self addSubview:_customView];
  return _customView;
}

- (CGRect)groupedRect
{
  CGRect rect = self.frame;
  CGFloat margin = ceilf(rect.size.width * GROUPED_CELL_WIDTH_MULTIPLIER);
  return CGRectMake(margin, rect.origin.x, rect.size.width - (margin * 2), rect.size.height);
}

- (void)setNeedsDisplay
{
	[super setNeedsDisplay];
	[self.customView setNeedsDisplay];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
  [super setSelected:selected animated:animated];
  [self setNeedsDisplay];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
  [super setHighlighted:highlighted animated:animated];
  [self setNeedsDisplay];
}

#pragma mark - Template methods

- (void)setupView
{
  
}

- (void)willBeginEditing
{
  
}

- (void)didEndEditing
{
  
}

- (void)willDisplay
{
  
}

- (void)didEndDisplay
{
  
}

- (void)populateWithObject:(id)anObject
{
  self.object = anObject;
}

- (void)drawContentView:(CGRect)rect
{
  if (self.isGrouped) { [self drawGroupedMaskInRect:rect]; }
}

- (void)drawGroupedMaskInRect:(CGRect)rect
{
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextClearRect(context, rect);
  
  switch (self.cellType) {
    case RHTableViewProviderCellTypeFirst:
    {
      UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(self.cornerRadius, self.cornerRadius)];
      CAShapeLayer *maskLayer = [CAShapeLayer layer];
      maskLayer.path = maskPath.CGPath;
      self.customView.layer.mask = maskLayer;
    }
      break;
    case RHTableViewProviderCellTypeLast:
    {
      UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(self.cornerRadius, self.cornerRadius)];
      CAShapeLayer *maskLayer = [CAShapeLayer layer];
      maskLayer.path = maskPath.CGPath;
      self.customView.layer.mask = maskLayer;
    }
      break;
    case RHTableViewProviderCellTypeSingle:
    {
      UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(self.cornerRadius, self.cornerRadius)];
      CAShapeLayer *maskLayer = [CAShapeLayer layer];
      maskLayer.path = maskPath.CGPath;
      self.customView.layer.mask = maskLayer;
    }
      break;
    case RHTableViewProviderCellTypeMiddle:
    {
      CGContextSetLineWidth(context, 1.0f);
      CGContextSetStrokeColorWithColor(context, [[UIColor whiteColor] CGColor]);
      CGContextMoveToPoint(context, 0, rect.size.height);
      CGContextAddLineToPoint(context, rect.size.width, rect.size.height - 1);
      CGContextStrokePath(context);
    }
      break;
  }
}

@end
