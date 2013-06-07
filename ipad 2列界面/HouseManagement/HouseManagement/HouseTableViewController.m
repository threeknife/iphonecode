//
//  HouseTableViewController.m
//  HouseManagement
//
//  Created by  on 12-5-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HouseTableViewController.h"
#import "HouseCell.h"

@interface HouseTableViewController ()
@property(nonatomic,strong)NSMutableArray*DataArray;
@end

@implementation HouseTableViewController
@synthesize houseArray;
@synthesize mainViewController;
@synthesize edit;
@synthesize showListBar;
@synthesize searchBar;
@synthesize add;
@synthesize search;
@synthesize DataArray;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //close noti
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeSelf:) name:@"HouseTableViewDismiss" object:nil];
    Editing=NO;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft)||(interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}
#pragma mark BarItem Action
-(IBAction)edit:(id)sender
{
    [searchBar resignFirstResponder];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowDetailViewDismiss" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EditHouseViewDismiss" object:nil];
    if (Editing==NO) {
        Editing=YES;
        edit.title=@"取消编辑";
    }
else {
    Editing=NO;
    edit.title=@"编辑";
}
}
-(IBAction)addNewHouse:(id)sender
{
    [searchBar resignFirstResponder];
    [mainViewController showEditHouseVIew:nil];
    [self.view removeFromSuperview];
}
-(IBAction)ShowSearchBar:(id)sender
{
    if ((searchBar.text==nil)||([searchBar.text isEqualToString:@""])) {
        [houseArray removeAllObjects];
        for (id new in DataArray) {
            [houseArray addObject:[new copy]];
        }
        NSLog(@"count %d",[DataArray count]);
    }
    else {
        for (int i=0;i<[houseArray count];i++) {
            NSMutableDictionary*dic=[houseArray objectAtIndex:i];
        if ([[dic objectForKey:@"houseNumber"] rangeOfString:searchBar.text].length>0) {
           continue;
        }
        if ([[dic objectForKey:@"uptown"] rangeOfString:searchBar.text].length>0) {
            continue;
        }
    if ([[[dic objectForKey:@"ttarea"] stringValue] rangeOfString:searchBar.text].length>0) {
        continue;
    }
        if ([[dic objectForKey:@"transaction"] isEqualToString:@"出售"]) {
            if ([[[dic objectForKey:@"salePrice"] stringValue] rangeOfString:searchBar.text].length>0) {
                continue;
            }
        }
        else {
            if ([[[dic objectForKey:@"rentPrice"] stringValue] rangeOfString:searchBar.text].length>0) {
                continue;
            }
        }
        [houseArray removeObjectAtIndex:i];
    }
    }
    [self.tableView reloadData];
}
-(IBAction)rangeList:(id)sender
{
    UIButton*button=(UIButton*)sender;
    if(button.tag==1)
    {
        for (int i=0; i<[houseArray count] ; i++) {
            for (int x=i+1; x<[houseArray count]; x++) {
                if ([[[houseArray objectAtIndex:i] objectForKey:@"transaction"] isEqualToString:@"出售"]) {
                    float Ivalue=[[[houseArray objectAtIndex:i] objectForKey:@"salePrice"] floatValue];
                    float Xvalue=[[[houseArray objectAtIndex:x] objectForKey:@"salePrice"] floatValue];
                    if (Ivalue>Xvalue) {
                        id temp=[houseArray objectAtIndex:x];
                        [houseArray replaceObjectAtIndex:x withObject:[houseArray objectAtIndex:i]];
                        [houseArray replaceObjectAtIndex:i withObject:temp];
                    }
                }else {
                    float Ivalue=[[[houseArray objectAtIndex:i] objectForKey:@"rentPrice"] floatValue];
                    float Xvalue=[[[houseArray objectAtIndex:x] objectForKey:@"rentPrice"] floatValue];
                    if (Ivalue>Xvalue) {
                        id temp=[houseArray objectAtIndex:x];
                        [houseArray replaceObjectAtIndex:x withObject:[houseArray objectAtIndex:i]];
                        [houseArray replaceObjectAtIndex:i withObject:temp];
                    }
                }
            }
        }
        houseArray=[self selfStatusSet:houseArray];
        [self.tableView reloadData];
        showListBar.title=@"以价格排列";
        button.tag=2;
    }
    else if(button.tag==2)
    {
        for (int i=0; i<[houseArray count] ; i++) {
            for (int x=i+1; x<[houseArray count]; x++) {
        float Ivalue=[[[houseArray objectAtIndex:i] objectForKey:@"ttarea"] floatValue];
        float Xvalue=[[[houseArray objectAtIndex:x] objectForKey:@"ttarea"] floatValue];
        if (Ivalue>Xvalue) {
            id temp=[houseArray objectAtIndex:x];
            [houseArray replaceObjectAtIndex:x withObject:[houseArray objectAtIndex:i]];
            [houseArray replaceObjectAtIndex:i withObject:temp];
            }
        }
        }
        houseArray=[self selfStatusSet:houseArray];
        [self.tableView reloadData];
        showListBar.title=@"以面积排列";
       
        button.tag=3;
    }
    else if(button.tag==3)
    {
        for (int i=0; i<[houseArray count] ; i++) {
            for (int x=i+1; x<[houseArray count]; x++) {
                if ([[[houseArray objectAtIndex:i] objectForKey:@"transaction"] isEqualToString:@"出售"]) {
                    float Ivalue=[[[houseArray objectAtIndex:i] objectForKey:@"salePrice"] floatValue]/[[[houseArray objectAtIndex:i] objectForKey:@"ttarea"] floatValue];
                    float Xvalue=[[[houseArray objectAtIndex:x] objectForKey:@"salePrice"] floatValue]/[[[houseArray objectAtIndex:x] objectForKey:@"ttarea"] floatValue];
                    if (Ivalue>Xvalue) {
                        id temp=[houseArray objectAtIndex:x];
                        [houseArray replaceObjectAtIndex:x withObject:[houseArray objectAtIndex:i]];
                        [houseArray replaceObjectAtIndex:i withObject:temp];
                    }
                }else {
                    float Ivalue=[[[houseArray objectAtIndex:i] objectForKey:@"rentPrice"] floatValue]/[[[houseArray objectAtIndex:i] objectForKey:@"ttarea"] floatValue];
                    float Xvalue=[[[houseArray objectAtIndex:x] objectForKey:@"rentPrice"] floatValue]/[[[houseArray objectAtIndex:x] objectForKey:@"ttarea"] floatValue];
                    if (Ivalue>Xvalue) {
                        id temp=[houseArray objectAtIndex:x];
                        [houseArray replaceObjectAtIndex:x withObject:[houseArray objectAtIndex:i]];
                        [houseArray replaceObjectAtIndex:i withObject:temp];
                    }
                }
            }
        }
        houseArray=[self selfStatusSet:houseArray];
        [self.tableView reloadData];
         showListBar.title=@"以单价排列";
        button.tag=1;
    }
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [houseArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"HouseCell";
    HouseCell*cell =(HouseCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        NSArray*nib=[[NSBundle mainBundle] loadNibNamed:@"HouseCell" owner:self options:nil];
        for (id oneObject in nib) {
            if ([oneObject isKindOfClass:[HouseCell class]]) {
                cell=(HouseCell*)oneObject;
            }
        }
    }
    NSDictionary*dic=[houseArray objectAtIndex:indexPath.row];  
    cell.houseNumber.text=[dic objectForKey:@"houseNumber"];
    cell.uptown.text=[dic objectForKey:@"uptown"];
    if ([[dic objectForKey:@"transaction"] isEqualToString:@"出售"]) {
    cell.price.text=@"万元";
    cell.salePrice.text=[[dic objectForKey:@"salePrice"] stringValue];
    }
    else {
        cell.price.text=@"元/月";
        cell.salePrice.text=[[dic objectForKey:@"rentPrice"] stringValue];
    }
    cell.floor.text=[dic objectForKey:@"floor"];
    cell.ttarea.text=[[dic objectForKey:@"ttarea"] stringValue];
    cell.address.text=[dic objectForKey:@"address"];
    float per=[cell.salePrice.text floatValue]/[cell.ttarea.text floatValue];
    per=round( per * 100.0 ) / 100.0;
    cell.perPrice.text=[NSString stringWithFormat:@"%.2f",per];
    return cell;
}
/*-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"did did   DeselectRowAtIndexPath%d",indexPath.row);
}*/
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [searchBar resignFirstResponder];
    if (!Editing) {
        if ([houseArray count]>0) 
        {
            [mainViewController showDetailView:[houseArray objectAtIndex:indexPath.row]];
        }
    }
    else {
        if ([houseArray count]>0) {
            [mainViewController showEditHouseVIew:[houseArray objectAtIndex:indexPath.row]];
        }
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 92.0;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark close noti
-(void)closeSelf:(NSNotification*)noti
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowDetailViewDismiss" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EditHouseViewDismiss" object:nil];
    [self.view removeFromSuperview];
}

-(NSMutableArray*)selfStatusSet:(NSMutableArray*)data
{
    NSMutableArray*array=[[NSMutableArray alloc] init];
    for (int i=0; i<[data count]; i++) {
        NSString*string=[[data objectAtIndex:i] objectForKey:@"status"];
        if (([string isEqualToString:@"已售"])||([string isEqualToString:@"已租"])) {
            [array addObject:[data objectAtIndex:i]];
            [data removeObjectAtIndex:i];
        }
    }
    for (int i=0; i<[array count]; i++) {
        [data addObject:[array objectAtIndex:i]];
    }
    return data;
}
-(void)selfReset
{
    if (DataArray==nil) {
        DataArray=[[NSMutableArray alloc] init];
    }
    for (NSMutableDictionary*object in houseArray) {
        id newObject=[object copy];
        [DataArray addObject:newObject];
    }
}
@end
