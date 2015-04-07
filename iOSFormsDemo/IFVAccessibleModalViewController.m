//
//  IFVAccessibleModalViewController.m
//  FormValidation
//
//  Created by Chris McMeeking on 4/6/15.
//  Copyright (c) 2015 Deque Developer. All rights reserved.
//

#import "IFVAccessibleModalViewController.h"
#import "CustomIOS7AlertView.h"

@interface IFVAccessibleModalViewController ()<CustomIOS7AlertViewDelegate>

@end

@implementation IFVAccessibleModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor clearColor];
    
    CustomIOS7AlertView *alertView = [CustomIOS7AlertView alertWithTitle:@"Thank you for trying this demo" message:@"If you liked what you saw,\nand are interesting in seeing\nwhat we can do together,\nplease shoot us a mail by tapping the button below."];
    [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"Shoot us a mail!", @"Try another demo!", @"Close", nil]];
    [alertView setButtonColors:[NSMutableArray arrayWithObjects:[UIColor colorWithRed:255.0f/255.0f green:77.0f/255.0f blue:94.0f/255.0f alpha:1.0f],[UIColor colorWithRed:0.0f green:0.5f blue:1.0f alpha:1.0f],nil]];
    [alertView setDelegate:self];
    [alertView show];
}

- (void)customIOS7dialogButtonTouchUpInside: (CustomIOS7AlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    NSLog(@"Delegate: Button at position %ld is clicked on alertView %ld.", (long)buttonIndex, (long)[alertView tag]);
    [alertView close];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
