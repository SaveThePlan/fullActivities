//
//  STPTaskViewController.h
//  FullActivities
//
//  Created by Nanook on 16/06/2014.
//  Copyright (c) 2014 SaveThePlan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STPTask.h"

@interface STPTaskViewController : UIViewController <
                UITextFieldDelegate, UITextViewDelegate,
                UIPickerViewDataSource, UIPickerViewDelegate,
                UINavigationControllerDelegate,UIImagePickerControllerDelegate,
                UIPopoverControllerDelegate
                >

@property(assign) BOOL isIpad;

@property(retain) STPTask * task;

-(id)initWithTask:(STPTask *)task;

-(void)setActionWhenUpdate:(id)tar selector:(SEL)sel;

@end
