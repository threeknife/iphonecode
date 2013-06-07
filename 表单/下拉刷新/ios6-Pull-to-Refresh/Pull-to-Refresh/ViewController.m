//
//  ViewController.m
//  Pull-to-Refresh
//
//  Created by iDebug on 12-11-8.
//
//

#import "ViewController.h"
#import "Pull-to-RefreshViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIButton *refreshBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    refreshBtn.frame = CGRectMake(10, 120, 300, 40);
    [refreshBtn setTitle:@"Pull-to-Refresh" forState:UIControlStateNormal];
    [refreshBtn addTarget:self action:@selector(refreshClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:refreshBtn];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)refreshClick:(id)sender
{
    Pull_to_RefreshViewController *refreshViewController = [[Pull_to_RefreshViewController alloc] init];
    refreshViewController.title = @"Pull_to_Refresh";
    [self.navigationController pushViewController:refreshViewController animated:YES];
    [refreshViewController release];
}

@end
