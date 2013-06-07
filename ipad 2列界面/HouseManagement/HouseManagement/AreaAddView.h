//
//  AreaAddView.h
//  HouseManagement
//
//  Created by  on 12-5-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AreaAddView : UIViewController
{
    IBOutlet UITextField*area;
    IBOutlet UITextField*region;
    IBOutlet UITextField*uptown;
    IBOutlet UITextView*address;
}
@property(nonatomic,strong)IBOutlet UITextView*address;
@property(nonatomic,strong)IBOutlet UITextField*area;
@property(nonatomic,strong)IBOutlet UITextField*region;
@property(nonatomic,strong)IBOutlet UITextField*uptown;
-(IBAction)add:(id)sender;
-(void)selfReset;
@end
