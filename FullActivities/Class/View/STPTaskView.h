//
//  STPTaskView.h
//  FullActivities
//
//  Created by Nanook on 16/06/2014.
//  Copyright (c) 2014 SaveThePlan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+STPViewForAutoLayout.h"

@interface STPTaskView : UIView

@property(readonly) UITextField * titleTextField;
@property(readonly) UITextView * detailsTextView;
@property(readonly) UIPickerView * priorityPicker;
@property(readonly) UIImageView * imageView;

@end
