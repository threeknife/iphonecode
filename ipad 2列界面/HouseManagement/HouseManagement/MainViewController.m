//
//  MainViewController.m
//  HouseManagement
//
//  Created by  on 12-5-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "HouseTableViewController.h"
#import "ShowDetailViewController.h"
#import "SearchViewController.h"
#import "EditHouseViewController.h"
#import "AreaAddView.h"
//test Import
#import "WebData.h"
@interface MainViewController ()

@property (nonatomic, retain) HouseTableViewController*tableViewList;
@property (nonatomic,retain) ShowDetailViewController*showDetailView;
@property(nonatomic,retain)SearchViewController*searchView;
@property(nonatomic,retain)EditHouseViewController*editView;
@property(nonatomic,retain)WebData*webData;
@property(nonatomic,retain)AreaAddView*areaAdd;
@end

@implementation MainViewController
@synthesize tableViewList;
@synthesize showDetailView;
@synthesize searchView;
@synthesize webData;
@synthesize editView;
@synthesize areaAdd;
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
    if (webData==nil) {
        webData=[[WebData alloc] init];
    }
	// Do any additional setup after loading the view.
    if (tableViewList == Nil) {
        tableViewList =[[HouseTableViewController alloc] initWithNibName:@"HouseTableViewController" bundle:nil];
        tableViewList.mainViewController=self;
        
    }
    if (showDetailView==nil) {
        showDetailView=[[ShowDetailViewController alloc] initWithNibName:@"ShowDetailViewController" bundle:nil];
    }
    if (searchView==nil) {
        searchView=[[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil];
        searchView.mainView=self;
    }
    if (editView==nil) {
        editView=[[EditHouseViewController alloc] initWithNibName:@"EditHouseViewController" bundle:nil];
        
    }
    if (areaAdd==nil) {
        areaAdd=[[AreaAddView alloc] initWithNibName:@"AreaAddView" bundle:nil];
    }
     NSLog(@"View Count %d",[[[self view] subviews] count]);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft)||(interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}
#pragma mark showHouse
-(IBAction)showHouseManageView:(id)sender
{
    //Close View Noti
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowDetailViewDismiss" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SearchViewDismiss" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EditHouseViewDismiss" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AreaAddViewDismiss" object:nil];
    //addSubView new
    if ([sender isKindOfClass:[NSMutableArray class]]) {
        tableViewList.houseArray=[tableViewList selfStatusSet:sender];
        [tableViewList selfReset];
        [tableViewList.tableView reloadData];
    }
    else {
        tableViewList.houseArray=[tableViewList selfStatusSet:[webData returnAllData]];
        [tableViewList selfReset];
        [tableViewList.tableView reloadData];
    }
    [self.view addSubview:tableViewList.view];
    [tableViewList.view setFrame:CGRectMake(150, -100, 485, 700)];
    CGContextRef context = UIGraphicsGetCurrentContext();
	[UIView beginAnimations:nil context:context];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:0.5];
	[tableViewList.view setFrame:CGRectMake(150, 000,485, 700)];	
	[UIView commitAnimations];
    NSLog(@"View Count %d",[[[self view] subviews] count]);
}

-(void)showDetailView:(NSMutableDictionary *)dic
{
    showDetailView.dataResource=dic;
    [showDetailView setTheData:dic];
    [self.view addSubview:showDetailView.view];
    CGContextRef context = UIGraphicsGetCurrentContext();
    [showDetailView.view setFrame:CGRectMake(800, 0,600, 760)];
	[UIView beginAnimations:nil context:context];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:1];
	[showDetailView.view setFrame:CGRectMake(430, 0,600, 760)];	
    [tableViewList.view setFrame:CGRectMake(150, 000, 485, 700)];
	[UIView commitAnimations];
    NSLog(@"View Count %d",[[[self view] subviews] count]);
}
-(void)showEditHouseVIew:(NSMutableDictionary*)dic
{
    
    if (dic!=nil) {
        editView.inputDic=dic;
    [editView EditViewOpenWithDic:dic];
    [self.view addSubview:editView.view];
    CGContextRef context=UIGraphicsGetCurrentContext();
    [editView.view setFrame:CGRectMake(800,50, 553, 626)];
    [UIView beginAnimations:nil context:context];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:1];
	[editView.view setFrame:CGRectMake(430, 50,553,626)];	
    [tableViewList.view setFrame:CGRectMake(150, 000, 485, 700)];
    [UIView commitAnimations];
     NSLog(@"View Count %d",[[[self view] subviews] count]);
    }
    else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowDetailViewDismiss" object:nil];
        [editView EditViewOpenWithDic:nil];
        [self.view addSubview:editView.view];
        CGContextRef context=UIGraphicsGetCurrentContext();
        [editView.view setFrame:CGRectMake(800,50, 553, 626)];
        [UIView beginAnimations:nil context:context];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:1];
        [editView.view setFrame:CGRectMake(430,50,553,626)];	
        [UIView commitAnimations];
    }
}
-(IBAction)ShowSearchView:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HouseTableViewDismiss" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AreaAddViewDismiss" object:nil];
    [searchView selfReset];
    [self.view addSubview:searchView.view];
    [searchView.view setFrame:CGRectMake(-200, 000, 661, 219)];
    CGContextRef context = UIGraphicsGetCurrentContext();
	[UIView beginAnimations:nil context:context];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:0.5];
	[searchView.view setFrame:CGRectMake(200, 000,661,219)];	
	[UIView commitAnimations];
    NSLog(@"View Count %d",[[[self view] subviews] count]);
}
-(IBAction)ShowAreaManageView:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HouseTableViewDismiss" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SearchViewDismiss" object:nil];
    [areaAdd selfReset];
    [self.view addSubview:areaAdd.view];
    [areaAdd.view setFrame:CGRectMake(350,0,248,401)];
    CGContextRef context=UIGraphicsGetCurrentContext();
	[UIView beginAnimations:nil context:context];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:0.5];
	[areaAdd.view setFrame:CGRectMake(350,180,248,401)];	
	[UIView commitAnimations];
}
@end
