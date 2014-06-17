//
//  STPMainViewController.m
//  FullActivities
//
//  Created by Nanook on 15/06/2014.
//  Copyright (c) 2014 SaveThePlan. All rights reserved.
//

#import "STPMainViewController.h"
#import "STPTableTableViewController.h"

@interface STPMainViewController () {
    STPTableTableViewController * tableViewController;
    UINavigationController * navViewController;
}

@end

@implementation STPMainViewController


/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
#pragma mark - Birth & Death

-(void)dealloc
{
    [tableViewController release]; tableViewController = nil;
    [navViewController release]; navViewController = nil;
    
    [super dealloc];
}

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    tableViewController = [[STPTableTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [tableViewController setIsIpad:_isIpad];
    
    navViewController = [[UINavigationController alloc] initWithRootViewController:tableViewController];
    
    [[self view] addSubview:[navViewController view]];
    
    [[self view] setFrame:[[UIScreen mainScreen] bounds]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
