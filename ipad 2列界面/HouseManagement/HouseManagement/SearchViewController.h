//
//  SearchViewController.h
//  HouseManagement
//
//  Created by  on 12-5-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComBox.h"
#import "WebData.h"
#import "NumberKeyBoardView.h"
#import "MainViewController.h"
@interface SearchViewController : UIViewController<NumberKeyBoardDelegate,ComBoxDelegate>
{
    MainViewController*mainView;
    ComBox*status;
    ComBox*area;
    ComBox*region;
    UITextField*priceLow;
    UITextField*priceHigh;
    UITextField*floorLow;
    UITextField*floorHigh;
    UITextField*ttareaLow;
    UITextField*ttareaHigh;
    NSMutableArray*houseList;
    WebData*dataResource;
    NSMutableArray*textFieldArray;
}
@property(nonatomic,strong)MainViewController*mainView;
@property(nonatomic,strong)NSMutableArray*textFieldArray;
@property(nonatomic,strong)WebData*dataResource;
@property(nonatomic,strong)IBOutlet UITextField*priceLow;
@property(nonatomic,strong) IBOutlet UITextField*priceHigh;
@property(nonatomic,strong)IBOutlet UITextField*floorLow;
@property(nonatomic,strong)IBOutlet UITextField*floorHigh;
@property(nonatomic,strong)IBOutlet UITextField*ttareaLow;
@property(nonatomic,strong)IBOutlet UITextField*ttareaHigh;
@property(nonatomic,strong)NSMutableArray*houseList;
@property(nonatomic,strong)ComBox*status;
@property(nonatomic,strong)ComBox*area;
@property(nonatomic,strong)ComBox*region;
-(void)selfReset;
@end
