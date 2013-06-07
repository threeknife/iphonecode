//
//  MyWebView.h
//  UIWebView-Call-ObjC
//
//  Created by NativeBridge on 02/09/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SBJSON.h"

@interface MyWebView : UIWebView <UIWebViewDelegate> {
  SBJSON *json;
  
  int alertCallbackId;
}

- (void)handleCall:(NSString*)functionName callbackId:(int)callbackId args:(NSArray*)args;
- (void)returnResult:(int)callbackId args:(id)firstObj, ...;

@end
