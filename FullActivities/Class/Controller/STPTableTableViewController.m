//
//  STPTableTableViewController.m
//  FullActivities
//
//  Created by Nanook on 15/06/2014.
//  Copyright (c) 2014 SaveThePlan. All rights reserved.
//

#import "STPTableTableViewController.h"
#import "STPCategory.h"
#import "STPTaskViewController.h"
#import "STPCategoryTableViewController.h"

#import "UIImage+STPImageResize.h"
#import "UIView+STPViewForAutoLayout.h"

@interface STPTableTableViewController () {
    UIActionSheet * categorySelectorActionSheet;
    UIAlertView * newCategoryAlert;
}

@end

@implementation STPTableTableViewController



/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
#pragma mark - Birth & Death

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        categoryList = [[NSMutableArray alloc] init];
        
        [categoryList addObject:[[STPCategory alloc] initWithTitle:@"Personnel"]];
        [categoryList addObject:[[STPCategory alloc] initWithTitle:@"Professionel"]];

        [[self tableView] setSectionFooterHeight:0];
        [[self tableView] setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        
        [self loadNewCategoryAlert];
    }
    return self;
}

- (void)dealloc
{
    [categoryList release]; categoryList = nil;
    [categorySelectorActionSheet release]; categorySelectorActionSheet = nil;
    [newCategoryAlert release]; newCategoryAlert = nil;

    [super dealloc];
}


/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    [[self navigationItem] setTitle:@"Activités"];
    [[self navigationItem] setLeftBarButtonItem:[self editButtonItem]];
    [[self navigationItem] setRightBarButtonItems:[NSArray arrayWithObjects:
                                                   [[[UIBarButtonItem alloc]
                                                    initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                    target:self action:@selector(onAddTaskButtonClick:)] autorelease],
                                                   [[[UIBarButtonItem alloc]
                                                    initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize
                                                    target:self action:@selector(onOrganizeButtonClick:)] autorelease],
                                                   nil]
                                         animated:YES];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
#pragma mark - Actions

-(void)onAddTaskButtonClick:(id)sender
{
    [self loadCategorySelectorActionSheet];
    
    [categorySelectorActionSheet showFromBarButtonItem:[[self navigationItem] rightBarButtonItem] animated:YES];
}

-(void)onOrganizeButtonClick:(id)sender
{
    STPCategoryTableViewController * orgTable = [[STPCategoryTableViewController alloc] initWithStyle:UITableViewStylePlain];
    [orgTable setCategoryList:categoryList];
    [orgTable setActionWhenUpdate:[self tableView] selector:@selector(reloadData)];
    
    [[self navigationController] pushViewController:orgTable animated:YES];
}

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [categoryList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [(STPCategory *)[categoryList objectAtIndex:section] taskCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    static NSString * cellId;
    
    //data to display
    STPTask * task = [(STPCategory *)[categoryList objectAtIndex:[indexPath section]] taskAtIndex:[indexPath row]];

    switch ([task priority]) {
        case STPTaskPriorityDone:
            cellId = @"cellDone";
            break;
            
        case STPTaskPriorityLow:
            cellId = @"cellPrioLow";
            break;
            
        case STPTaskPriorityHigh:
            cellId = @"cellPrioHigh";
            break;
            
        case STPTaskPriorityNormal:
        default:
            cellId = @"cellPrioNormal";
            break;
    }
    
    cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellId];
        [[cell imageView] setImage:[UIImage imageResizeWithName:[NSString stringWithFormat:@"priority%dx32", [task priority]]
                                                        andType:@"png" andHeight:24.0]];
    }
    
    [[cell textLabel] setText:[task title]];
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [(STPCategory *)[categoryList objectAtIndex:section] title];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [(STPCategory *)[categoryList objectAtIndex:[indexPath section]] removeTaskAtIndex:[indexPath row]];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    STPTask * taskToMove = [[(STPCategory *)[categoryList objectAtIndex:[fromIndexPath section]]
                            taskAtIndex:[fromIndexPath row]] retain];
    
    [(STPCategory *)[categoryList objectAtIndex:[fromIndexPath section]] removeTaskAtIndex:[fromIndexPath row]];
    
    [(STPCategory *)[categoryList objectAtIndex:[toIndexPath section]] insertTask:taskToMove atIndex:[toIndexPath row]];
    
    [taskToMove release];
    
    [tableView reloadData];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [tableView bounds].size.width, 40.0)];
    
    UILabel * titleLabel = [[UILabel alloc] initForAutoLayout];
    [titleLabel setText:[(STPCategory*)[categoryList objectAtIndex:section] title]];
    [titleLabel setTextAlignment:NSTextAlignmentLeft];
    
    [headerView addSubview:titleLabel];
    [titleLabel release];
    
    NSDictionary * headerViews = NSDictionaryOfVariableBindings(headerView, titleLabel);
    [headerView addConstraints:[NSLayoutConstraint
                                constraintsWithVisualFormat:@"H:|-[titleLabel]"
                                options:NSLayoutFormatDirectionLeadingToTrailing
                                metrics:nil views:headerViews]];
    [headerView addConstraint:[NSLayoutConstraint
                               constraintWithItem:titleLabel attribute:NSLayoutAttributeCenterY
                               relatedBy:NSLayoutRelationEqual
                               toItem:headerView attribute:NSLayoutAttributeCenterY
                               multiplier:1.0 constant:0]];
    
    return headerView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    STPTask * task = [(STPCategory *)[categoryList objectAtIndex:[indexPath section]]
                      taskAtIndex:[indexPath row]];
    
    STPTaskViewController * taskDetails = [[STPTaskViewController alloc] initWithTask:task];
    [taskDetails setActionWhenUpdate:[self tableView] selector:@selector(reloadData)];
    [taskDetails setIsIpad:_isIpad];
    
    [[self navigationController] pushViewController:taskDetails animated:YES];
    [taskDetails release];
}


/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
#pragma mark - Protocole : UIActionSheetDelegate

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex < [categoryList count]) {
        //select Category and add Task
        STPCategory * selectedCat = (STPCategory *)[categoryList objectAtIndex:buttonIndex];
        [selectedCat addTask:[[STPTask alloc] initWithTitle:@"New Task"]];
        [[self tableView] reloadData];
    }
    
    if(buttonIndex == [categoryList count]) {
        //create new Category
        [newCategoryAlert show];
    }
}




/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
#pragma mark - Protocole : UIAlertViewDelegate

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSString * input = [[newCategoryAlert textFieldAtIndex:0] text];
    
    if(![input isEqualToString:@""]) {
        [categoryList addObject:[[STPCategory alloc] initWithTitle:input]];
        [[self tableView] reloadData];
    }
    
    [[newCategoryAlert textFieldAtIndex:0] setText:@""];
}



/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
#pragma mark - Privates methods

-(void)loadCategorySelectorActionSheet
{
    [categorySelectorActionSheet release];
    
    categorySelectorActionSheet = [[UIActionSheet alloc] initWithTitle:@"Sélection de la catégorie"
                                                              delegate:self
                                                     cancelButtonTitle:nil
                                                destructiveButtonTitle:nil
                                                     otherButtonTitles:nil];
    int i;
    for (i = 0; i < [categoryList count]; i++) {
        [categorySelectorActionSheet addButtonWithTitle:[(STPCategory *)[categoryList objectAtIndex:i] title]];
    }
    
    [categorySelectorActionSheet addButtonWithTitle:@"Nouvelle catégorie"];
    [categorySelectorActionSheet setDestructiveButtonIndex:i];
    
    [categorySelectorActionSheet addButtonWithTitle:@"Annuler"];
    [categorySelectorActionSheet setCancelButtonIndex:(i + 1)];
}

-(void)loadNewCategoryAlert
{
    newCategoryAlert = [[UIAlertView alloc] initWithTitle:@"Nouvelle Catégorie"
                                                  message:@"Saisissez le titre de la catégorie"
                                                 delegate:self cancelButtonTitle:@"Annuler" otherButtonTitles:@"OK", nil];
    [newCategoryAlert setAlertViewStyle:UIAlertViewStylePlainTextInput];
}


@end
