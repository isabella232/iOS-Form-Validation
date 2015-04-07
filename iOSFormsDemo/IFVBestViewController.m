//
//  ViewController.m
//  DequeApp
//
//  Created by Alistair Barrell on 2/27/15.
//  Copyright (c) Deque Systems 2015. All rights reserved.
//
#import "regex.h"
#import "IFVBestViewController.h"

@implementation IFVBestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dateField.delegate = self;
    _nameField.delegate = self;
    _emailField.delegate = self;
    
    _dateField.accessibilityHint = [NSString stringWithFormat:@"%@ %@",
                                     NSLocalizedString(@"DATE_FORMAT_A11Y", nil),
                                     NSLocalizedString(@"VALIDATION_ERROR_MISSING", nil)];
    
    _emailField.accessibilityHint = NSLocalizedString(@"VALIDATION_ERROR_MISSING", nil);
    _nameField.accessibilityHint = NSLocalizedString(@"VALIDATION_ERROR_MISSING", nil);
}

- (IBAction)submitButton:(id)sender {
    
    [IFVBestViewController validateTextField:_emailField
                                  fieldLabel:_emailLabel
                                warningLabel:_emailReq
                              missingWarning:NSLocalizedString(@"VALIDATION_ERROR_MISSING", nil)
                            missingA11yLabel:[NSString stringWithFormat:@"%@ %@", _emailLabel.text, NSLocalizedString(@"VALIDATION_ERROR_MISSING", nil)]
                             missingA11yHint:nil
                                forPredicate:[NSPredicate predicateWithFormat:NSLocalizedString(@"PREDICATE_STRING_EMAIL", nil)]
                            predicateWarning:NSLocalizedString(@"VALIDATION_ERROR_EMAIL_FORMAT", nil)
                          predicateA11yLabel:[NSString stringWithFormat:@"%@ %@", _emailLabel.text, NSLocalizedString(@"VALIDATION_ERROR_EMAIL_FORMAT", nil)]
                           predicateA11yHint:nil
                           originalA11yLabel:_emailLabel.text
                            originalA11yHint:NSLocalizedString(@"VALIDATION_ERROR_MISSING", nil)];
    
    [IFVBestViewController validateTextField:_dateField
                                  fieldLabel:_dateLabel
                                warningLabel:_dateReq
                              missingWarning:NSLocalizedString(@"VALIDATION_ERROR_MISSING", nil)
                            missingA11yLabel:[NSString stringWithFormat:@"%@ %@", _dateLabel.text, NSLocalizedString(@"VALIDATION_ERROR_MISSING", nil)]
                             missingA11yHint:NSLocalizedString(@"VALIDATION_ERROR_DATE_FORMAT_A11Y", nil)
                                forPredicate:[NSPredicate predicateWithFormat:NSLocalizedString(@"PREDICATE_STRING_DATE", nil)]
                            predicateWarning:NSLocalizedString(@"VALIDATION_ERROR_DATE_FORMAT", nil)
                          predicateA11yLabel:[NSString stringWithFormat:@"%@ %@", _dateLabel.text, NSLocalizedString(@"VALIDATION_ERROR_DATE_FORMAT_A11Y", nil)]
                           predicateA11yHint:nil
                           originalA11yLabel:_dateLabel.text
                            originalA11yHint:[NSString stringWithFormat:@"%@ %@",
                                              NSLocalizedString(@"DATE_FORMAT_A11Y", nil),
                                              NSLocalizedString(@"VALIDATION_ERROR_MISSING", nil)]];
    
    [IFVBestViewController validateTextField:_nameField
                                  fieldLabel:_nameLabel
                                warningLabel:_nameReq
                              missingWarning:NSLocalizedString(@"VALIDATION_ERROR_MISSING", nil)
                            missingA11yLabel:[NSString stringWithFormat:@"%@ %@", _nameLabel.text, NSLocalizedString(@"VALIDATION_ERROR_MISSING", nil)]
                             missingA11yHint:nil
                                forPredicate:[NSPredicate predicateWithFormat:NSLocalizedString(@"PREDICATE_STRING_NAME", nil)]
                            predicateWarning:NSLocalizedString(@"VALIDATION_ERROR_NAME_FORMAT", nil)
                          predicateA11yLabel:[NSString stringWithFormat:@"%@ %@", _nameLabel.text, NSLocalizedString(@"VALIDATION_ERROR_NAME_FORMAT", nil)]
                           predicateA11yHint:nil
                           originalA11yLabel:_nameLabel.text
                            originalA11yHint:NSLocalizedString(@"VALIDATION_ERROR_MISSING", nil)];
    
    if (_nameReq.text) {
        UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, _nameField);
    } else if (_emailReq.text) {
        UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, _emailField);
    } else if (_dateReq.text) {
        UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, _dateField);
    }
}

- (void)viewDidAppear:(BOOL)animated {
    UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, _logo);
}

- (IBAction)backgroundTap:(id)sender {
    //get rid of keyboard on background tap
    [self.view endEditing:YES];
}

// get rid of keyboard when "done" is pressed
- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    [textField resignFirstResponder];
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (IBAction)information:(id)sender {
    UIViewController* modalViewControlelr = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"AccessibleModal"];
    
    modalViewControlelr.view.backgroundColor = [UIColor clearColor];
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    
    [self.navigationController presentViewController:modalViewControlelr animated:YES completion:nil];
    
    self.view.accessibilityElementsHidden = YES;
    self.tabBarController.view.accessibilityElementsHidden = YES;
    
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.deque.com"]];
}

+ (BOOL)validateTextField:(UITextField*)textField
               fieldLabel:(UILabel*)fieldLabel
             warningLabel:(UILabel*)warningLabel
           missingWarning:(NSString*)missingWarning
         missingA11yLabel:(NSString*)missingA11yLabel
          missingA11yHint:(NSString*)missingA11yHint
             forPredicate:(NSPredicate*)predicate
         predicateWarning:(NSString*)predicateWarning
       predicateA11yLabel:(NSString*)predicateA11yLabel
        predicateA11yHint:(NSString*)predicateA11yHint
        originalA11yLabel:(NSString*)originalA11yLabel
         originalA11yHint:(NSString*)originalA11yHint {

    if (textField.text == nil || [textField.text isEqualToString:@""]) {
        warningLabel.text = missingWarning;
        warningLabel.hidden = NO;
        
        textField.accessibilityLabel = missingA11yLabel;
        textField.accessibilityHint = missingA11yHint;
    } else if (![predicate evaluateWithObject:textField.text]) {
        warningLabel.text = predicateWarning;
        warningLabel.hidden = NO;
        
        textField.accessibilityHint = predicateA11yHint;
        textField.accessibilityLabel = predicateA11yLabel;
    } else {
        warningLabel.hidden = YES;
        warningLabel.text = nil;
        
        textField.accessibilityLabel = originalA11yLabel;
        textField.accessibilityHint = originalA11yHint;
        
        return YES;
    }
    
    return NO;
}

@end
