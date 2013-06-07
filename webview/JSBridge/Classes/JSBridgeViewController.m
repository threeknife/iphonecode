//
//  JSBridgeViewController.m
//  JSBridge
//
//  Created by Dante Torres on 10-09-03.
//  Copyright Dante Torres 2010. All rights reserved.
//

#import "JSBridgeViewController.h"

#import "JSBridgeAppDelegate.h"

#import "JSBridgeWebView.h"

@implementation JSBridgeViewController


// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization

    }
    return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	imageViewerController = [[ImageViewerController alloc] initWithNibName:@"ImageViewerController" bundle:nil];
	
	NSLog(@"View Did Load!");
	
		
	webView = [[JSBridgeWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	webView.delegate = self;
	
	[self loadMaskPage];
}

-(void) loadMaskPage
{	
	NSURL* url = [[NSBundle mainBundle] URLForResource:@"masks" withExtension:@"html"];
	[webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void) viewWillAppear:(BOOL)animated
{
	[self.view addSubview:webView];
}

- (BOOL)webView:(UIWebView *)p_WebView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
	NSLog(@"Should page load?. %@", [request URL]);
	return TRUE;
}

- (void)webViewDidFinishLoad:(UIWebView *)p_WebView
{
	NSLog(@"Page did finish load. %@", [[p_WebView request] URL]);
}

- (void)webViewDidStartLoad:(UIWebView *)p_WebView
{
	NSLog(@"Page did start load. %@", [[p_WebView request] URL]);
}

- (void)webView:(UIWebView *)p_WebView didFailLoadWithError:(NSError *)error
{
	NSLog(@"Page did fail with error. %@", [[p_WebView request] URL]);
}

- (void)webView:(UIWebView*) webview :(NSDictionary*) dictionary
{

	NSString* task = [dictionary objectForKey:@"task"];
	
	
	if([task compare:@"process_mask"] == NSOrderedSame)
	{
		imageViewerController.mask = [dictionary objectForKey:@"mask"];
		
		NSURL* url = [[NSBundle mainBundle] URLForResource:@"pics" withExtension:@"html"];
		[webView loadRequest:[NSURLRequest requestWithURL:url]];
		
	} else if ([task compare:@"process_pic"] == NSOrderedSame) {
		
		imageViewerController.pic = [dictionary objectForKey:@"pic"];
		[mainAppDelegate.window addSubview:imageViewerController.view];
	}
}


- (void)dealloc {
	
	[imageViewerController release];
	
    [super dealloc];
}

@end
