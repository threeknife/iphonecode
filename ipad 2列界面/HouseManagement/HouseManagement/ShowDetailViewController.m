//
//  ShowDetailViewController.m
//  HouseManagement
//
//  Created by  on 12-5-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ShowDetailViewController.h"
#import "WebData.h"
@interface ShowDetailViewController ()

@end

@implementation ShowDetailViewController
@synthesize mainScrollView;
@synthesize area;
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
@synthesize region;
@synthesize remark;
@synthesize rentPrice;
@synthesize room;
@synthesize salePrice;
@synthesize shop;
@synthesize status;
@synthesize submitted;
@synthesize supporting;
@synthesize toilet;
@synthesize transaction;
@synthesize ttarea;
@synthesize ttfloor;
@synthesize uptown;
@synthesize delegate;
@synthesize perPrice;
@synthesize balconyText;
@synthesize pictureScrollView;
@synthesize dataResource;
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
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UISwipeGestureRecognizer*recognizer=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipDismiss:)];
    [recognizer setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:recognizer];
    //set ScrolView
    mainScrollView.indicatorStyle=UIScrollViewIndicatorStyleBlack;
    mainScrollView.clipsToBounds=YES;
    mainScrollView.pagingEnabled=NO;
    [mainScrollView setContentSize:CGSizeMake(500,780)];
    [mainScrollView setScrollEnabled:YES];
    [pictureScrollView setScrollEnabled:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeSelf:) name:@"ShowDetailViewDismiss" object:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)viewWillAppear:(BOOL)animated
{
    [self setTheData:dataResource];
    [super viewWillAppear:animated];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft)||(interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

-(void)setTheData:(NSMutableDictionary*)resource
{
    NSString*stringSource=[resource objectForKey:@"houseNumber"];
    houseNumber.text=stringSource;
    stringSource=[resource objectForKey:@"uptown"];
    uptown.text=stringSource;
    stringSource=[resource objectForKey:@"area"];
    area.text=stringSource;
    stringSource=[resource objectForKey:@"region"];
    region.text=stringSource;
    stringSource=[resource objectForKey:@"floor"];
    floor.text=stringSource;
    stringSource=[resource objectForKey:@"ttfloor"];
    ttfloor.text=stringSource;
    stringSource=[resource objectForKey:@"room"];
    room.text=stringSource;
    stringSource=[resource objectForKey:@"hall"];
    hall.text=stringSource;
    stringSource=[resource objectForKey:@"toilet"];
    toilet.text=stringSource;
    stringSource=[resource objectForKey:@"balcony"];
    if (stringSource !=nil) {
        balcony.text=stringSource;
        [balconyText setHidden:NO];
        [balcony setHidden:NO];
    }
    else {
        [balconyText setHidden:YES];
        [balcony setHidden:YES];
    }
    NSNumber*number=[resource objectForKey:@"ttarea"];
    stringSource=[number stringValue];
    ttarea.text=stringSource;
    stringSource=[resource objectForKey:@"decoration"];
    decoration.text=stringSource;
    stringSource=[resource objectForKey:@"supporting"];
    supporting.text=stringSource;
    stringSource=[resource objectForKey:@"furniture"];
    furniture.text=stringSource;
    stringSource=[resource objectForKey:@"houseApplication"];
    houseApplication.text=stringSource;
    stringSource=[resource objectForKey:@"remark"];
    remark.text=stringSource;
    stringSource=[resource objectForKey:@"transaction"];
    transaction.text=stringSource;
    stringSource=[resource objectForKey:@"status"];
    status.text=stringSource;
    NSNumber*pricenumber=[resource objectForKey:@"salePrice"];
    salePrice.text=[pricenumber stringValue];
    float per=[pricenumber floatValue]/[number floatValue];
    per=round( per * 100.0 ) / 100.0;
    perPrice.text=[NSString stringWithFormat:@"%.2f",per];
    pricenumber=[resource objectForKey:@"rentPrice"];
    rentPrice.text=[pricenumber stringValue];
    stringSource=[resource objectForKey:@"delegate"];
    delegate.text=stringSource;
    stringSource=[resource objectForKey:@"onCommission"];
    onCommission.text=stringSource;
    stringSource=[resource objectForKey:@"submitted"];
    submitted.text=stringSource;
    stringSource=[resource objectForKey:@"commissionNumber"];
    commissionNumber.text=stringSource;
    stringSource=[resource objectForKey:@"shop"];
    shop.text=stringSource;
    stringSource=[resource objectForKey:@"person"];
    person.text=stringSource;
    //pictureScrollView
    pictureScrollView.indicatorStyle=UIScrollViewIndicatorStyleWhite;
    pictureScrollView.clipsToBounds=YES;
    pictureScrollView.pagingEnabled=YES;
    int countPicture=0;
    for (id view in [pictureScrollView subviews]) {
        [view removeFromSuperview];
    }
    for (int i=1; i<=5; i++) {
        stringSource=[NSString stringWithFormat:@"housePicture%d",i];
        UIImage*image=[resource objectForKey:stringSource];
        if (image !=nil) {
            UIImageView*imageView=[[UIImageView alloc] initWithFrame:CGRectMake((i-1)*281+1,1, 281, 185)];
            [imageView setImage:image];
            //UIButton*button=[[UIButton alloc] initWithFrame:CGRectMake((i-1)*281+1,1, 281, 185)];
            //button=[UIButton buttonWithType:UIButtonTypeCustom];
            //[button setImage:image forState:UIControlStateNormal];
            //[button setEnabled:NO];
            //[button setEnabled:NO];
            [pictureScrollView addSubview:imageView];            
            countPicture++;
        }
    }
    if (countPicture==0) {
        countPicture=1;
    }
    [pictureScrollView setContentSize:CGSizeMake(countPicture*281, 185)];
}
#pragma mark close noti
-(void)closeSelf:(NSNotification*)noti
{
    [self.view removeFromSuperview];
}
-(void)handleSwipDismiss:(id) sender
{   CGContextRef context = UIGraphicsGetCurrentContext();
	[UIView beginAnimations:nil context:context];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:1];	
    [self.view setFrame:CGRectMake(1024, 0,600, 760)];
    [UIView commitAnimations];
}

@end
