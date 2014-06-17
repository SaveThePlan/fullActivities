//
//  STPTaskView.m
//  FullActivities
//
//  Created by Nanook on 16/06/2014.
//  Copyright (c) 2014 SaveThePlan. All rights reserved.
//

#import "STPTaskView.h"

@implementation STPTaskView

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
#pragma mark - Birth & Death

- (id)init
{
    self = [super init];
    if (self) {
        
        _titleTextField = [[UITextField alloc] initForAutoLayout];
        [_titleTextField setBackgroundColor:[UIColor lightGrayColor]];
        [self addSubview:_titleTextField];
        [_titleTextField release];
        
        _detailsTextView = [[UITextView alloc] initForAutoLayout];
        [_detailsTextView setBackgroundColor:[UIColor lightGrayColor]];
        [self addSubview:_detailsTextView];
        [_detailsTextView release];
        
        _priorityPicker = [[UIPickerView alloc] initForAutoLayout];
        [self addSubview:_priorityPicker];
        [_priorityPicker release];
        
        _imageView = [[UIImageView alloc] initForAutoLayout];
        [self addSubview:_imageView];
        [_imageView release];
        
        NSDictionary * allViews = NSDictionaryOfVariableBindings(_titleTextField, _detailsTextView, _priorityPicker, _imageView);
        [self addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"H:|-[_imageView(50)]-[_titleTextField]-|"
                              options:NSLayoutFormatDirectionLeadingToTrailing
                              metrics:nil views:allViews]];
        [self addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"H:[_detailsTextView(==_titleTextField)]-|"
                              options:NSLayoutFormatDirectionLeadingToTrailing
                              metrics:nil views:allViews]];
        [self addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"H:|-[_priorityPicker]-|"
                              options:NSLayoutFormatDirectionLeadingToTrailing
                              metrics:nil views:allViews]];
        [self addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"V:|-[_imageView(70)]"
                              options:NSLayoutFormatDirectionLeadingToTrailing
                              metrics:nil views:allViews]];
        [self addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"V:|-[_titleTextField]-[_detailsTextView(50)][_priorityPicker]"
                              options:NSLayoutFormatDirectionLeadingToTrailing
                              metrics:nil views:allViews]];
    }
    return self;
}

-(void)dealloc
{
    [super dealloc];
}


@end
