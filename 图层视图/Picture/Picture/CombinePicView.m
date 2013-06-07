//
//  CombinePicView.m
//  Picture
//
//  Created by ruijuan kang on 12-2-6.
//  Copyright (c) 2012年 NetQin. All rights reserved.
//

#import "CombinePicView.h"
#import "PicetureView.h"

@implementation CombinePicView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.layer.masksToBounds = YES;
        self.userInteractionEnabled = YES;
        
        PicetureView *pic1 = [[PicetureView alloc] initWithFrame:CGRectMake(40, 10, 200, 100)];
        pic1.showImageView.image = [UIImage imageNamed:@"new.png"];
        [self addSubview:pic1];
        [pic1 release];
        
        PicetureView *pic2 = [[PicetureView alloc] initWithFrame:CGRectMake(40, 120, 200, 100)];
        pic2.showImageView.image = [UIImage imageNamed:@"JoyDefault.png"];
        [self addSubview:pic2];
        [pic2 release];
        
        PicetureView *pic3 = [[PicetureView alloc] initWithFrame:CGRectMake(40, 240, 200, 100)];
        pic3.showImageView.image = [UIImage imageNamed:@"ShareDefault.png"];
        [self addSubview:pic3];
        [pic3 release];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
