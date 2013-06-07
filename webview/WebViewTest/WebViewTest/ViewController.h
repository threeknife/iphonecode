//
//  ViewController.h
//  WebViewTest
//
//  Created by hekun on 12-6-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIWebViewDelegate>
{
    UIWebView *iWebView;
}
-(void)loadDocument:(NSString *)docName;
@end
