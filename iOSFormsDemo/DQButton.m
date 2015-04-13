//
//  DEQDynamicTypeButton.m
//  FormValidation
//
//  Created by Chris McMeeking on 4/8/15.
//  Copyright (c) 2015 Deque Developer. All rights reserved.
//

#import "DQButton.h"
#import "DQTextView.h"
#import "UIFont+DQFont.h"

@implementation DQButton {
    NSString* _contentSizeCategory;
}

-(id)init {
    self = [super init];
    
    if (self) {
        [self initialize];
    }
    
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self initialize];
    }
    
    return self;
}

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initialize];
    }
    
    return self;
}

-(void)initialize {
    
    _contentSizeCategory = self.titleLabel.font.contentSizeCategory;
    
    [self didChangePreferredContentSize];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didChangePreferredContentSize)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
    
    //Let's make our button pop out a little bit!
    self.layer.shadowOffset = CGSizeMake(1,1);
    self.layer.shadowOpacity = 1;
    self.layer.cornerRadius = 3.0;
    self.layer.shadowColor = [UIColor grayColor].CGColor;
}

-(void)didChangePreferredContentSize {
    self.titleLabel.font = [UIFont preferredFontForTextStyle:_contentSizeCategory];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
