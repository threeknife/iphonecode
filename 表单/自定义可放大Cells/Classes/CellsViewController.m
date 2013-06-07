//
//  CellsViewController.m
//  Cells
//
//  Created by nicky on 10-5-20.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "CellsViewController.h"
#import "CustomCell.h"
#import "UIToolBarCell.h"

@implementation CellsViewController

@synthesize computers;
NSIndexPath *selectedCellIndexPath;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
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
	NSDictionary *row1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"MacBook", @"Name", @"White", @"Color", nil];
	NSDictionary *row2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"MacBook Pro", @"Name", @"Silver", @"Color", nil];
	NSDictionary *row3 = [[NSDictionary alloc] initWithObjectsAndKeys:@"iMac", @"Name", @"White", @"Color", nil];
	NSDictionary *row4 = [[NSDictionary alloc] initWithObjectsAndKeys:@"MacBook", @"Name", @"White", @"Color", nil];
	NSDictionary *row5 = [[NSDictionary alloc] initWithObjectsAndKeys:@"MacBook Pro", @"Name", @"Silver", @"Color", nil];
	NSDictionary *row6 = [[NSDictionary alloc] initWithObjectsAndKeys:@"iMac", @"Name", @"White", @"Color", nil];
	NSDictionary *row7 = [[NSDictionary alloc] initWithObjectsAndKeys:@"MacBook", @"Name", @"White", @"Color", nil];
	NSDictionary *row8 = [[NSDictionary alloc] initWithObjectsAndKeys:@"MacBook Pro", @"Name", @"Silver", @"Color", nil];
	NSDictionary *row9 = [[NSDictionary alloc] initWithObjectsAndKeys:@"iMac", @"Name", @"White", @"Color", nil];
	NSDictionary *row10 = [[NSDictionary alloc] initWithObjectsAndKeys:@"MacBook", @"Name", @"White", @"Color", nil];
	NSDictionary *row11 = [[NSDictionary alloc] initWithObjectsAndKeys:@"MacBook Pro", @"Name", @"Silver", @"Color", nil];
	NSDictionary *row12 = [[NSDictionary alloc] initWithObjectsAndKeys:@"iMac", @"Name", @"White", @"Color", nil];
	
	
	
	NSArray *array = [[NSArray alloc] initWithObjects:row1, row2, row3, row4, row5, row6, row7, row8, row9, row10, row11, row12, nil];
	self.computers = array;
	
	
	[row1 release];
	[row2 release];
	[row3 release];
	[row4 release];
	[row5 release];
	[row6 release];
	[row7 release];
	[row8 release];
	[row9 release];
	[row10 release];
	[row11 release];
	[row12 release];
	[array release];
    [super viewDidLoad];
}




// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)dealloc {
    [super dealloc];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.computers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CustomCellIdentifier = @"CustomCellIdentifier";
	
	UIToolBarCell *cell = (UIToolBarCell *)[tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
	if (cell == nil) {
		cell = [[UIToolBarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CustomCellIdentifier];
	}
	NSUInteger row = [indexPath row];
	NSDictionary *rowData = [self.computers objectAtIndex:row];

	cell.textLabel.text = [rowData objectForKey:@"Name"];
	
	// set cell expand view information
	cell.backgroundName = @"bluebg.png";
	cell.cellCollapseHeight = kTableViewCollapseRowHeight;
	cell.cellExpandHeight = kTableViewExpandRowHeight;

	UIButton* button1 = [UIButton buttonWithType:UIButtonTypeCustom];
	[button1 setBackgroundImage:[UIImage imageNamed:@"facebook_icon.png"] forState:UIControlStateNormal];
	[button1 sizeToFit];
	
	UIButton* button2 = [UIButton buttonWithType:UIButtonTypeCustom];
	[button2 setBackgroundImage:[UIImage imageNamed:@"footer-twitter.png"] forState:UIControlStateNormal];
	[button2 sizeToFit];
	
	NSMutableArray* array = [NSMutableArray arrayWithObjects:button1, button2, nil];
	cell.buttonList = array;
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	selectedCellIndexPath = indexPath;  
	[tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];  
	[tableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionNone animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if(selectedCellIndexPath != nil && [selectedCellIndexPath compare:indexPath] == NSOrderedSame)  
		return kTableViewExpandRowHeight;
	else return kTableViewCollapseRowHeight;  
}


@end
