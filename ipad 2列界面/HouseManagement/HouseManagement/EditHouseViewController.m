//
//  EditHouseViewController.m
//  HouseManagement
//
//  Created by  on 12-5-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "EditHouseViewController.h"

@interface EditHouseViewController ()
{
    int pictureButtonTag;
}
@property(nonatomic,strong)House*house;
-(IBAction)picture:(id)sender;
@end

@implementation EditHouseViewController
@synthesize pictureButton5;
@synthesize pictureButton4;
@synthesize pictureButton3;
@synthesize pictureButton2;
@synthesize pictureButton1;
@synthesize mainScrollView;
@synthesize currentPopView;
@synthesize balcony;
@synthesize commissionNumber;
@synthesize decoration;
@synthesize furniture;
@synthesize floor;
@synthesize hall;
@synthesize houseApplication;
@synthesize houseNumber;
@synthesize onCommission;
@synthesize person;
@synthesize remark;
@synthesize price;
@synthesize room;
@synthesize shop;
@synthesize submitted;
@synthesize supporting;
@synthesize toilet;
@synthesize ttarea;
@synthesize ttfloor;
@synthesize uptownBox;
@synthesize areaBox;
@synthesize statusBox;
@synthesize transactionBox;
@synthesize regionBox;
@synthesize dataResource;
@synthesize textFieldArray;
@synthesize house;
@synthesize inputDic;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    if (mainScrollView==nil) {
        mainScrollView=[[UIScrollView alloc] init];
    }
    [super viewDidLoad];
    textFieldArray=[[NSMutableArray alloc] initWithObjects:floor,ttfloor,ttarea,room,hall,toilet,balcony,price,nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selfDismiss:) name:@"EditHouseViewDismiss" object:nil];
    if (dataResource==nil) {
        dataResource=[[WebData alloc] init];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    UISwipeGestureRecognizer*recognizer=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipDismiss:)];
    [recognizer setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:recognizer];
    
    //ComBox Set
    if (transactionBox==nil) {
        NSMutableArray*array=[[NSMutableArray alloc] initWithObjects:@"出售",@"出租", nil];
        transactionBox=[[ComBox alloc] initWithX:70 Y:19 width:100 rootView:self.view data:array];
        [mainScrollView addSubview:transactionBox];
        transactionBox.delegate=self;
    }
    if(statusBox==nil)
    {
        NSMutableArray*array=[[NSMutableArray alloc] initWithObjects:@"在售",@"已售", nil];
        statusBox=[[ComBox alloc] initWithX:240 Y:19 width:100 rootView:self.view data:array];
        [mainScrollView addSubview:statusBox];
        statusBox.delegate=self;
    }
    if (areaBox==nil) {
        NSMutableArray*array=[[NSMutableArray alloc] init];
        array=[dataResource detailArea];
       areaBox=[[ComBox alloc] initWithX:70 Y:66 width:100 rootView:self.view data:array];
        [mainScrollView addSubview:areaBox];
        areaBox.delegate=self;
    }
    if (regionBox==nil) {
        NSMutableArray*array=[[NSMutableArray alloc] init];
        regionBox=[[ComBox alloc] initWithX:240 Y:66 width:100 rootView:self.view data:array];
        [mainScrollView addSubview:regionBox];
        regionBox.delegate=self;
    }
    if (uptownBox==nil) {
        NSMutableArray*array=[[NSMutableArray alloc] init];
        uptownBox=[[ComBox alloc] initWithX:420 Y:66 width:120 rootView:self.view data:array];
        [mainScrollView addSubview:uptownBox];
        uptownBox.delegate=self;
    }
    //scroll view
    mainScrollView.indicatorStyle=UIScrollViewIndicatorStyleWhite;
    mainScrollView.clipsToBounds=YES;
    mainScrollView.pagingEnabled=NO;
    [mainScrollView setContentSize:CGSizeMake(553,756)];
    [mainScrollView setScrollEnabled:YES];
    //textField/Users/diamond/work/HouseManagement/HouseManagement/HouseManagement.xcdatamodeld/HouseManagement.xcdatamodel
    NumberKeyBoardView*numberKeyboardView=[[NumberKeyBoardView alloc] init];
    numberKeyboardView.delegate=self;
    [balcony setInputView:numberKeyboardView];
    [floor setInputView:numberKeyboardView];
    [ttfloor setInputView:numberKeyboardView];
    [ttarea setInputView:numberKeyboardView];
    [room setInputView:numberKeyboardView];
    [hall setInputView:numberKeyboardView];
    [toilet setInputView:numberKeyboardView];
    [price setInputView:numberKeyboardView];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [self EditViewOpenWithDic:inputDic];
}
-(void)EditViewOpenWithDic:(NSMutableDictionary*)dic
{
    
    NSString*string=[dic objectForKey:@"transaction"];
    [transactionBox.centerButton setTitle:string forState:UIControlStateNormal];
    transactionBox.selected=string;
    string=[dic objectForKey:@"status"];
    [statusBox.centerButton setTitle:string forState:UIControlStateNormal];
    statusBox.selected=string;
    string=[dic objectForKey:@"area"];
    [areaBox.centerButton setTitle:string forState:UIControlStateNormal];
    areaBox.selected=string;
    areaBox.dataArray=[dataResource detailArea];
    string=[dic objectForKey:@"region"];
    regionBox.dataArray=[dataResource detailRegion:areaBox.selected];
    [regionBox.centerButton setTitle:string forState:UIControlStateNormal];
    regionBox.selected=string;
    string=[dic objectForKey:@"uptown"];
    uptownBox.dataArray=[dataResource detailUptown:regionBox.selected];
    [uptownBox.centerButton setTitle:string forState:UIControlStateNormal];
    uptownBox.selected=string;
    balcony.text=[dic objectForKey:@"balcony"];
    decoration.text=[dic objectForKey:@"decoration"];
    floor.text=[dic objectForKey:@"floor"];
    hall.text=[dic objectForKey:@"hall"];
    ttfloor.text=[dic objectForKey:@"ttfloor"];
    houseNumber.text=[dic objectForKey:@"houseNumber"];
    person.text=[dic objectForKey:@"person"];
    room.text=[dic objectForKey:@"room"];
    shop.text=[dic objectForKey:@"shop"];
    supporting.text=[dic objectForKey:@"supporting"];
    toilet.text=[dic objectForKey:@"toilet"];
    ttarea.text=[[dic objectForKey:@"ttarea"] stringValue];
    if ([transactionBox.selected isEqualToString:@"出售"]) {
        price.text=[[dic objectForKey:@"salePrice"] stringValue];
    }
    else {
        price.text=[[dic objectForKey:@"rentPrice"] stringValue];
    }
    remark.text=[dic objectForKey:@"remark"];
    [pictureButton1 setImage:[dic objectForKey:@"housePicture1"] forState:UIControlStateNormal];
    [pictureButton2 setImage:[dic objectForKey:@"housePicture2"] forState:UIControlStateNormal];
    [pictureButton3 setImage:[dic objectForKey:@"housePicture3"] forState:UIControlStateNormal];
    [pictureButton4 setImage:[dic objectForKey:@"housePicture4"] forState:UIControlStateNormal];
    [pictureButton5 setImage:[dic objectForKey:@"housePicture5"] forState:UIControlStateNormal];
    house=[dataResource excuteHouse:[dic objectForKey:@"houseNumber"]];
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
-(IBAction)saveTheData:(id)sender
{
    NSMutableDictionary*dic=[[NSMutableDictionary alloc] init];
    [dic setValue:transactionBox.selected forKey:@"transaction"];
    [dic setValue:statusBox.selected forKey:@"status"];
    [dic setValue:areaBox.selected forKey:@"area"];
    [dic setValue:regionBox.selected forKey:@"region"];
    [dic setValue:uptownBox.selected forKey:@"uptown"];
    [dic setValue:decoration.text forKey:@"decoration"];
    [dic setValue:floor.text forKey:@"floor"];
    [dic setValue:hall.text forKey:@"hall"];
    [dic setValue:houseNumber.text forKey:@"houseNumber"];
    [dic setValue:person.text forKey:@"person"];
    [dic setValue:room.text forKey:@"room"];
    [dic setValue:shop.text forKey:@"shop"];    
    [dic setValue:toilet.text forKey:@"toilet"];
    [dic setValue:[NSNumber numberWithFloat:[ttarea.text floatValue]] forKey:@"ttarea"];
    if ([transactionBox.selected isEqualToString:@"出售"]) {
        [dic setValue:[NSNumber numberWithFloat:[price.text floatValue]] forKey:@"salePrice"];   
    }
    else if ([transactionBox.selected isEqualToString:@"出租"]) {
        [dic setValue:[NSNumber numberWithFloat:[price.text floatValue]] forKey:@"rentPrice"];
    }
    else {
        UIAlertView*alter=[[UIAlertView alloc] initWithTitle:@"保存错误" message:@"请完备信息" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
        [alter show];
        return;
    }
    NSArray*checkArray=[dic allKeys];
        if ([checkArray count]!=15) {
            UIAlertView*alter=[[UIAlertView alloc] initWithTitle:@"保存错误" message:@"请完备信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alter show];
            return;
        }
        else {
            for (id checkValue in [dic allValues]) {
                BOOL NilValue=NO;
                if ([checkValue isKindOfClass:[NSNumber class]]) {
                    NilValue=[[checkValue stringValue] isEqualToString:@""];
                }
                else {
                    NilValue=[checkValue isEqualToString:@""];
                }
                if (NilValue==YES) {
                    UIAlertView*alter=[[UIAlertView alloc] initWithTitle:@"保存错误" message:@"请完备信息" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
                    [alter show];
                    return;
                }
            }
    }
    [dic setValue:ttfloor.text forKey:@"ttfloor"];
    [dic setValue:balcony.text forKey:@"balcony"];
    [dic setValue:remark.text forKey:@"remark"];
    [dic setValue:supporting.text forKey:@"supporting"];
    [dic setValue:pictureButton1.imageView.image forKey:@"housePicture1"];
    [dic setValue:pictureButton2.imageView.image forKey:@"housePicture2"];
    [dic setValue:pictureButton3.imageView.image forKey:@"housePicture3"];
    [dic setValue:pictureButton4.imageView.image forKey:@"housePicture4"];
    [dic setValue:pictureButton5.imageView.image forKey:@"housePicture5"];
    [dataResource saveHouse:dic deleteHouse:house];
    [self.view removeFromSuperview];
}
-(void)selfDismiss:(id)sender
{
    [self.view removeFromSuperview];
}
#pragma mark comBox Delegate
-(void)selfValueChanged:(id)sender
{
    if (sender==transactionBox) {
        if ([transactionBox.selected isEqualToString:@"出售"]) {
            NSMutableArray*array=[[NSMutableArray alloc] initWithObjects:@"在售",@"已售", nil];
            statusBox.dataArray=array;
            [statusBox.centerButton setTitle:[array objectAtIndex:0] forState:UIControlStateNormal];
            statusBox.selected=[array objectAtIndex:0];
        }
        else {
            NSMutableArray*array=[[NSMutableArray alloc] initWithObjects:@"在租",@"已租", nil];
            statusBox.dataArray=array;
            [statusBox.centerButton setTitle:[array objectAtIndex:0] forState:UIControlStateNormal];
            statusBox.selected=[array objectAtIndex:0];
        }
    }
    if (sender==areaBox) {
            NSMutableArray*array=[[NSMutableArray alloc] init];
            array=[dataResource detailRegion:areaBox.selected];
            regionBox.dataArray=array;
        if ([array count]>0) {
            [regionBox.centerButton setTitle:[array objectAtIndex:0] forState:UIControlStateNormal];
            regionBox.selected=[array objectAtIndex:0];
        }
        else {
            [regionBox.centerButton setTitle:@"无" forState:UIControlStateNormal];
            regionBox.selected=@"无";
        }
        NSMutableArray*arrayNil=[[NSMutableArray alloc] init];
        uptownBox.dataArray=arrayNil;
        [uptownBox.centerButton setTitle:@"无" forState:UIControlStateNormal];
        uptownBox.selected=@"无";

    }
    if (sender==regionBox) {
        NSMutableArray*array=[[NSMutableArray alloc] init];
        array=[dataResource detailUptown:regionBox.selected];
        uptownBox.dataArray=array;
        if ([array count]>0) {
            [uptownBox.centerButton setTitle:[array objectAtIndex:0] forState:UIControlStateNormal];
            uptownBox.selected=[array objectAtIndex:0];
        }
        else {
            [uptownBox.centerButton setTitle:@"无" forState:UIControlStateNormal];
            uptownBox.selected=@"无";
        }
    }
}
-(void)closeOtherComBox:(id)sender
{
    NSMutableArray*array=[[NSMutableArray alloc] initWithObjects:areaBox,regionBox,statusBox,transactionBox,uptownBox, nil];
    for (id button in array) {
        if (button!=sender) {
            [button backList];
        }
    }
}
#pragma mark NumberKeyBoardDelegate
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
-(void)keyboardWillShow:(id)sender
{
    CGContextRef context = UIGraphicsGetCurrentContext();
	[UIView beginAnimations:nil context:context];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:0.4];	
    if ([remark isFirstResponder]) {
        [self.view setFrame:CGRectMake(430, -170, 553, 626)];
    }
    else if ([shop isFirstResponder]) {
        [self.view setFrame:CGRectMake(430, -250, 553, 626)];
    }
    else if ([person isFirstResponder]) {
        [self.view setFrame:CGRectMake(430, -250, 553, 626)];
    }
    else {
         [self.view setFrame:CGRectMake(430, 50, 553, 626)];
    }
    [UIView commitAnimations];
}
-(void)keyboardWillHide:(id)sender
{
    CGContextRef context = UIGraphicsGetCurrentContext();
	[UIView beginAnimations:nil context:context];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:0.4];	
    [self.view setFrame:CGRectMake(430, 50, 553, 626)];
    [UIView commitAnimations];
}
#pragma mark moveDismiss
-(void)handleSwipDismiss:(id)sender
{   CGContextRef context = UIGraphicsGetCurrentContext();
	[UIView beginAnimations:nil context:context];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:1];	
    [self.view setFrame:CGRectMake(1024,50, 553, 626)];
    [UIView commitAnimations];
}
#pragma mark AlterDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==4) {
        if (buttonIndex==1) {
            UIImagePickerController*ipc=[[UIImagePickerController alloc] init];
            ipc.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
            ipc.allowsEditing=NO;
            ipc.delegate=self;
            UIPopoverController*popView=[[UIPopoverController alloc]initWithContentViewController:ipc];
            popView.delegate=self;
            self.currentPopView=popView;
            if (pictureButtonTag==1) {
            [popView presentPopoverFromRect:CGRectMake(pictureButton1.frame.origin.x/2+50,pictureButton1.frame.origin.y,1,1) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
                [self.currentPopView setPopoverContentSize:CGSizeMake(300, 300)];
                //return;
            }
            if (pictureButtonTag==2) {
                [popView presentPopoverFromRect:CGRectMake(pictureButton1.frame.origin.x/2+50+110,pictureButton2.frame.origin.y,1,1) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
                [self.currentPopView setPopoverContentSize:CGSizeMake(300, 300)];
                //return;
            }
            if (pictureButtonTag==3) {
                [popView presentPopoverFromRect:CGRectMake(pictureButton1.frame.origin.x/2+50+110*2,pictureButton3.frame.origin.y,1,1) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
                [self.currentPopView setPopoverContentSize:CGSizeMake(300, 300)];
                //return;
            }
            if (pictureButtonTag==4) {
                [popView presentPopoverFromRect:CGRectMake(pictureButton1.frame.origin.x/2+50+110*3,pictureButton4.frame.origin.y,1,1) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
                [self.currentPopView setPopoverContentSize:CGSizeMake(300, 300)];
                //return;
            }
            if (pictureButtonTag==5) {
                [popView presentPopoverFromRect:CGRectMake(pictureButton1.frame.origin.x/2+50+110*4,pictureButton5.frame.origin.y,1,1) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
                [self.currentPopView setPopoverContentSize:CGSizeMake(300, 300)];
                //return;
            }
            
        }
    }
}
-(void)showAlter:(NSString*)message
{
    UIAlertView*av=[[UIAlertView alloc] initWithTitle:@"请选择" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"从相册中选取", nil];
    av.tag=4;
    [av show];
}
-(IBAction)picture:(id)sender
{
    UIButton*button=(UIButton*)sender;
    pictureButtonTag=button.tag;
    [self showAlter:nil];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{ 
    NSMutableArray*array=[[NSMutableArray alloc] initWithObjects:pictureButton1,pictureButton2,pictureButton3,pictureButton4,pictureButton5, nil];
    for (UIButton*button in array) {
        if (button.tag==pictureButtonTag) {
        [button setImage:[info objectForKey:@"UIImagePickerControllerOriginalImage"] forState:UIControlStateNormal];
        }
    }
    //self.currentPopView=nil;
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    NSDictionary*dict=[NSDictionary dictionaryWithObject:image forKey:@"UIImagePickerControllerOriginalImage"];
    [self imagePickerController:picker didFinishPickingMediaWithInfo:dict];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
}
@end
