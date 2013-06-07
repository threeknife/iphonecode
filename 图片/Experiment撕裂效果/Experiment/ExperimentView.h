//
//  ExperimentView.h
//  Experiment
//
//  Created by Terry Lin on 12-5-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExperimentView : UIView
@property (nonatomic,strong) UIImageView *image;
@property (nonatomic) BOOL isSpliting;
@property (nonatomic,strong) UIImageView *left;
@property (nonatomic,strong) UIImageView *right;

@end
