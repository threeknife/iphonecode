//
//  ViewController.m
//  WebViewTest
//
//  Created by hekun on 12-6-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}
//加载本地使用说明文件文件
-(void)loadDocument:(NSString *)docName 
{
    NSString *mainBundleDirectory=[[NSBundle mainBundle] bundlePath];
    NSString *path=[mainBundleDirectory stringByAppendingPathComponent:docName];
    
    NSURL *url=[NSURL fileURLWithPath:path];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    iWebView.scalesPageToFit=YES;
    [iWebView loadRequest:request];
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    iWebView = [[UIWebView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.view addSubview:iWebView];
    [iWebView setBackgroundColor:[UIColor clearColor]];
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    [header setBackgroundColor:[UIColor clearColor]];
    
    [self loadDocument:@"Detail.html"];

//    CGRect browserCanvas = CGRectMake(0,0,320,416);
//    for (int i = 0; i<[iWebView.scrollView.subviews count]; i++) {
//        UIView *subview = [[iWebView.scrollView subviews] objectAtIndex:i];
//        
//        CGRect f = subview.frame;
//        NSLog(@"sub %d -> x:%.0f, y:%.0f, w:%.0f, h:%.0f", i, f.origin.x, f.origin.y, f.size.width, f.size.height);
//        
//        if(f.origin.x == browserCanvas.origin.x && 
//           f.origin.y == browserCanvas.origin.y && 
//           f.size.width == browserCanvas.size.width && 
//           f.size.height == browserCanvas.size.height)
//        {
//            f.origin.y = header.frame.size.height;
//            subview.frame = f;
//        }
//    }
    //[iWebView.superview insertSubview:header atIndex:0];
    //[(UIScrollView *)[iWebView.subviews objectAtIndex:0] setContentInset:UIEdgeInsetsMake(50, 0, 0, 0)];
   // [iWebView conformsToProtocol:<#(Protocol *)#>]
   // [iWebView insertSubview:header atIndex:0];
//    if (!header) {
//        <#statements#>
//    }
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
