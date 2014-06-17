//
//  STPTask.m
//  FullActivities
//
//  Created by Nanook on 15/06/2014.
//  Copyright (c) 2014 SaveThePlan. All rights reserved.
//

#import "STPTask.h"

@implementation STPTask



/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
#pragma mark - Birth & Death

-(id)initWithTitle:(NSString *)title
{
    self = [self init];
    if (self) {
        [self setTitle:title];
        [self setPriority:STPTaskPriorityNormal];
    }
    return self;
}

-(void)dealloc
{
    [_title release]; _title = nil;
    [_details release]; _details = nil;
    [_image release]; _image = nil;
    
    [super dealloc];
}

@end
