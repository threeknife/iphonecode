//
//  RHTableViewProviderSectionViewGroupedDefault.h
//  RHTableViewProvider
//
//  Created by Rob Hayward on 07/02/2013.
//  Copyright (c) 2013 Rob Hayward. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RHTableViewProviderSection.h"

@interface RHTableViewProviderSectionViewGroupedDefault : UIView <RHTableViewProviderSection>

@property (strong, nonatomic) id object;
@property (assign, nonatomic) NSInteger index;

@property (strong, nonatomic) UILabel *label;

@end
