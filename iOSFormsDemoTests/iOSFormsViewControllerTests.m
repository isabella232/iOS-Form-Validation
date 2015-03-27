//
//  iOSFormsViewController.m
//  iOSFormsDemo
//
//  Created by Alistair Barrell on 3/5/15.
//  Copyright (c) 2015 Deque Systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "ViewController.h"
#import "AppDelegate.h"

@interface iOSFormsViewControllerTests : XCTestCase

@property (strong, nonatomic) ViewController *controller;

@end


@implementation iOSFormsViewControllerTests

@synthesize controller = _controller;

- (void)setUp {
    // Mock view controller
    [super setUp];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.controller = [storyboard instantiateViewControllerWithIdentifier:@"main"];
    [self.controller performSelectorOnMainThread:@selector(loadView) withObject:nil waitUntilDone:YES];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


- (void)testVisualLabelsOnStartup {
    XCTAssert([self.controller view]);
    XCTAssert([self.controller emailReq]);
    XCTAssert([self.controller nameReq]);
    XCTAssert(([self.controller dateReq]));
    XCTAssertTrue([[self.controller dateReq] isHidden]);
    XCTAssert([[self.controller emailReq] isHidden]);
    XCTAssert([[self.controller nameReq] isHidden]);
    
}

-(void)testAccessibilityLabelsAndHintsOnStartup {
    //Tet to make sure accessibility labels and hints are the correct values upon startup of the app
    NSString *stdHint = @"This field is required";
    NSString *stdDateHint = @"m m / d d / y y y y, this field is required";
    
    XCTAssert([self.controller.emailField.accessibilityHint isEqualToString:stdHint]);
    XCTAssert([self.controller.nameField.accessibilityHint isEqualToString:stdHint]);
    XCTAssert([self.controller.dateField.accessibilityHint isEqualToString:stdDateHint]);
    XCTAssert([self.controller.dateField.accessibilityLabel isEqualToString:@"Date"]);
    XCTAssert([self.controller.nameField.accessibilityLabel isEqualToString:@"Name"]);
    XCTAssert([self.controller.emailField.accessibilityLabel isEqualToString:@"Email"]);
}

- (void)testUserSubmitsInvalidStrings {
    NSString *stdLabel = @"This field is required.";

    // Test Regex Error checking with invalid input. Will add more invalid
    // cases, but for now this is fine.

    // Invalid Email, Name and Date examples
    NSString *invalidEmail1 = @"invalidexample";
    NSString *invalidName1 = @"invalid-example";
    NSString *invalidDate1 = @"1/1/14";
    
    // Formatting for visual labels and accessibility labels
    NSString *dateFormattingIsWrongNotify = @"Format: mm/dd/yyyy";
    NSString *emailFormattingIsWrongNotify = @"Please enter a valid email";
    NSString *dateErrorAccessibilityLabel = @"Date, m m / d d / y y y y, please enter a valid date.";
    NSString *emailErrorAccessibilityLabel = @"Email, please enter a valid email.";
    NSString *nameErrorAccessibilityLabel = @"Name, this field is required.";

    // Input invalid strings
    self.controller.emailField.text = invalidEmail1;
    self.controller.nameField.text = invalidName1;
    self.controller.dateField.text = invalidDate1;
    
    // submit
    [self.controller submitButton:self];
    
    // Verify visual
    XCTAssertTrue(![self.controller.emailReq isHidden]);
    XCTAssert([self.controller.emailReq.text isEqualToString:emailFormattingIsWrongNotify]);
    XCTAssert([self.controller.dateReq.text isEqualToString:dateFormattingIsWrongNotify]);
    XCTAssertTrue(![self.controller.dateReq isHidden]);
    XCTAssert([self.controller.nameReq.text isEqualToString:stdLabel]);
    XCTAssertTrue(![self.controller.nameReq isHidden]);
    
    // Verify accessibility
    XCTAssertNil(self.controller.emailField.accessibilityHint );
    XCTAssertNil(self.controller.nameField.accessibilityHint);
    XCTAssertNil(self.controller.dateField.accessibilityHint);
    XCTAssert([self.controller.dateField.accessibilityLabel isEqualToString:dateErrorAccessibilityLabel]);
    XCTAssert([self.controller.nameField.accessibilityLabel isEqualToString:nameErrorAccessibilityLabel]);
    XCTAssert([self.controller.emailField.accessibilityLabel isEqualToString:emailErrorAccessibilityLabel]);
    
    return;
}

-(void)testUserSubmitsNothing {
    
    // Test regex error checking when empty strings are input:
    
    // Standard visual label
    NSString *stdLabel = @"This field is required.";
    
    // Input empty strings
    self.controller.emailField.text = @"";
    self.controller.nameField.text = @"";
    self.controller.dateField.text = @"";
    
    // Submit
    [self.controller submitButton:self];
    
    // Test visual
    XCTAssertFalse([self.controller.emailReq isHidden]);
    XCTAssert([self.controller.emailReq.text isEqualToString:stdLabel]);
    XCTAssert([self.controller.dateReq.text isEqualToString:stdLabel]);
    XCTAssertFalse([self.controller.dateReq isHidden]);
    XCTAssert([self.controller.nameReq.text isEqualToString:stdLabel]);
    XCTAssertFalse([self.controller.nameReq isHidden]);
    
    // Test accessibility
    // Hints must be NULL
    XCTAssertNil(self.controller.emailField.accessibilityHint );
    XCTAssertNil(self.controller.nameField.accessibilityHint);
    XCTAssertNil(self.controller.dateField.accessibilityHint);
    
    // Labels
    XCTAssert([self.controller.dateField.accessibilityLabel isEqualToString:@"Date, m m / d d / y y y y, this field is required."]);
    XCTAssert([self.controller.nameField.accessibilityLabel isEqualToString:@"Name, this field is required."]);
    XCTAssert([self.controller.emailField.accessibilityLabel isEqualToString:@"Email, this field is required."]);
}

-(void)testUserSubmitsValidStrings {
    //Test regex error checking when valid strings are input:
    
    // Standard label
    NSString *stdLabel = @"This field is required.";
    
    // Valid strings
    NSString *validEmail1 = @"valid@example.com";
    NSString *validName1 = @"valid example";
    NSString *validDate1 = @"11/11/2014";
    
    // Input invalid strings
    self.controller.emailField.text = validEmail1;
    self.controller.nameField.text = validName1;
    self.controller.dateField.text = validDate1;
    
    // Submit
    [self.controller submitButton:self];
    
    // Test visual
    XCTAssertTrue([self.controller.emailReq isHidden]);
    XCTAssert([self.controller.emailReq.text isEqualToString:stdLabel]);
    XCTAssert([self.controller.dateReq.text isEqualToString:stdLabel]);
    XCTAssertTrue([self.controller.dateReq isHidden]);
    XCTAssert([self.controller.nameReq.text isEqualToString:stdLabel]);
    XCTAssertTrue([self.controller.nameReq isHidden]);
    
    // Test accessibility
    NSString *stdHint = @"This field is required";
    NSString *stdDateHint = @"m m / d d / y y y y, this field is required";
    
    // Hints
    XCTAssert([self.controller.emailField.accessibilityHint isEqualToString:stdHint]);
    XCTAssert([self.controller.nameField.accessibilityHint isEqualToString:stdHint]);
    XCTAssert([self.controller.dateField.accessibilityHint isEqualToString:stdDateHint]);
    
    // Labels
    XCTAssert([self.controller.dateField.accessibilityLabel isEqualToString:@"Date"]);
    XCTAssert([self.controller.nameField.accessibilityLabel isEqualToString:@"Name"]);
    XCTAssert([self.controller.emailField.accessibilityLabel isEqualToString:@"Email"]);
}

-(void)testImageAccessibility {
    
    // Check to see that the correct image is actually being displayed in the UIImageView
    UIImage* checkImage = [UIImage imageNamed:@"DequeLogo"];
    NSData *checkImageData = UIImagePNGRepresentation(checkImage);
    XCTAssert([checkImageData isEqualToData:UIImagePNGRepresentation(self.controller.logo.image)]);
    
    // Check to make sure its accessibility label is the correct one for the image displayed.
    XCTAssert([self.controller.logo.accessibilityLabel isEqualToString:@"Logo, Deque Systems"]);
    
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
