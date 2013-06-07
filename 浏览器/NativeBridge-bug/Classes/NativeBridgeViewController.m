//
//  NativeBridgeViewController.m
//  NativeBridge
//
//  Created by NativeBridge on 14/09/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NativeBridgeViewController.h"

#import "MyWebView.h"

@implementation NativeBridgeViewController



- (void)loadView {
  CGRect frame=[UIScreen mainScreen].applicationFrame;
  
  self.view = [[MyWebView alloc] initWithFrame:frame];
}



- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
