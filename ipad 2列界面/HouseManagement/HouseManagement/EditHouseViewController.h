//
//  EditHouseViewController.h
//  HouseManagement
//
//  Created by  on 12-5-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ComBox.h"
#import "NumberKeyBoardView.h"
#import "WebData.h"
@interface EditHouseViewController : UIViewController<NumberKeyBoardDelegate,ComBoxDelegate,UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPopoverControllerDelegate>
{
    UIPopoverController*currentPopView;
        IBOutlet UITextField*balcony;
        IBOutlet UITextField*commissionNumber;
        IBOutlet UITextField*decoration;
        IBOutlet UITextField*furniture;
        IBOutlet UITextField*floor;
        IBOutlet UITextField*hall;
        IBOutlet UITextField*houseApplication;
        IBOutlet UITextField*houseNumber;
        IBOutlet UITextField*onCommission;
        IBOutlet UITextField*person;
        IBOutlet UITextView*remark;
        IBOutlet UITextField*price;
        IBOutlet UITextField*room;
        IBOutlet UITextField*shop;
        IBOutlet UITextField*submitted;
        IBOutlet UITextField*supporting;
        IBOutlet UITextField*toilet;
        IBOutlet UITextField*ttarea;
        IBOutlet UITextField*ttfloor;
    ComBox*transactionBox;
    ComBox*statusBox;
    ComBox*areaBox;
    ComBox*regionBox;
    ComBox*uptownBox;
    WebData*dataResource;
    NSMutableArray*textFieldArray;
    NSMutableDictionary*inputDic;
    IBOutlet UIScrollView*mainScrollView;
    IBOutlet UIButton*pictureButton1;
    IBOutlet UIButton*pictureButton2;
    IBOutlet UIButton*pictureButton3;
    IBOutlet UIButton*pictureButton4;
    IBOutlet UIButton*pictureButton5;
}
@property(nonatomic,strong) IBOutlet UIButton*pictureButton5;
@property(nonatomic,strong) IBOutlet UIButton*pictureButton4;
@property(nonatomic,strong) IBOutlet UIButton*pictureButton3;
@property(nonatomic,strong) IBOutlet UIButton*pictureButton2;
@property(nonatomic,strong) IBOutlet UIButton*pictureButton1;
@property(nonatomic,strong)IBOutlet UIScrollView*mainScrollView;
@property(nonatomic,strong)UIPopoverController*currentPopView;
@property(nonatomic,strong)NSMutableArray*textFieldArray;
@property(nonatomic,strong)WebData*dataResource;
@property(nonatomic,strong)ComBox*transactionBox;
@property(nonatomic,strong)ComBox*statusBox;
@property(nonatomic,strong)ComBox*areaBox;
@property(nonatomic,strong)ComBox*regionBox;
@property(nonatomic,strong)ComBox*uptownBox;
@property(nonatomic,retain)IBOutlet UITextField*balcony;
@property(nonatomic,retain)IBOutlet UITextField*commissionNumber;
@property(nonatomic,retain)IBOutlet UITextField*decoration;
@property(nonatomic,retain)IBOutlet UITextField*furniture;
@property(nonatomic,retain)IBOutlet UITextField*floor;
@property(nonatomic,retain)IBOutlet UITextField*hall;
@property(nonatomic,retain)IBOutlet UITextField*houseApplication;
@property(nonatomic,retain)IBOutlet UITextField*houseNumber;
@property(nonatomic,retain)IBOutlet UITextField*onCommission;
@property(nonatomic,retain)IBOutlet UITextField*person;
@property(nonatomic,retain)IBOutlet UITextView*remark;
@property(nonatomic,retain)IBOutlet UITextField*price;
@property(nonatomic,retain)IBOutlet UITextField*room;
@property(nonatomic,retain)IBOutlet UITextField*shop;
@property(nonatomic,retain)IBOutlet UITextField*submitted;
@property(nonatomic,retain)IBOutlet UITextField*supporting;
@property(nonatomic,retain)IBOutlet UITextField*toilet;
@property(nonatomic,retain)IBOutlet UITextField*ttarea;
@property(nonatomic,retain)IBOutlet UITextField*ttfloor;
@property(nonatomic,strong)NSMutableDictionary*inputDic;
-(void)EditViewOpenWithDic:(NSMutableDictionary*)dic;
@end
