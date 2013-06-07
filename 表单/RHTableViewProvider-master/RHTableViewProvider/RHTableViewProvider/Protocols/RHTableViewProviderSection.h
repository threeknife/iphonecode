//
//  RHTableViewProviderSection.h
//  RHTableViewProvider
//
//  Created by Rob Hayward on 14/01/2013.
//  Copyright (c) 2013 Rob Hayward. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RHTableViewProviderSection <NSObject>

@property (strong, nonatomic) id object;
@property (assign, nonatomic) NSInteger index;

+ (CGFloat)height;
- (void)willDisplay;
- (void)didEndDisplay;
- (void)populateWithObject:(id)object;

@end
