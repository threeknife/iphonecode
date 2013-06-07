//
//  FTWViewController.h
//  FTWCache
//
//  Created by Soroush Khanlou on 8/12/12.
//  Copyright (c) 2012 FTW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FTWCache.h"
#import "NSString+MD5.h"

@interface FTWViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IBOutlet UITextField *textField;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

- (void) loadImageFromURL:(NSString*)URL;

@end
