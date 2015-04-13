//
//  DQA11yTextField.m
//  FormValidation
//
//  Created by Chris McMeeking on 4/10/15.
//  Copyright (c) 2015 Deque Developer. All rights reserved.
//

#import "DQTextField.h"
#import "DQTextView.h"

@implementation DQTextField {
    NSString* _contentSizeCategory;
}

- (id)init {
    self = [super init];
    
    if (self) {
        [self initialize];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self initialize];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initialize];
    }
    
    return self;
}

-(void)initialize {
    
    _contentSizeCategory = [DQTextView fontStyleForFont:self.font];
    
    [self didChangePreferredContentSize];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didChangePreferredContentSize)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
    
    
}

-(void)didChangePreferredContentSize {
    self.font = [UIFont preferredFontForTextStyle:_contentSizeCategory];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
