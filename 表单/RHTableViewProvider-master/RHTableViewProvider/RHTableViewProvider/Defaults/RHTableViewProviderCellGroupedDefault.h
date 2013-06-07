//
//  RHTableViewProviderCellGroupedDefault.h
//  RHTableViewProvider
//
//  Created by Rob Hayward on 16/01/2013.
//  Copyright (c) 2013 Rob Hayward. All rights reserved.
//

#import "RHTableViewProviderCell.h"

@interface RHTableViewProviderCellGroupedDefault : RHTableViewProviderCell

@property (strong, nonatomic) UILabel *label;

#pragma mark - Drawing for custom grouped cells

// All cells draw this generic/shared assets first
- (void)drawGenericInRect:(CGRect)rect;

// Drawing of standard cells in the middle
- (void)drawAsStandardCellInRect:(CGRect)rect;

// Drawing of the first cell only
- (void)drawAsFirstCellInRect:(CGRect)rect;
- (void)drawFirstCellBorderInRect:(CGRect)rect;

// Drawing of the last cell only
- (void)drawAsLastCellInRect:(CGRect)rect;
- (void)drawLastCellBorderInRect:(CGRect)rect;

// Drawn by all cells except the last cell
- (void)drawBottomBorderInRect:(CGRect)rect;

@end
