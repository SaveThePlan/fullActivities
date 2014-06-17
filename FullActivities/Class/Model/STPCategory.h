//
//  STPCategory.h
//  FullActivities
//
//  Created by Nanook on 15/06/2014.
//  Copyright (c) 2014 SaveThePlan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STPTask.h"

@interface STPCategory : NSObject

@property(copy, nonatomic) NSString * title;
@property(assign, nonatomic) int taskCount;


/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
#pragma mark - Getters & Setters

-(void)addTask:(STPTask *)task;
-(void)removeTaskAtIndex:(NSUInteger)index;
-(void)insertTask:(STPTask *)task atIndex:(NSUInteger)index;
-(STPTask *)taskAtIndex:(NSUInteger)index;



/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
#pragma mark - Birth & Death

-(id)initWithTitle:(NSString *)title;


@end
