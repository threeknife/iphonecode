//
//  MainViewController.m
//  DemoProject
//
//  Created by Edward Patel on 2010-02-28.
//  Copyright Memention AB 2010. All rights reserved.
//

#import "MainViewController.h"
#import "MainView.h"

#import "DemoTransition.h"
#import "Demo2Transition.h"
#import "Demo3Transition.h"
#import"Demo4Transition.h"
#import"Demo5Transition.h"
#import"Demo6Transition.h"
#import"Demo7Transition.h"
#import"Demo8Transition.h"
#import "WiAdView.h"
@implementation MainViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    WiAdView* adView = [WiAdView adViewWithResId:@"4844096a1364e610" style:kWiAdViewStyleBanner320_50];
    adView.center = CGPointMake(160.0,20);
    adView.delegate = self;
    adView.refreshInterval = 31;
    adView.adBgColor = [UIColor colorWithRed:1.0f green:(CGFloat)0x66/255 blue:(CGFloat)0x33/255 alpha:1.0f];
    [self.view addSubview:adView];
    [adView requestAd];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"request-close.png"]];
    [self.view addSubview:imageView];
    imageView.center = CGPointMake(310,adView.center.y);
    
}

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


- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller 
{
    if (buttontag==-1) 
	{
		[self dismissModalViewControllerAnimated:NO];
		return;
	}
	NSObject<EPGLTransitionViewDelegate> *transition;
    
	switch (buttontag) {
		case 100:
			transition = [[[Demo2Transition alloc] init] autorelease];
			break;
		case 101:
			transition = [[[Demo6Transition alloc] init] autorelease];
			break;
		case 102:
			transition = [[[Demo4Transition alloc] init] autorelease];
			break;
		case 103:
			transition = [[[Demo7Transition alloc] init] autorelease];
			break;
		case 104:
			transition = [[[Demo8Transition alloc] init] autorelease];
			break;
	}
	
    EPGLTransitionView *glview = [[[EPGLTransitionView alloc] 
                                   initWithView:controller.view
                                   delegate:transition] autorelease];
    
    if (buttontag) {
        [glview prepareTextureTo:self.view];
		// If you are using an "IN" animation for the "next" view set appropriate 
		// clear color (ie no alpha) 
		[glview setClearColorRed:0.0
						   green:0.0
							blue:0.0
						   alpha:1.0];
	}    
    
    [glview startTransition];	
    [self dismissModalViewControllerAnimated:NO];
}
-(void)setButtontag:(NSInteger)t
{
	buttontag = t;
}

- (IBAction)showInfo:(id)sender 
{        
    
    kIsAdShow;
    FlipsideViewController *controller = [[FlipsideViewController alloc] 
                                          initWithNibName:@"FlipsideView" 
                                          bundle:nil];
    controller.delegate = self;
    
    NSObject<EPGLTransitionViewDelegate> *transition;
    
	switch ([sender tag]) {
		case 0:
			transition = [[[DemoTransition alloc] init] autorelease];
			break;
		case 1:
			transition = [[[Demo5Transition alloc] init] autorelease];
			break;
		case 2:
			transition = [[[Demo3Transition alloc] init] autorelease];
			break;
	}

    EPGLTransitionView *glview = [[[EPGLTransitionView alloc] 
                                   initWithView:self.view
                                   delegate:transition] autorelease];
    
    if ([sender tag]) {
        [glview prepareTextureTo:controller.view];
		// If you are using an "IN" animation for the "next" view set appropriate 
		// clear color (ie no alpha) 
		[glview setClearColorRed:0.0
						   green:0.0
							blue:0.0
						   alpha:1.0];
	}    
    
    [glview startTransition];
    
    [self presentModalViewController:controller animated:NO];
    
    
    [controller release];
}



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
}


- (void)dealloc {
    [super dealloc];
}


@end
