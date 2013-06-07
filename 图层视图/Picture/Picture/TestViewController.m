//
//  TestViewController.m
//  Picture
//
//  Created by Keggcalm on 12-1-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TestViewController.h"
#import "PicGestureRecognizerView.h"
#import "PicetureView.h"

@implementation TestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc
{
    [combinePicView release];
    combinePicView = nil;
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    combinePicView = [[CombinePicView alloc] initWithFrame:CGRectMake(20, 20, 280, 360)];
    combinePicView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:combinePicView];
    
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    saveButton.frame = CGRectMake(20, 400, 280, 30);
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(saveButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveButton];
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
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)saveButtonAction
{
    UIGraphicsBeginImageContext(CGSizeMake(280, 360));
	[combinePicView.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(image,nil, nil, nil);
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"保存成功" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    [alertView show];
    [alertView release];
    
}

@end
