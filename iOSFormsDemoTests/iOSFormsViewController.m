//
//  iOSFormsViewController.m
//  iOSFormsDemo
//
//  Created by Deque Developer on 3/5/15.
//  Copyright (c) 2015 Deque Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#include "ViewController.h"

@interface iOSFormsViewController : XCTestCase

@end

@implementation iOSFormsViewController

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testLabelsOnStartup {
    ViewController *testController;
    NSString *stdLabel = @"This field is required";
    XCTAssert(![testController.emailReq.text isEqualToString:stdLabel]);
    XCTAssert(![testController.nameReq.text isEqualToString:stdLabel]);
    XCTAssert(![testController.dateReq.text isEqualToString:stdLabel]);
    XCTAssert(![testController.dateReq isHidden]);
    XCTAssert(![testController.nameReq isHidden]);
    XCTAssert(![testController.emailReq isHidden]);
}

-(void)testAccessibilityLabelsAndHintsOnStartup {
    ViewController *testController;
    NSString *stdHint = @"This field is required";
    XCTAssert(![testController.emailField.accessibilityHint isEqualToString:stdHint]);
    XCTAssert(![testController.nameField.accessibilityHint isEqualToString:stdHint]);
    XCTAssert(![testController.dateField.accessibilityHint isEqualToString:stdHint]);
    XCTAssert(![testController.dateField.accessibilityLabel isEqualToString:@"Date"]);
    XCTAssert(![testController.nameField.accessibilityLabel isEqualToString:@"Name"]);
    XCTAssert(![testController.emailField.accessibilityLabel isEqualToString:@"Email"]);
}

- (void)testRegex {
   // ViewController *testController;
    //testController.emailField.text = @"";
    return;
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
