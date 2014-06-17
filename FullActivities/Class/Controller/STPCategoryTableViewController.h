//
//  STPCategoryTableViewController.h
//  FullActivities
//
//  Created by Nanook on 17/06/2014.
//  Copyright (c) 2014 SaveThePlan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STPCategoryTableViewController : UITableViewController

@property(retain) NSMutableArray * categoryList;

-(void)setActionWhenUpdate:(id)tar selector:(SEL)sel;

@end
