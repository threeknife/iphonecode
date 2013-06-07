//
//  NumberKeyBoardView.m
//  HouseManagement
//
//  Created by  on 12-5-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NumberKeyBoardView.h"

@implementation NumberKeyBoardView
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    [self numberKeyBoardView:frame];
    return self;
}
-(void)numberKeyBoardView:(CGRect)frame
{
    self.frame=CGRectMake(frame.origin.x,frame.origin.y, 320, 278);
    for (int i=0; i<12; i++) {
        UIButton*button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button setFrame:CGRectMake(24.0f+i%3*(88+4)+700, i/3*(50+5), 88, 55)];
        if (i<=9) {
            [button setTag:i+1];
        }
        else if (i==10) {
            button.tag=0;
        }
        else if(i==11)
        {
            button.tag=i;
        }
        [button setTitle:[[NSNumber numberWithInt:button.tag] stringValue] forState:UIControlStateNormal];
        if (button.tag==10) {
            [button setTitle:@"撤销" forState:UIControlStateNormal];
        }
        if (button.tag==11) {
            [button setTitle:@"." forState:UIControlStateNormal];
        }
        [button addTarget:self action:@selector(numberButtonClicked:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:button];        
    }
    UIButton*button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(724, 225, 273, 45)];
    button.tag=12;
    [button setTitle:@"完成" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(numberButtonClicked:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:button];
}
-(void)numberButtonClicked:(id)sender
{
    UIButton*button=(UIButton*)sender;
    NSInteger number=button.tag;
    if (delegate==nil) {
        return;
    }
    if (number<=9&&number>=0) {
        [delegate numberKeyBoardInput:number];
        return;
    }
    if (number==10) {
        [delegate numberkeyBoardBackspace];
        return;
    }
    if (number==12) {
        [delegate numberKeyBoardFinish];
        return;
    }
    if (number==11) {
        [delegate numberKeyBoardPoint];
    }
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
