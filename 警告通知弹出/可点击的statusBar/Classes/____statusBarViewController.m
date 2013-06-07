//
//  ____statusBarViewController.m
//  可点击的statusBar
//
//  Created by jianghui.liu on 12-7-2.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "____statusBarViewController.h"

@implementation ____statusBarViewController
@synthesize immediateField, clickField;


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
    self.immediateField = nil;
    self.clickField     = nil;
}


- (void)dealloc {
    self.immediateField = nil;
    self.clickField     = nil;
    [super dealloc];
}

#pragma mark BUTTON-ACTION
-(IBAction)postImmediateMsg:(UIButton*)sender {
    [[MTStatusBarOverlay sharedInstance] postFinishMessage:self data:nil message:immediateField.text duration:2 animated:YES];
    
}

-(IBAction)postClickMsg:(UIButton*)sender {
    [[MTStatusBarOverlay sharedInstance] postFinishMessage:self data:[[NSObject new] autorelease] message:clickField.text duration:2 animated:YES];
}

#pragma mark MTStatusBarOverlayDelegate
- (void)statusBarOverlayClicked:(id)businessData msg:(NSString*)msg {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
    [alert show];
    [alert release];
    
}

@end
