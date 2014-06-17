//
//  STPTaskViewController.m
//  FullActivities
//
//  Created by Nanook on 16/06/2014.
//  Copyright (c) 2014 SaveThePlan. All rights reserved.
//

#import <MobileCoreServices/MobileCoreServices.h>
#import "STPTaskViewController.h"
#import "STPTaskView.h"

@interface STPTaskViewController () {
    STPTaskView * taskView;
    UIImagePickerController * imagePickerController;
    UIPopoverController * popover;
    id target;
    SEL action;
}

@end

@implementation STPTaskViewController



/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
#pragma mark - Birth & Death

-(id)initWithTask:(STPTask *)task
{
    self = [self init];
    if(self) {
        [self setTask:task];
    }
    return self;
}

-(void)dealloc
{
    [_task release]; _task = nil;
    [imagePickerController release]; imagePickerController = nil;
    [popover release]; popover = nil;
    
    [super dealloc];
}

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // view setup
    taskView = [[STPTaskView alloc] initForAutoLayout];
    [[self view] addSubview:taskView];
    [taskView release];
    
    id topGuide = [self topLayoutGuide];
    
    NSDictionary * allViews = NSDictionaryOfVariableBindings(taskView, topGuide);
    [[self view] addConstraints:[NSLayoutConstraint
                                 constraintsWithVisualFormat:@"H:|[taskView]|"
                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                 metrics:nil views:allViews]];
    [[self view] addConstraints:[NSLayoutConstraint
                                 constraintsWithVisualFormat:@"V:[topGuide][taskView]|"
                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                 metrics:nil views:allViews]];
    
    [[self view] setBackgroundColor:[UIColor whiteColor]];
    [[self view] setFrame:[[UIScreen mainScreen] bounds]];
    
    
    //configuring editing
    [[taskView titleTextField] setDelegate:self];
    [[taskView detailsTextView]setDelegate:self];
    [[taskView priorityPicker] setDataSource:self];
    [[taskView priorityPicker] setDelegate:self];
    
    //add content
    [[taskView titleTextField] setText:[_task title]];
    [[taskView detailsTextView] setText:[_task details]];
    [[taskView priorityPicker] selectRow:[_task priority] inComponent:0 animated:YES];
    [[taskView imageView] setImage:[_task image]];

    
    //nav bar
    [[self navigationItem] setTitle:@"Tâche"];
    [[self navigationItem] setRightBarButtonItem:[[UIBarButtonItem alloc]
                                                  initWithBarButtonSystemItem:UIBarButtonSystemItemCamera
                                                  target:self action:@selector(onAddPictureButtonClick:)]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated {
    //update Task Model
    [_task setTitle:[[taskView titleTextField] text]];
    [_task setDetails:[[taskView detailsTextView] text]];
    
    [target performSelector:action];
    
    [super viewWillDisappear:animated];
}


/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
#pragma mark - Actions

-(void)setActionWhenUpdate:(id)tar selector:(SEL)sel
{
    target = tar;
    action = sel;
}

-(void)onAddPictureButtonClick:(id)sender
{
    if(!imagePickerController) {
        imagePickerController = [[UIImagePickerController alloc] init];
        [imagePickerController setDelegate:self];
    }
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
        NSArray * mediaTypes = [UIImagePickerController
                                availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        [imagePickerController setMediaTypes:mediaTypes];
    } else {
        [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    
    if(_isIpad){
        [popover release];
        popover = [[UIPopoverController alloc]
                                          initWithContentViewController:imagePickerController];
        [popover setDelegate:self];//nothing implemented
        [popover presentPopoverFromBarButtonItem:[[self navigationItem] rightBarButtonItem]
                        permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    } else {
        [[[[self view] window] rootViewController] presentViewController:imagePickerController animated:YES completion:nil];
    }
}


/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
#pragma mark - Protocole : UITextFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }
    
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField setBackgroundColor:[UIColor whiteColor]];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField setBackgroundColor:[UIColor lightGrayColor]];
}



/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
#pragma mark - Protocole : UITextViewDelegate

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return YES;
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    return YES;
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [textView setBackgroundColor:[UIColor whiteColor]];
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    [textView setBackgroundColor:[UIColor lightGrayColor]];
}



/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
#pragma mark - Protocole : UIPickerViewDataSource

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 4;
}




/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
#pragma mark - Protocole : UIPickerViewDelegate

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    if(!view) {
        view = [[UILabel alloc] init];
        [(UILabel *)view setTextAlignment:NSTextAlignmentCenter];
        [(UILabel *)view setFont:[UIFont systemFontOfSize:14.0]];
    }
    
    switch (row) {
        case STPTaskPriorityLow:
            [(UILabel *) view setText:@"Priorité faible"];
            break;
            
        case STPTaskPriorityNormal:
            [(UILabel *) view setText:@"Priorité normale"];
            break;
            
        case STPTaskPriorityHigh:
            [(UILabel *) view setText:@"Priorité haute"];
            break;
            
        case STPTaskPriorityDone:
        default:
            [(UILabel *) view setText:@"Tâche effectuée"];
            break;
    }
    
    return [view autorelease];
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 18.0;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [_task setPriority:row];
}



/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
#pragma mark - Protocole : UIImagePickerControllerDelegate

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [imagePickerController dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [imagePickerController dismissViewControllerAnimated:YES completion:nil];
    
    NSString * mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    //only photo
    if(CFStringCompare((CFStringRef)mediaType, kUTTypeImage, 0) == kCFCompareEqualTo) {

        UIImage * img = [info objectForKey:UIImagePickerControllerEditedImage];
        
        if(!img){
            img = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        
        [[taskView imageView] setImage:img];
        [_task setImage:img];
        
    } else {
        //bad type : movie...
        [[[[UIAlertView alloc]
          initWithTitle:@"Erreur"
          message:@"Vous avez sélectionné un film"
          delegate:nil
          cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease] show];
    }

    
}



@end
