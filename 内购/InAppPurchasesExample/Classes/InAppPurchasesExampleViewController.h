//
//  InAppPurchasesExampleViewController.h
//  InAppPurchasesExample
//
//  Created by  Yakov Ilyin on 2/13/10.
//  Copyright Glosculptor, ISDS 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKStoreManager.h"

@interface InAppPurchasesExampleViewController : UIViewController<MKStoreKitDelegate> {

	UIViewController* feature1ViewController;
	UIViewController* feature2ViewController;
	
	UIView *lockView;
	UIButton* feature1Button;
	UIButton* feature2Button;
	UIButton* seeFeature1Button;
	UIButton* seeFeature2Button;
	UIActivityIndicatorView* indicator;
}

@property (nonatomic, retain) IBOutlet UIButton* feature1Button;
@property (nonatomic, retain) IBOutlet UIButton* feature2Button;
@property (nonatomic, retain) IBOutlet UIButton* seeFeature1Button;
@property (nonatomic, retain) IBOutlet UIButton* seeFeature2Button;
@property (nonatomic, retain) IBOutlet UIView *lockView;
@property (nonatomic, retain) IBOutlet UIViewController* feature1ViewController;
@property (nonatomic, retain) IBOutlet UIViewController* feature2ViewController;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView* indicator;

-(IBAction)feature1ButtonPressed;
-(IBAction)feature2ButtonPressed;

-(IBAction)seeFeature1;
-(IBAction)seeFeature2;

@end

