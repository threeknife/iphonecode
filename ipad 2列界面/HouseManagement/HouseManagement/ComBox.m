//
//  ComBox.m
//  HouseManagement
//
//  Created by  on 12-5-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ComBox.h"

@implementation ComBox
@synthesize delegate;
@synthesize dataArray;
@synthesize listView;
@synthesize backView;
@synthesize selected;
@synthesize centerButton;
- (id)initWithX:(int)x Y:(int)y width:(int)width rootView:(UIView*)view data:(NSMutableArray*)array
{   
    if (width<=90) {
        width=90;
    }
    if (self=[super initWithFrame:CGRectMake(x, y, width,30)]) {
        dataArray=array;
        if (dataArray==nil) {
            dataArray=[[NSMutableArray alloc] init];
        }
        superView=view;
        centerButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [centerButton setFrame:CGRectMake(0, 0, width, 30)];
        [centerButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [centerButton setEnabled:NO];
        if ([dataArray count]>0) {
            [centerButton setTitle:[dataArray objectAtIndex:0] forState:UIControlStateNormal];
            selected=centerButton.titleLabel.text;
        }
        else {
            [centerButton setTitle:@"无"  forState:UIControlStateNormal];
            selected=centerButton.titleLabel.text;
        }
        rightButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        [rightButton setFrame:CGRectMake(width-20, 0, 20, 30)];
        [rightButton addTarget:self action:@selector(showList) forControlEvents:UIControlEventTouchDown];
        [rightButton setEnabled:YES];
        [self addSubview:centerButton];
        [self addSubview:rightButton];
    }
    return self;
}
-(void)showList
{
    [delegate closeOtherComBox:self];
    int buttonCount=[dataArray count];
    if (buttonCount>0) {
        if (buttonCount>=5) {
            buttonCount=5;
        }
        listView=[[UIScrollView alloc] initWithFrame:CGRectMake(1, 30, self.frame.size.width, buttonCount*30)];
        [listView setContentSize:CGSizeMake(self.frame.size.width, [dataArray count]*30)];
        UIButton*button;
        for (int i=0; i<[dataArray count]; i++) {
            button=[[UIButton alloc] initWithFrame:CGRectMake(0, 30*i+1, self.frame.size.width, 30)];
            [button setBackgroundColor:[UIColor whiteColor]];
            [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [button setTitle:[NSString stringWithFormat:@"%@",[dataArray objectAtIndex:i]] forState:UIControlStateNormal];
            [button setTag:i];
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
            [listView addSubview:button];
        }
    backView=[[UIView alloc] initWithFrame:CGRectMake(self.frame.origin.x-1, self.frame.origin.y-1, self.frame.size.width+2, 30+listView.frame.size.height+2)];
    [backView setBackgroundColor:[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.3]];
    [backView addSubview:listView];
        UIButton*rightButton2=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        [rightButton2 setFrame:CGRectMake(self.frame.size.width-19,1, 20, 30)];
        [rightButton2 addTarget:self action:@selector(backList) forControlEvents:UIControlEventTouchDown];
        [rightButton2 setEnabled:YES];
        [backView addSubview:rightButton2];
    [superView addSubview:backView];
    }
}
-(void)backList
{
    [backView removeFromSuperview];
}
-(void)buttonClick:(id)sender
{
    UIButton*button=(UIButton*)sender;
    int index=[button tag];
    [centerButton setTitle:[NSString stringWithFormat:@"%@",[dataArray objectAtIndex:index]] forState:UIControlStateNormal];
    selected=centerButton.titleLabel.text;
    [delegate selfValueChanged:self];
    [backView removeFromSuperview];
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
