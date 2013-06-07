//
//  SearchViewController.m
//  HouseManagement
//
//  Created by  on 12-5-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SearchViewController.h"
@interface SearchViewController ()

@end

@implementation SearchViewController
@synthesize dataResource;
@synthesize houseList;
@synthesize area;
@synthesize status;
@synthesize ttareaHigh;
@synthesize ttareaLow;
@synthesize region;
@synthesize priceLow;
@synthesize priceHigh;
@synthesize floorLow;
@synthesize floorHigh;
@synthesize textFieldArray;
@synthesize mainView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)selfReset
{
    [status.centerButton setTitle:@"出售" forState:UIControlStateNormal];
    status.selected=@"出售";
    [area.centerButton setTitle:@"所有" forState:UIControlStateNormal];
    area.selected=@"所有";
    [region.centerButton setTitle:@"所有" forState:UIControlStateNormal];
    region.selected=@"所有";
    priceLow.text=@"";
    priceHigh.text=@"";
    floorLow.text=@"";
    floorHigh.text=@"";
    ttareaLow.text=@"";
    ttareaHigh.text=@"";
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //UIset
    if (dataResource==nil) {
        dataResource=[[WebData alloc] init];
    }
    if (status==nil) {
        NSMutableArray*array=[[NSMutableArray alloc] initWithObjects:@"出售",@"出租", nil];
        status=[[ComBox alloc] initWithX:120 Y:14 width:130 rootView:self.view data:array];
        [self.view addSubview:status];
            status.delegate=self;
    }
    if (area==nil) {
        NSMutableArray*array=[[NSMutableArray alloc] init];
        array=[dataResource detailArea];
        [array insertObject:@"所有" atIndex:0];
        area=[[ComBox alloc] initWithX:120 Y:61 width:130 rootView:self.view data:array];
        area.delegate=self;
        [self.view addSubview:area];
    }
    if (region==nil) {
        NSMutableArray*array=[[NSMutableArray alloc] init];
        [array insertObject:@"所有" atIndex:0];
        region=[[ComBox alloc] initWithX:120 Y:112 width:130 rootView:self.view data:array];
        region.delegate=self;
        [self.view addSubview:region];
    }
    NumberKeyBoardView*numberKeyboardView=[[NumberKeyBoardView alloc] initWithFrame:CGRectMake(0,0,0,0)];
    numberKeyboardView.delegate=self;
    [priceLow setInputView:numberKeyboardView];
    [priceHigh setInputView:numberKeyboardView];
    [floorLow setInputView:numberKeyboardView];
    [floorHigh setInputView:numberKeyboardView];
    [ttareaLow setInputView:numberKeyboardView];
    [ttareaHigh setInputView:numberKeyboardView];
    textFieldArray=[[NSMutableArray alloc] initWithObjects:priceLow,priceHigh,floorLow,floorHigh,ttareaLow,ttareaHigh, nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selfDismiss:) name:@"SearchViewDismiss" object:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft)||(interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}
#pragma mark dismiss
-(void)selfDismiss:(id)sender
{
    [self.view removeFromSuperview];
}
-(IBAction)searchHouse:(id)sender
{
    [status backList];
    [region  backList];
    [area backList];
    NSMutableArray*array=[[NSMutableArray alloc] init];
    array=[dataResource returnAllData];
    array=[self searchDetail:@"transaction" array:array];
    if (![area.selected isEqualToString:@"所有"]) {
        array=[self searchDetail:@"area" array:array];
    }
    if (![region.selected isEqualToString:@"所有"]) {
        array=[self searchDetail:@"region" array:array];
    }
    if ([status.selected isEqualToString:@"出售"]) {
        array=[self searchRange:@"salePrice" array:array high: priceHigh.text low:priceLow.text];
    }
    else {
        array=[self searchRange:@"rentPrice" array:array high:priceHigh.text low:priceLow.text];
    }
    array=[self searchRange:@"floor" array:array high:floorHigh.text low:floorLow.text];
    array=[self searchRange:@"ttarea" array:array high:ttareaHigh.text low:ttareaLow.text];
    [mainView showHouseManageView:array];
    [self.view removeFromSuperview];
}
-(NSMutableArray*)searchDetail:(NSString*)key array:(NSMutableArray*)data
{
    NSMutableArray*result=[[NSMutableArray alloc] init];
    for (id newHouse in data) {
        if([key isEqualToString:@"transaction"]){
        if ([[newHouse objectForKey:key] isEqualToString:status.selected]) {
            [result addObject:newHouse];
        }
        }else if ([key isEqualToString:@"area"]) {
            if ([[newHouse objectForKey:key] isEqualToString:area.selected]) {
                [result addObject:newHouse];
        }
        }else if ([key isEqualToString:@"region"]) {
            if ([[newHouse objectForKey:key] isEqualToString:region.selected]) {
                [result addObject:newHouse];
        }
        }
    }
    return result;
}
-(NSMutableArray*)searchRange:(NSString*)key array:(NSMutableArray*)data high:(NSString*)high low:(NSString*)low
{
    NSMutableArray*result=[[NSMutableArray alloc] init];
    for (id newHouse in data) {
        float number=[[newHouse objectForKey:key] floatValue];
        if ([high isEqualToString:@""]) {
            if ([low isEqualToString:@""]) {
                [result addObject:newHouse];
            }
            else {
                if (number>[low floatValue]) {
                    [result addObject:newHouse];
                }
            }
            
        }
        else {
            if (number<[high floatValue]) {
                if ([low isEqualToString:@""]) {
                    [result addObject:newHouse];
                }
                else {
                    if (number>[low floatValue]) {
                        [result addObject:newHouse];
                    }
                }
            }
        }
    }
    return result;
}
#pragma combox delegate
-(void)selfValueChanged:(id)sender
{
    if (sender==area) {
        NSMutableArray*array=[[NSMutableArray alloc] init];
        array=[dataResource detailRegion:area.selected];
        [array insertObject:@"所有" atIndex:0];
        region.dataArray=array;
        [region.centerButton setTitle:@"所有" forState:UIControlStateNormal];
        region.selected=@"所有";
    }
}
-(void)closeOtherComBox:(id)sender
{
    NSMutableArray*array=[[NSMutableArray alloc] initWithObjects:area,region,status, nil];
    for (id button in array) {
        if (button!=sender) {
            [button backList];
        }
    }
}
#pragma mark keyboardDelegate
-(void)numberKeyBoardInput:(NSInteger)number
{
    for (UITextField*textField in textFieldArray) {
        if ([textField isEditing]) {
            NSMutableString*mutableString=[[NSMutableString alloc] initWithFormat:@"%@%d",textField.text,number];
            textField.text=mutableString;
        }
    }
}
-(void)numberkeyBoardBackspace
{
    for (UITextField*textField in textFieldArray) {
        if ([textField isEditing]) {
            NSMutableString*mutableString=[[NSMutableString alloc] initWithFormat:@"%@",textField.text];
            if([mutableString length]>=1)
            {
                NSRange tmpRange;
                tmpRange.location=[mutableString length]-1;
                tmpRange.length=1;
                [mutableString deleteCharactersInRange:tmpRange];
            }
            textField.text=mutableString;
        }
    }
}
-(void)numberKeyBoardFinish
{
    for (UITextField*textField in textFieldArray) {
        if ([textField isEditing]) {
            [textField resignFirstResponder];
        }
    }
}
-(void)numberKeyBoardPoint
{
    for (UITextField*textField in textFieldArray) {
        if ([textField isEditing]) {
            NSMutableString*mutableString=[[NSMutableString alloc] initWithFormat:@"%@.",textField.text];
            textField.text=mutableString;
        }
    }
}

@end
