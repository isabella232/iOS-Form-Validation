//
//  IFVBadViewController.m
//  iOSFormsDemo
//
//  Created by Chris McMeeking on 4/2/15.
//  Copyright (c) 2015 Deque Developer. All rights reserved.
//

#import "regex.h"
#import "IFVBrokenViewController.h"
#import "IFVBestViewController.h"
#import "CustomIOS7AlertView.h"

@interface IFVBrokenViewController()<CustomIOS7AlertViewDelegate>

@end

@implementation IFVBrokenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dateField.delegate = self;
    _nameField.delegate = self;
    _emailField.delegate = self;
    
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
        warningLabel.textColor = [UIColor redColor];
        return NO;
    } else if (![predicate evaluateWithObject:textField.text]) {
        warningLabel.text = predicateWarning;
        warningLabel.hidden = NO;
        warningLabel.textColor = [UIColor redColor];
        return NO;
    } else {
        warningLabel.hidden = YES;
        warningLabel.text = nil;
        return YES;
    }
}

- (IBAction)submitButton:(id)sender {
    
    [self.class validateTextField:_emailField
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
    
    [self.class validateTextField:_dateField
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
                 originalA11yHint:[NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"DATE_FORMAT_A11Y", nil), NSLocalizedString(@"VALIDATION_ERROR_MISSING", nil)]];
    
    [self.class validateTextField:_nameField
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
    CustomIOS7AlertView *alertView = [CustomIOS7AlertView alertWithTitle:NSLocalizedString(@"ALERT_TITLE", nil)
                                                                 message:NSLocalizedString(@"ALERT_PARAGRAPH", nil)];
    
    [alertView setButtonTitles:[NSMutableArray arrayWithObjects:NSLocalizedString(@"ALERT_BUTTON_EMAIL_US", nil),
                                NSLocalizedString(@"ALERT_BUTTON_VISIT", nil),
                                NSLocalizedString(@"ALERT_BUTTON_CLOSE", nil),
                                nil]];
    
    [alertView setButtonColors:[NSMutableArray arrayWithObjects:[UIColor colorWithRed:255.0f/255.0f
                                                                                green:77.0f/255.0f
                                                                                 blue:94.0f/255.0f
                                                                                alpha:1.0f],
                                [UIColor colorWithRed:0.0f
                                                green:0.5f
                                                 blue:1.0f
                                                alpha:1.0f],nil]];
    
    [alertView setDelegate:self];
    
    [alertView show];
}

- (void)customIOS7dialogButtonTouchUpInside: (CustomIOS7AlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto:chris.mcmeeking@deque.com"]];
    } else if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.deque.com"]];
    }
    
    [alertView close];
}

@end
