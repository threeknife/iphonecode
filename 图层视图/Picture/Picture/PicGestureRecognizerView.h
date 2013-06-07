//
//  PicGestureRecognizerView.h
//  Picture
//
//  Created by ruijuan kang on 12-2-3.
//  Copyright (c) 2012年 NetQin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PicGestureRecognizerView : UIView <UIGestureRecognizerDelegate>
{
    UIImageView *photoImage;
    CGFloat _lastScale;
    CGFloat _lastRotation;
    CGFloat _firstX;
    CGFloat _firstY;
}


@end
