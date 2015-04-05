//
//  iOSFormsViewController.m
//  iOSFormsDemo
//
//  Created by Alistair Barrell on 3/5/15.
//  Copyright (c) 2015 Deque Systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "IFVBestViewController.h"
#import "AppDelegate.h"

#define DEQAssertStringEqual(testString, correctString) XCTAssert([testString isEqualToString:correctString], @"\"%@\"", testString)
#define DEQAssertStringEndsWith(testString, endsWithString) XCTAssert([testString hasSuffix:endsWithString], @"\"%@\"", testString)
#define DEQAssertEmptyString(testString) XCTAssert(testString == nil || [testString isEqualToString:@""], @"\"%@\"", testString)

@interface iOSFormsViewControllerTests : XCTestCase

@property (strong, nonatomic) IFVBestViewController *controller;

@end


@implementation iOSFormsViewControllerTests

@synthesize controller = _controller;

- (void)setUp {
    // Mock view controller
    [super setUp];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.controller = [storyboard instantiateViewControllerWithIdentifier:@"Best"];
    
    XCTAssert([self.controller view]);
}

- (void)tearDown {
    [super tearDown];
}


- (void)testInitialState {
    
    DEQAssertStringEqual(self.controller.emailField.accessibilityHint, @"This field is required.");
    DEQAssertStringEqual(self.controller.emailField.accessibilityLabel, @"Email");
    XCTAssert([[self.controller emailReq] isHidden]);
    
    DEQAssertStringEqual(self.controller.dateField.accessibilityHint, @"m m / d d / y y y y This field is required.");
    DEQAssertStringEqual(self.controller.dateField.accessibilityLabel, @"Date");
    XCTAssertTrue([[self.controller dateReq] isHidden]);
    
    DEQAssertStringEqual(self.controller.nameField.accessibilityHint, @"This field is required.");
    DEQAssertStringEqual(self.controller.nameField.accessibilityLabel, @"Name");
    XCTAssert([self.controller nameReq]);
    
    // Check that accessibilityLabel matches the image.
    NSData *checkImageData = UIImagePNGRepresentation([UIImage imageNamed:@"DequeLogo"]);
    XCTAssert([checkImageData isEqualToData:UIImagePNGRepresentation(self.controller.logo.image)]);
    XCTAssert([self.controller.logo.accessibilityLabel isEqualToString:@"Logo, Deque Systems"]);
    
    [self testUserSubmitsValidStrings];
}

// Test Regex Error checking with invalid input.
- (void)testUserSubmitsInvalidStrings {
    
    // Input invalid strings and submit form
    self.controller.emailField.text = @"invalidexample";
    self.controller.nameField.text = @"invalid-example";
    self.controller.dateField.text = @"1/1/14";
    [self.controller submitButton:self];
    
    // Verify visual
    DEQAssertStringEqual(self.controller.emailReq.text, @"Please enter a valid email.");
    XCTAssertFalse([self.controller.emailReq isHidden]);
    DEQAssertStringEqual(self.controller.emailField.accessibilityLabel, @"Email Please enter a valid email.");
    DEQAssertEmptyString(self.controller.emailField.accessibilityHint);

    DEQAssertStringEqual(self.controller.nameReq.text, @"Can only contain letters and numbers.");
    XCTAssertFalse([self.controller.nameReq isHidden]);
    DEQAssertStringEqual(self.controller.nameField.accessibilityLabel, @"Name Can only contain letters and numbers.");
    DEQAssertEmptyString(self.controller.nameField.accessibilityHint);
    
    DEQAssertStringEqual(self.controller.dateReq.text, @"Required format mm/dd/yyyy.");
    XCTAssertFalse([self.controller.dateReq isHidden]);
    DEQAssertStringEqual(self.controller.dateField.accessibilityLabel, @"Date Required format m m / d d / y y y y.");
    DEQAssertEmptyString(self.controller.dateField.accessibilityHint);
    
    [self testUserSubmitsValidStrings];
}

// Test regex error checking when empty strings are input
-(void)testUserSubmitsNothing {

    // Input empty strings and submit
    self.controller.emailField.text = @"";
    self.controller.nameField.text = @"";
    self.controller.dateField.text = @"";
    [self.controller submitButton:self];
    
    // Test visual
    DEQAssertStringEqual(self.controller.emailReq.text, @"This field is required.");
    XCTAssertFalse([self.controller.emailReq isHidden]);
    DEQAssertStringEqual(self.controller.emailField.accessibilityLabel, @"Email This field is required.");
    XCTAssertNil(self.controller.emailField.accessibilityHint);
    
    DEQAssertStringEqual(self.controller.dateReq.text, @"This field is required.");
    XCTAssertFalse([self.controller.dateReq isHidden]);
    DEQAssertStringEqual(self.controller.dateField.accessibilityLabel, @"Date This field is required.");
    DEQAssertStringEqual(self.controller.dateField.accessibilityHint, @"Required format m m / d d / y y y y.");
    
    DEQAssertStringEqual(self.controller.nameReq.text, @"This field is required.");
    XCTAssertFalse([self.controller.nameReq isHidden]);
    DEQAssertStringEqual(self.controller.nameField.accessibilityLabel, @"Name This field is required.");
    XCTAssertNil(self.controller.nameField.accessibilityHint);
    
    [self testUserSubmitsValidStrings];
}

-(void)testUserSubmitsValidStrings {
    //Test regex error checking when valid strings are input:
    
    // Input valid strings and submit
    self.controller.emailField.text = @"valid@example.com";
    self.controller.nameField.text = @"valid";
    self.controller.dateField.text = @"11/11/2014";
    [self.controller submitButton:self];
    
    XCTAssertTrue([self.controller.emailReq isHidden]);
    DEQAssertStringEqual(self.controller.emailField.accessibilityLabel, @"Email");
    DEQAssertStringEqual(self.controller.emailField.accessibilityHint, @"This field is required.");
    
    XCTAssertTrue([self.controller.nameReq isHidden]);
    DEQAssertStringEqual(self.controller.nameField.accessibilityLabel, @"Name");
    DEQAssertStringEqual(self.controller.nameField.accessibilityHint, @"This field is required.");

    XCTAssertTrue([self.controller.dateReq isHidden]);
    DEQAssertStringEqual(self.controller.dateField.accessibilityLabel, @"Date");
    DEQAssertStringEqual(self.controller.dateField.accessibilityHint, @"m m / d d / y y y y This field is required.");
}

@end
