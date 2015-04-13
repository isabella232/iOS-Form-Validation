//
//  UIColor+DQColor.m
//  FormValidation
//
//  Created by Deque Developer on 4/10/15.
//  Copyright (c) 2015 Deque Developer. All rights reserved.
//

#import "UIColor+DQColor.h"

@implementation UIColor (DQColor)

- (BOOL)isEqualToColorWithRed:(CGFloat)testred green:(CGFloat)testgreen blue:(CGFloat)testblue alpha:(CGFloat)testalpha{
    
    CGFloat redVal;
    CGFloat greenVal;
    CGFloat blueVal;
    CGFloat alphaVal;
    
    [self getRed:&redVal green:&greenVal blue:&blueVal alpha:&alphaVal];
    
    return (testred == redVal && testalpha == alphaVal && testblue == blueVal && testgreen == greenVal);
    
}

- (BOOL)isEqualToColor:(UIColor *)color{
    
    CGFloat redVal;
    CGFloat greenVal;
    CGFloat blueVal;
    CGFloat alphaVal;
    CGFloat redCompare;
    CGFloat greenCompare;
    CGFloat blueCompare;
    CGFloat alphaCompare;
  
    [self getRed:&redVal green:&greenVal blue:&blueVal alpha:&alphaVal];
    [color getRed:&redCompare green:&greenCompare blue:&blueCompare alpha:&alphaCompare];
    
    return(redVal == redCompare && greenVal == greenCompare && blueVal == blueCompare && alphaVal == alphaCompare);
    
}

@end
