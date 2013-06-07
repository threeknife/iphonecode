    //
//  leftViewController.m
//  splitViewTest
//
//  Created by kindy_imac on 12-3-15.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "leftViewController.h"
#import "otherViewController.h"


@implementation leftViewController

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	_tblView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320 , 460) style:UITableViewStylePlain];
	_tblView.delegate = self;
	_tblView.dataSource = self;
	_tblView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	_tblView.separatorColor = [UIColor clearColor];
	_tblView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"menu-background.png"]];
	[self.view addSubview:_tblView];
}



#pragma mark -
#pragma mark  uitableview datasource methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *identifier = @"cell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	
	if(cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:identifier] autorelease];
		
		[cell.contentView addSubview:[LLLineView viewWithFrame:CGRectMake(0, 0, 320, 1) backgroundColor:[UIColor colorWithWhite:0.9 alpha:0.1]]];
		[cell.contentView addSubview:[LLLineView grayLineView:CGRectMake(0, 43, 320, 1)]];
		
		cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gray-cell-highlight.png"]];
	}
	
	cell.backgroundView.backgroundColor = [UIColor clearColor];
	cell.backgroundColor = [UIColor clearColor];
	cell.contentView.backgroundColor = [UIColor clearColor];
	//cell.textLabel.textColor = [UIColor whiteColor];
	//cell.textLabel.font = [UIFont	boldSystemFontOfSize:16];
	//cell.textLabel.text = @"酒店管家";
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

	otherViewController *lvc = [[otherViewController alloc] init];
	[theApp.viewController showViewController:lvc animated:YES];
	[lvc release];
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
