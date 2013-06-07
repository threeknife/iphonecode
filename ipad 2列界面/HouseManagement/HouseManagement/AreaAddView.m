//
//  AreaAddView.m
//  HouseManagement
//
//  Created by  on 12-5-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AreaAddView.h"
#import "WebData.h"
@interface AreaAddView ()
@property(nonatomic,strong)WebData*dataResource;
@end

@implementation AreaAddView
@synthesize area;
@synthesize region;
@synthesize uptown;
@synthesize dataResource;
@synthesize address;
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
    if (dataResource==nil) {
        dataResource=[[WebData alloc] init];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selfDismiss:) name:@"AreaAddViewDismiss" object:nil];
    // Do any additional setup after loading the view from its nib.
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
-(IBAction)add:(id)sender
{
    NSMutableDictionary*dic=[[NSMutableDictionary alloc] init];
    [dic setValue:area.text forKey:@"area"];
    [dic setValue:region.text forKey:@"region"];
    [dic setValue:uptown.text forKey:@"uptown"];
    [dic setValue:address.text forKey:@"address"];
    if ([[dic allKeys] count]!=3) {
        UIAlertView*alter=[[UIAlertView alloc] initWithTitle:@"保存错误" message:@"请完备信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        return;
    }
    else {
        for (id check in [dic allValues]) {
            if ([check isEqualToString:@""]) {
                UIAlertView*alter=[[UIAlertView alloc] initWithTitle:@"保存错误" message:@"请完备信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alter show];
                return;
            }
        }
    }
    if([dataResource saveArea:dic])
    {
        return;
    }
    else {
        UIAlertView*alter=[[UIAlertView alloc] initWithTitle:@"保存错误" message:@"该信息已存在" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
}
-(void)selfReset
{
    address.text=@"";
    region.text=@"";
    area.text=@"";
    uptown.text=@"";
}
-(void)selfDismiss:(id)sender
{
    [self.view removeFromSuperview];
}
@end
