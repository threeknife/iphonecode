//
//  CellsViewController.h
//  Cells
//
//  Created by nicky on 10-5-20.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kTableViewCollapseRowHeight 66
#define kTableViewExpandRowHeight 110

@interface CellsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	NSArray *computers;
}

@property (nonatomic, retain) NSArray *computers;

@end

