//
//  STPCategory.m
//  FullActivities
//
//  Created by Nanook on 15/06/2014.
//  Copyright (c) 2014 SaveThePlan. All rights reserved.
//

#import "STPCategory.h"

@interface STPCategory() {
    NSMutableArray * contentTasks;
}

@end


@implementation STPCategory



/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
#pragma mark - Getters & Setters

//taskCount
@synthesize taskCount = _taskCount;
-(int)taskCount
{
    return [contentTasks count];
}

-(void)addTask:(STPTask *)task
{
    [contentTasks addObject:task];
}

-(void)removeTaskAtIndex:(NSUInteger)index
{
    [contentTasks removeObjectAtIndex:index];
}

-(void)insertTask:(STPTask *)task atIndex:(NSUInteger)index
{
    [contentTasks insertObject:task atIndex:index];
}

-(STPTask *)taskAtIndex:(NSUInteger)index
{
    return [contentTasks objectAtIndex:index];
}



/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
#pragma mark - Birth & Death

-(id) init
{
    self = [super init];
    if (self) {
        contentTasks = [[NSMutableArray alloc] init];
    }
    return self;
}

-(id)initWithTitle:(NSString *)title
{
    self = [self init];
    if(self) {
        [self setTitle:title];
    }
    return self;
}

-(void)dealloc
{
    [_title release]; _title = nil;
    [contentTasks release]; contentTasks = nil;
    
    [super dealloc];
}

@end
