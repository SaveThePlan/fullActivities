//
//  STPTask.h
//  FullActivities
//
//  Created by Nanook on 15/06/2014.
//  Copyright (c) 2014 SaveThePlan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    STPTaskPriorityDone = 0,
    STPTaskPriorityLow,
    STPTaskPriorityNormal,
    STPTaskPriorityHigh,
} STPTaskPriority;

@interface STPTask : NSObject

@property(copy, nonatomic) NSString * title;
@property(copy, nonatomic) NSString * details;
@property(assign) STPTaskPriority priority;
@property(copy, nonatomic) UIImage * image;


/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
#pragma mark - Birth & Death

-(id)initWithTitle:(NSString *)title;

@end
