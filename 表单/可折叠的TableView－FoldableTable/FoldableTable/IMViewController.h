//
//  IMViewController.h
//  FoldableTable
//
//  Created by huogh on 12-12-26.
//  Copyright (c) 2012年 infomedia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IMViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    UITableView         *_tableView;
    NSMutableArray      *_dataArray;
    
}
@end
