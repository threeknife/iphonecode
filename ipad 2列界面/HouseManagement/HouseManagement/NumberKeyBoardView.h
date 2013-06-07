//
//  NumberKeyBoardView.h
//  HouseManagement
//
//  Created by  on 12-5-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NumberKeyBoardDelegate <NSObject>
-(void)numberKeyBoardInput:(NSInteger)number;
-(void)numberkeyBoardBackspace;
-(void)numberKeyBoardFinish;
-(void)numberKeyBoardPoint;
@end
@interface NumberKeyBoardView : UIView
{
@private 
    id <NumberKeyBoardDelegate> delegate;
    
}
@property(nonatomic,strong)id <NumberKeyBoardDelegate>delegate;
-(void)numberKeyBoardView:(CGRect)frame;
@end
