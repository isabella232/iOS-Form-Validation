//
//  iOSFormsViewController.m
//  iOSFormsDemo
//
//  Created by Deque Developer on 3/5/15.
//  Copyright (c) 2015 Deque Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "ViewController.h"
#import "AppDelegate.h"

@interface iOSFormsViewController : XCTestCase
@property (strong, nonatomic) ViewController *controller;
@end


@implementation iOSFormsViewController
@synthesize controller = _controller;
- (void)setUp {
    
        [super setUp];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        self.controller = [storyboard instantiateViewControllerWithIdentifier:@"main"];
        [self.controller performSelectorOnMainThread:@selector(loadView) withObject:nil waitUntilDone:YES];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssertTrue(YES, @"Pass");
}

- (void)testLabelsOnStartup {
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

- (void)testRegex {
    NSString *stdLabel = @"This field is required.";
    
    //Test regex error checking when empty strings are input:
    
    self.controller.emailField.text = @"";
    self.controller.nameField.text = @"";
    self.controller.dateField.text = @"";
    [self.controller submitButton:self];
    XCTAssertFalse([self.controller.emailReq isHidden]);
    XCTAssert([self.controller.emailReq.text isEqualToString:stdLabel]);
    XCTAssert([self.controller.dateReq.text isEqualToString:stdLabel]);
    XCTAssertFalse([self.controller.dateReq isHidden]);
    XCTAssert([self.controller.nameReq.text isEqualToString:stdLabel]);
    XCTAssertFalse([self.controller.nameReq isHidden]);
    
    //Test regex error checking when valid strings are input:
    
    NSString *validEmail1 = @"valid@example.com";
    NSString *validName1 = @"valid example";
    NSString *validDate1 = @"11/11/2014";
    
    self.controller.emailField.text = validEmail1;
    self.controller.nameField.text = validName1;
    self.controller.dateField.text = validDate1;
    
    [self.controller submitButton:self];
    
    XCTAssertTrue([self.controller.emailReq isHidden]);
    XCTAssert([self.controller.emailReq.text isEqualToString:stdLabel]);
    XCTAssert([self.controller.dateReq.text isEqualToString:stdLabel]);
    XCTAssertTrue([self.controller.dateReq isHidden]);
    XCTAssert([self.controller.nameReq.text isEqualToString:stdLabel]);
    XCTAssertTrue([self.controller.nameReq isHidden]);
    
    
    
    return;
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
