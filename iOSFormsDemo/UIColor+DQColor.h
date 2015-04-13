//
//  UIColor+DQColor.h
//  FormValidation
//
//  Created by Deque Developer on 4/10/15.
//  Copyright (c) 2015 Deque Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (DQColor)

-(BOOL) isEqualToColorWithRed:(CGFloat)testred green:(CGFloat)testgreen blue:(CGFloat)testblue alpha:(CGFloat)testalpha;

-(BOOL) isEqualToColor:(UIColor *)color;

@end
