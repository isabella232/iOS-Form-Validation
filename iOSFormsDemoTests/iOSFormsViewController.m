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

/* THESE TESTS DON'T WORK YET */

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

    NSString *stdHint = @"This field is required";
    NSString *stdDateHint = @"m m / d d / y y y y, this field is required";
    XCTAssert([self.controller.emailField.accessibilityHint isEqualToString:stdHint]);
    XCTAssert([self.controller.nameField.accessibilityHint isEqualToString:stdHint]);
    XCTAssert([self.controller.dateField.accessibilityHint isEqualToString:stdDateHint]);
    XCTAssert([self.controller.dateField.accessibilityLabel isEqualToString:@"Date"]);
    XCTAssert([self.controller.nameField.accessibilityLabel isEqualToString:@"Name"]);
    XCTAssert([self.controller.emailField.accessibilityLabel isEqualToString:@"Email"]);
}

/*- (void)testRegex {
    NSString *stdLabel =@"This field is required";
    ViewController *testController;
    
    
    testController.emailField.text = @"";
    testController.nameField.text = @"";
    testController.dateField.text = @"";
    XCTAssert([.emailReq.text isEqualToString:stdLabel]);
    XCTAssert(![testController.emailReq isHidden]);
    XCTAssert([testController.dateReq.text isEqualToString:stdLabel]);
    XCTAssert(![testController.dateReq isHidden]);
    XCTAssert([testController.nameReq.text isEqualToString:stdLabel]);
    XCTAssert(![testController.nameReq isHidden]);

    
    return;
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}*/

@end
