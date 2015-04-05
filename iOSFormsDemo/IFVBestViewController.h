//
//  ViewController.h
//  DequeApp
//
//  Created by Alistair Barrell on 2/27/15.
//  Copyright (c) Deque Systems 2015. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IFVBestViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *dateField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UILabel *nameReq;
@property (weak, nonatomic) IBOutlet UILabel *emailReq;
@property (weak, nonatomic) IBOutlet UILabel *dateReq;
- (IBAction)submitButton:(id)sender;
- (IBAction)backgroundTap:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *logo;
- (IBAction)information:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *iWouldLikeToLearnMoreLink;

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
         originalA11yHint:(NSString*)originalA11yHint;


@end

