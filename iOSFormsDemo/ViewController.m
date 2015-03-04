//
//  ViewController.m
//  DequeApp
//
//  Created by Alistair Barrell on 2/27/15.
//  Copyright (c) 2015. All rights reserved.
//
#import "regex.h"
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dateField.delegate = self;
    _nameField.delegate = self;
    _emailField.delegate = self;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitButton:(id)sender {
    //Get input from text fields
    NSString *emailFieldString = [_emailField text];
    NSString *nameFieldString = [_nameField text];
    NSString *dateFieldString = [_dateField text];
    
    //Set up predicates to verify validity of text box input
    NSPredicate *namePredicate = [NSPredicate
                                  predicateWithFormat:@"SELF MATCHES '[A-Za-z0-9]+'"];
    
    NSPredicate *emailPredicate = [NSPredicate
                               predicateWithFormat:
                               @"SELF MATCHES '[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}'"];
    NSPredicate *datePredicate = [NSPredicate
                                  predicateWithFormat:@"SELF MATCHES '[0-9]{1}[0-9]{1}[/]{1}[0-9]{1}[0-9]{1}[/]{1}[0-9]{1}[0-9]{1}[0-9]{1}[0-9]{1}'"];
    
    BOOL allValid = YES;
    
    // We do these next three error checking sequences in reverse order so that the
    // first field that is wrong will be the one that ends up with voiceover focusing on
    // it.
    
    BOOL isValid = [datePredicate evaluateWithObject:dateFieldString];
    if([dateFieldString isEqualToString:@""]){
        _dateField.accessibilityHint = NULL;
        _dateField.accessibilityLabel = @"Date, m m / d d / y y y y, this field is required.";
        [_dateReq setHidden:NO];
        UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, _dateField);
    }
    else if(!isValid){
        // set accessibility hint to nothing and label to more verbose, descriptive label
        _dateField.accessibilityHint = NULL;
        _dateField.accessibilityLabel = @"Date, m m / d d / y y y y, please enter a valid date.";
        _dateReq.text = @"Format: mm/dd/yyyy";
        
        // show red text to tell user they messed this field up
        [_dateReq setHidden:NO];
        
        // shift voiceover focus to date text field
        UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, _dateField);
        allValid = FALSE;
    }
    else{
        [_dateReq setHidden:YES];
    }
    isValid = [emailPredicate evaluateWithObject:emailFieldString];
    if([emailFieldString isEqualToString:@""]){
        _emailField.accessibilityHint = NULL;
        _emailField.accessibilityLabel = @"Email, this field is required.";
        [_emailReq setHidden:NO];
        UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, _emailField);
    }
    else if(!isValid){
        // set accessibility hint to nothing and label to more verbose, descriptive label
        _emailField.accessibilityHint = NULL;
        _emailField.accessibilityLabel = @"Email, please enter a valid email.";
        _emailReq.text = @"Please enter a valid email";
        
        // show red text to let user know they messed up this field
        [_emailReq setHidden:NO];
        
        // shift voiceover focus to email text field
        UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, _emailField);
        allValid = FALSE;
    }
    else{
        [_emailReq setHidden:YES];
    }
    
    // check if name input is valid (of the form 'FirstName LastName')
    isValid = [namePredicate evaluateWithObject:nameFieldString];
    if(!isValid){
        // set accessibility hint to nothing and label to a more verbose, descriptive label
        _nameField.accessibilityHint = NULL;
        _nameField.accessibilityLabel = @"Name, this field is required.";
        
        // show red text to tell user they messed up this field
        [_nameReq setHidden:NO];
        
        // shift voiceover focus to name text field
        UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, _nameField);
        allValid = FALSE;
    }
    else{
        [_nameReq setHidden:YES];
    }
    // if not all fields were valid, we return without submitting the form
    if(!allValid){
        return;
    }
        /*
         * This is where we will have an HTTP post request in the future, for now, because of 
         * time constraints, we instead just redirect the person to the existing form on 
         * Deque's website if they want to actually recieve information about Deque
         */
       
    
}
- (IBAction)backgroundTap:(id)sender{
    //get rid of keyboard on background tap
    [self.view endEditing:YES];
}

// get rid of keyboard when "done" is pressed
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    return YES;
}
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
- (IBAction)information:(id)sender {
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.deque.com"]];
}
@end
