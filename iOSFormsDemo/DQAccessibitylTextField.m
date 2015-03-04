//
//  DQAccessibitylTextField.m
//  DequeApp
//
//  Created by Deque Developer on 2/27/15.
//  Copyright (c) 2015 Deque Developer. All rights reserved.
//

#import "DQAccessibitylTextField.h"

@implementation DQAccessibitylTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(NSString*) accessibilityHint{
    UILabel *label = (UILabel*)[self.superview viewWithTag:102];
    return label.text;
}

-(NSString*) accessibilityLabel{
    UILabel *label = (UILabel*) [self.superview viewWithTag:101];
    return label.text;
}
@end