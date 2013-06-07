//
//  ComBox.h
//  HouseManagement
//
//  Created by  on 12-5-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ComBoxDelegate
-(void)selfValueChanged:(id)sender;
-(void)closeOtherComBox:(id)sender;
@end
@interface ComBox : UIView
{
    id <ComBoxDelegate> delegate;
    UIScrollView*listView;
    NSMutableArray*dataArray;
    UIView*superView;
    UIButton *centerButton;
    UIButton *rightButton;
    UIView*backView;
    NSString*selected;
    BOOL isOpen;
}
@property(nonatomic,strong)id <ComBoxDelegate>delegate;
@property(nonatomic,strong)NSString*selected;
@property(nonatomic,strong)UIView*backView;
@property(nonatomic,strong)UIScrollView*listView;
@property(nonatomic,strong)NSMutableArray*dataArray;
@property(nonatomic,strong)UIButton*centerButton;
- (id)initWithX:(int)x Y:(int)y width:(int)width rootView:(UIView*)view data:(NSMutableArray*)array;
-(void)backList;
@end
