//
//  ParseXmlCtrl.h
//  parserDataWithKissXml
//
//  Created by angel li on 11-1-17.
//  Copyright Lixf 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParseXmlCtrl : UIViewController {
	NSMutableArray *parsedDataArray;
}
@property (nonatomic, retain) NSMutableArray *parsedDataArray;

-(void)parsedDataFromData:(NSData *)data;
@end

