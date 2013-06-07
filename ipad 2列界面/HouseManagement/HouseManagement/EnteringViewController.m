//
//  EnteringViewController.m
//  HouseManagement
//
//  Created by  on 12-5-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#import "EnteringViewController.h"
#import "AppDelegate.h"
#import "WebData.h"
@interface EnteringViewController ()

@end

@implementation EnteringViewController
@synthesize userName;
@synthesize userPassword;
@synthesize userRemembered;
@synthesize currentPopView;
@synthesize context;
@synthesize rememberPassword;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
  
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
// 支持横屏
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft)||(interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}
#pragma mark resignFirstResponse
-(IBAction)resign:(id)sender
{
    [userName resignFirstResponder];
    [userPassword resignFirstResponder];
}
#pragma mark popViewDelegate
-(void)handleDismissedPopViewController:(UIPopoverController*)pop
{
    if ([pop.contentViewController isMemberOfClass:[UserTableView class]]) {
        UserTableView*newTable=(UserTableView*)currentPopView.contentViewController;
        if (newTable.selectUser==nil) {
            self.currentPopView=nil;
            return;
        }

        self.userName.text=newTable.selectUser;
        if (newTable.selectPassword!=nil) {
        self.userPassword.text=newTable.selectPassword;
        }
    }
    self.currentPopView=nil;
}
-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    [self handleDismissedPopViewController:popoverController];
}
-(IBAction)popUserList:(id)sender
{
    UserTableView*table=[[UserTableView alloc] initWithStyle:UITableViewStylePlain];
    if (![userName.text isEqualToString:@""]) {
        table.selectUser=[userName text];
        table.selectPassword=[userPassword text];
    }
    [self setUpNewPopoverControllerForViewController:table];
    table.userPop=self.currentPopView;
    CGSize size=CGSizeMake(300, 100);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidSelect:) name:@"UserPick" object:table];
    self.currentPopView.popoverContentSize=size;
    [self.currentPopView presentPopoverFromRect:CGRectMake(500, 250, 100, 100) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}
-(void)setUpNewPopoverControllerForViewController:(id)sender
{
    if (self.currentPopView) {
        [self.currentPopView dismissPopoverAnimated:YES];
        [self handleDismissedPopViewController:self.currentPopView];
    }
    self.currentPopView=[[UIPopoverController alloc] initWithContentViewController:sender];
    self.currentPopView.delegate=self;
}

-(void)userDidSelect:(NSNotification*)noti
{
    UserTableView*table=[noti object];
    UIPopoverController*popoverController=table.userPop;
    [popoverController dismissPopoverAnimated:YES];
    [self handleDismissedPopViewController:popoverController];
    self.currentPopView=nil;
}
#pragma mark sava data
-(void)saveData
{
    AppDelegate*appDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    //data Testing
    User*addUser=(User*)[NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:appDelegate.managedObjectContext];
    if ((![userName.text isEqualToString:@""])&&(![userPassword.text isEqualToString:@""] )) {
    addUser.name=[userName text];
    addUser.password=[userPassword text];
    [appDelegate saveContext];
    }
}
-(IBAction)enter:(id)sender
{
    WebData*webData=[[WebData alloc] init];
    if ([webData accessIntoDataBase:[userName text] password:[userPassword text]]) {
    if (rememberPassword.isOn) {
        AppDelegate*appDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
        NSManagedObjectContext*manageContext=appDelegate.managedObjectContext;
        NSFetchRequest*request=[[NSFetchRequest alloc] init];
        NSEntityDescription*entity=[NSEntityDescription entityForName:@"User" inManagedObjectContext:manageContext];
        [request setEntity:entity];
        NSSortDescriptor*sortDescriptor=[[NSSortDescriptor alloc] initWithKey:@"name" ascending:NO];
        NSArray*sortArray=[[NSArray alloc] initWithObjects:sortDescriptor, nil];
        [request setSortDescriptors:sortArray];
        NSError*error;
        NSMutableArray*result=[[manageContext executeFetchRequest:request error:&error] mutableCopy];
        BOOL newOne=YES;
        for (int i=0; i<[result count]; i++) {
            User*user=[result objectAtIndex:i];
            if ([userName.text isEqualToString:user.name]) {
                newOne=NO;
                NSLog(@"not New ONE");
            }
        }
            if (newOne==YES)
            {
                [self saveData];
            }
        }
    [self performSegueWithIdentifier:@"main" sender:self];
    }
    
}
@end

