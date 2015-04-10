//
//  iOSFormsViewController.m
//  iOSFormsDemo
//
//  Created by Alistair Barrell on 3/5/15.
//  Copyright (c) 2015 Deque Systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "IFVFixedViewController.h"
#import "AppDelegate.h"

#define DEQAssertStringEqual(testString, correctString) XCTAssert([testString isEqualToString:correctString], @"\"%@\"", testString)
#define DEQAssertStringEndsWith(testString, endsWithString) XCTAssert([testString hasSuffix:endsWithString], @"\"%@\"", testString)
#define DEQAssertEmptyString(testString) XCTAssert(testString == nil || [testString isEqualToString:@""], @"\"%@\"", testString)

@interface iOSFormsViewControllerTests : XCTestCase

@property (strong, nonatomic) IFVFixedViewController *controller;

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
    
    XCTAssertFalse(self.controller.emailField.isAccessibilityElement);
    XCTAssertTrue(self.controller.emailField.superview.isAccessibilityElement);
    DEQAssertStringEqual(self.controller.emailField.superview.accessibilityHint, @"This field is required.");
    DEQAssertStringEqual(self.controller.emailField.superview.accessibilityLabel, @"Email");
    XCTAssert([[self.controller emailRequirement] isHidden]);
    
    XCTAssertFalse(self.controller.dateField.isAccessibilityElement);
    XCTAssertTrue(self.controller.dateField.superview.isAccessibilityElement);
    DEQAssertStringEqual(self.controller.dateField.superview.accessibilityHint, @"This field is required.");
    DEQAssertStringEqual(self.controller.dateField.superview.accessibilityLabel, @"Date m m / d d / y y y y");
    DEQAssertStringEqual(self.controller.dateRequirement.text, @"mm/dd/yyyy");
    XCTAssertFalse([[self.controller dateRequirement] isHidden]);
    
    XCTAssertFalse(self.controller.nameField.isAccessibilityElement);
    XCTAssertTrue(self.controller.nameField.superview.isAccessibilityElement);
    DEQAssertStringEqual(self.controller.nameField.superview.accessibilityHint, @"This field is required.");
    DEQAssertStringEqual(self.controller.nameField.superview.accessibilityLabel, @"Name");
    XCTAssert([self.controller nameRequirement]);
    
    // Check that accessibilityLabel matches the image.
    NSData *checkImageData = UIImagePNGRepresentation([UIImage imageNamed:@"DequeLogo"]);
    XCTAssert([checkImageData isEqualToData:UIImagePNGRepresentation(self.controller.dequeLogo.image)]);
    XCTAssert([self.controller.dequeLogo.accessibilityLabel isEqualToString:@"Logo, Deque Systems"]);
    
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
    DEQAssertStringEqual(self.controller.emailRequirement.text, @"Please enter a valid email.");
    XCTAssertFalse([self.controller.emailRequirement isHidden]);
    DEQAssertStringEqual(self.controller.emailField.superview.accessibilityLabel, @"Email ERROR Please enter a valid email.");
    DEQAssertEmptyString(self.controller.emailField.superview.accessibilityHint);

    DEQAssertStringEqual(self.controller.nameRequirement.text, @"Can only contain letters and numbers.");
    XCTAssertFalse([self.controller.nameRequirement isHidden]);
    DEQAssertStringEqual(self.controller.nameField.superview.accessibilityLabel, @"Name ERROR Can only contain letters and numbers.");
    DEQAssertEmptyString(self.controller.nameField.superview.accessibilityHint);
    
    DEQAssertStringEqual(self.controller.dateRequirement.text, @"Required format mm/dd/yyyy.");
    XCTAssertFalse([self.controller.dateRequirement isHidden]);
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
    DEQAssertStringEqual(self.controller.emailRequirement.text, @"This field is required.");
    XCTAssertFalse([self.controller.emailRequirement isHidden]);
    DEQAssertStringEqual(self.controller.emailField.superview.accessibilityLabel, @"Email ERROR This field is required.");
    XCTAssertNil(self.controller.emailField.superview.accessibilityHint);
    
    DEQAssertStringEqual(self.controller.dateRequirement.text, @"This field is required. Required format mm/dd/yyyy.");
    XCTAssertFalse([self.controller.dateRequirement isHidden]);
    DEQAssertStringEqual(self.controller.dateField.superview.accessibilityLabel, @"Date ERROR This field is required.");
    DEQAssertStringEqual(self.controller.dateField.superview.accessibilityHint, @"Required format m m / d d / y y y y.");
    
    DEQAssertStringEqual(self.controller.nameRequirement.text, @"This field is required.");
    XCTAssertFalse([self.controller.nameRequirement isHidden]);
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
    
    XCTAssertTrue([self.controller.emailRequirement isHidden]);
    DEQAssertStringEqual(self.controller.emailField.superview.accessibilityLabel, @"Email");
    DEQAssertStringEqual(self.controller.emailField.superview.accessibilityHint, @"This field is required.");
    
    XCTAssertTrue([self.controller.nameRequirement isHidden]);
    DEQAssertStringEqual(self.controller.nameField.superview.accessibilityLabel, @"Name");
    DEQAssertStringEqual(self.controller.nameField.superview.accessibilityHint, @"This field is required.");

    XCTAssertTrue([self.controller.dateRequirement isHidden]);
    DEQAssertStringEqual(self.controller.dateField.superview.accessibilityLabel, @"Date");
    DEQAssertStringEqual(self.controller.dateField.superview.accessibilityHint, @"m m / d d / y y y y This field is required.");
}

@end
