//
//  leftViewController.h
//  splitViewTest
//
//  Created by kindy_imac on 12-3-15.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface leftViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
	UITableView *_tblView;
}

@end
