//
//  STPTableTableViewController.h
//  FullActivities
//
//  Created by Nanook on 15/06/2014.
//  Copyright (c) 2014 SaveThePlan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STPTableTableViewController : UITableViewController <UIActionSheetDelegate, UIAlertViewDelegate>
{
    NSMutableArray * categoryList;
}

@property(assign) BOOL isIpad;

@end
