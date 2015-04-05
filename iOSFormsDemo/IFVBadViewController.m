//
//  IFVBadViewController.m
//  iOSFormsDemo
//
//  Created by Chris McMeeking on 4/2/15.
//  Copyright (c) 2015 Deque Developer. All rights reserved.
//

#import "regex.h"
#import "IFVBadViewController.h"
#import "IFVBestViewController.h"

@implementation IFVBadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dateField.delegate = self;
    _nameField.delegate = self;
    _emailField.delegate = self;
    
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
        _nameReq.isAccessibilityElement = YES;
    } else {
        _nameReq.isAccessibilityElement = NO;
    }
    
    if (_emailReq.text) {
        _emailReq.isAccessibilityElement = YES;
    } else {
        _emailReq.isAccessibilityElement = NO;
    }
    
    if (_dateReq.text) {
        _dateReq.isAccessibilityElement = YES;
    } else {
        _dateReq.isAccessibilityElement = NO;
    }
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
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.deque.com"]];
}

@end
