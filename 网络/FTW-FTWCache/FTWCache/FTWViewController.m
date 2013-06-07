//
//  FTWViewController.m
//  FTWCache
//
//  Created by Soroush Khanlou on 8/12/12.
//  Copyright (c) 2012 FTW. All rights reserved.
//

#import "FTWViewController.h"

@implementation FTWViewController

@synthesize imageView, textField, scrollView;

- (void)viewDidLoad {
	[super viewDidLoad];
	textField.delegate = self;
	scrollView.alwaysBounceVertical = YES;
	[self loadImageFromURL:textField.text];
}

- (void) textFieldDidEndEditing:(UITextField *)aTextField {
	[self loadImageFromURL:textField.text];
}

- (BOOL) textFieldShouldReturn:(UITextField *)aTextField {
	[textField resignFirstResponder];
	return YES;
}

- (void) loadImageFromURL:(NSString*)URL {
	NSURL *imageURL = [NSURL URLWithString:URL];
	NSString *key = [URL MD5Hash];
	NSData *data = [FTWCache objectForKey:key];
	if (data) {
		UIImage *image = [UIImage imageWithData:data];
		imageView.image = image;
	} else {
		imageView.image = [UIImage imageNamed:@"img_def"];
		dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
		dispatch_async(queue, ^{
			NSData *data = [NSData dataWithContentsOfURL:imageURL];
			[FTWCache setObject:data forKey:key];
			UIImage *image = [UIImage imageWithData:data];
			dispatch_sync(dispatch_get_main_queue(), ^{
				imageView.image = image;
			});
		});
	}
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
