//
//  ViewController.h
//  DequeApp
//
//  Created by Deque Developer on 2/27/15.
//  Copyright (c) 2015 Deque Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>
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


@end

