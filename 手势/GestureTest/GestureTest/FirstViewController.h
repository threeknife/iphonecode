//
//  FirstViewController.h
//  GestureTest
//
//  Created by gamy on 11-12-30.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    LongPressGestureRecognizer = 0,
    PanGestureRecognizer,
    PinchGestureRecognizer,
    RotationGestureRecognizer,
    SwipeGestureRecognizer,
    TapGestureRecognizer,
    RecognizerTypeCount
}RecognizerType;

@interface FirstViewController : UIViewController <UIGestureRecognizerDelegate>{

}

@end
