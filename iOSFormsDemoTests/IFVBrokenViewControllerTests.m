//
//  IFVBrokenViewControllerTests.m
//  FormValidation
//
//  Created by Deque Developer on 4/13/15.
//  Copyright (c) 2015 Deque Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "IFVBrokenViewController.h"
#import "AppDelegate.h"
#import "UIColor+DQColor.h"
@import CoreGraphics;

#define DEQAssertStringEqual(testString, correctString) XCTAssert([testString isEqualToString:correctString], @"\"%@\"", testString)

#define DEQAssertStringEndsWith(testString, endsWithString) XCTAssert([testString hasSuffix:endsWithString], @"\"%@\"", testString)

#define DEQAssertEmptyString(testString) XCTAssert(testString == nil || [testString isEqualToString:@""], @"\"%@\"", testString)

#define DEQAssertColorEqualsStoryBoardRed(color) XCTAssertTrue([color isEqualToColorWithRed:0.919586479 green: 0.055712726  blue: 0.0222684592 alpha:1.0])
#define DEQAssertColorEqualsRedColor(color) XCTAssertTrue([color isEqual:[UIColor redColor]])

#define DEQAssertColorEqualsBlack(color) XCTAssertTrue([color isEqualToColorWithRed:0 green: 0  blue: 0 alpha:1.0])

@interface iOSFormsBrokenViewControllerTests : XCTestCase

@property (strong, nonatomic) IFVBrokenViewController *controller;

@end


@implementation iOSFormsBrokenViewControllerTests

@synthesize controller = _controller;

- (void)setUp {
    // Mock view controller
    [super setUp];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.controller = [storyboard instantiateViewControllerWithIdentifier:@"Broken"];
    
    XCTAssert([self.controller view]);
}

- (void)tearDown {
    [super tearDown];
}


- (void)testInitialState {
    
    XCTAssertFalse(self.controller.emailField.isAccessibilityElement);
    XCTAssertTrue(self.controller.emailField.superview.isAccessibilityElement);
    DEQAssertStringEqual(self.controller.emailField.superview.accessibilityHint, @"This field is required.");
    DEQAssertStringEqual(self.controller.emailField.superview.accessibilityLabel, @"Email");
    XCTAssert([[self.controller emailReq] isHidden]);
    
    XCTAssertFalse(self.controller.dateField.isAccessibilityElement);
    XCTAssertTrue(self.controller.dateField.superview.isAccessibilityElement);
    DEQAssertStringEqual(self.controller.dateField.superview.accessibilityHint, @"This field is required.");
    DEQAssertStringEqual(self.controller.dateField.superview.accessibilityLabel, @"Date m m / d d / y y y y");
    DEQAssertStringEqual(self.controller.dateReq.text, @"mm/dd/yyyy");
    XCTAssertFalse([[self.controller dateReq] isHidden]);
    
    XCTAssertFalse(self.controller.nameField.isAccessibilityElement);
    XCTAssertTrue(self.controller.nameField.superview.isAccessibilityElement);
    DEQAssertStringEqual(self.controller.nameField.superview.accessibilityHint, @"This field is required.");
    DEQAssertStringEqual(self.controller.nameField.superview.accessibilityLabel, @"Name");
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
    DEQAssertStringEqual(self.controller.emailField.superview.accessibilityLabel, @"Email ERROR Please enter a valid email.");
    DEQAssertEmptyString(self.controller.emailField.superview.accessibilityHint);
    
    DEQAssertStringEqual(self.controller.nameReq.text, @"Can only contain letters and numbers.");
    XCTAssertFalse([self.controller.nameReq isHidden]);
    DEQAssertStringEqual(self.controller.nameField.superview.accessibilityLabel, @"Name ERROR Can only contain letters and numbers.");
    DEQAssertEmptyString(self.controller.nameField.superview.accessibilityHint);
    
    DEQAssertStringEqual(self.controller.dateReq.text, @"Required format mm/dd/yyyy.");
    XCTAssertFalse([self.controller.dateReq isHidden]);
    DEQAssertStringEqual(self.controller.dateField.superview.accessibilityLabel, @"Date Required format m m / d d / y y y y.");
    DEQAssertEmptyString(self.controller.dateField.superview.accessibilityHint);
    
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
    DEQAssertStringEqual(self.controller.emailField.superview.accessibilityLabel, @"Email ERROR This field is required.");
    XCTAssertNil(self.controller.emailField.superview.accessibilityHint);
    
    DEQAssertStringEqual(self.controller.dateReq.text, @"This field is required. Required format mm/dd/yyyy.");
    XCTAssertFalse([self.controller.dateReq isHidden]);
    DEQAssertStringEqual(self.controller.dateField.superview.accessibilityLabel, @"Date ERROR This field is required.");
    DEQAssertStringEqual(self.controller.dateField.superview.accessibilityHint, @"Required format m m / d d / y y y y.");
    
    DEQAssertStringEqual(self.controller.nameReq.text, @"This field is required.");
    XCTAssertFalse([self.controller.nameReq isHidden]);
    DEQAssertStringEqual(self.controller.nameField.superview.accessibilityLabel, @"Name ERROR This field is required.");
    XCTAssertNil(self.controller.nameField.superview.accessibilityHint);
    
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
    DEQAssertStringEqual(self.controller.emailField.superview.accessibilityLabel, @"Email");
    DEQAssertStringEqual(self.controller.emailField.superview.accessibilityHint, @"This field is required.");
    
    XCTAssertTrue([self.controller.nameReq isHidden]);
    DEQAssertStringEqual(self.controller.nameField.superview.accessibilityLabel, @"Name");
    DEQAssertStringEqual(self.controller.nameField.superview.accessibilityHint, @"This field is required.");
    
    XCTAssertTrue([self.controller.dateReq isHidden]);
    DEQAssertStringEqual(self.controller.dateField.superview.accessibilityLabel, @"Date");
    DEQAssertStringEqual(self.controller.dateField.superview.accessibilityHint, @"This field is required.");
}

-(void)testColorChangeOfTextForDateField{
    
    self.controller.emailField.text = @"";
    self.controller.nameField.text = @"";
    self.controller.dateField.text = @"";
    
    DEQAssertColorEqualsStoryBoardRed(self.controller.dateReq.textColor);
    DEQAssertColorEqualsStoryBoardRed(self.controller.nameReq.textColor);
    DEQAssertColorEqualsStoryBoardRed(self.controller.emailReq.textColor);
    
    [self.controller submitButton:self];
    
    DEQAssertColorEqualsRedColor(self.controller.dateReq.textColor);
    DEQAssertColorEqualsRedColor(self.controller.nameReq.textColor);
    DEQAssertColorEqualsRedColor(self.controller.emailReq.textColor);
    
}

@end
