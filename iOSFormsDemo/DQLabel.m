//
//  IACResizingLabel.m
//  Accessibility 101
//
//  Created by Chris McMeeking on 3/31/15.
//  Copyright (c) 2015 Deque Systems. All rights reserved.
//

#import "DQLabel.h"
#import "DQTextView.h"

@implementation DQLabel {
    NSString* _contentSizeCategory;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self)
        [self initialize];
    
    return self;
}

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self)
        [self initialize];
    
    return self;
}

-(void)initialize {
    [self setContentSizeCategory:[DQTextView fontStyleForFont:self.font]];
    
    [self didChangePreferredContentSize];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didChangePreferredContentSize)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
}

-(void)didChangePreferredContentSize {
    self.font = [UIFont preferredFontForTextStyle:_contentSizeCategory];
}

-(void)setContentSizeCategory:(NSString *)contentSizeCategory {
    
    if ([DQTextView isValidContentSizeCategory:contentSizeCategory]) {
        
        _contentSizeCategory = contentSizeCategory;
    } else {
        NSLog(@"WARNING: Content Size Category not valid, setting to \"UIFontTextStyleBody\" by default for element: %@", self);
        _contentSizeCategory = UIFontTextStyleBody;
    }
    
    if (_contentSizeCategory == UIFontTextStyleHeadline) {
        self.accessibilityTraits |= UIAccessibilityTraitHeader;
    }
    
    [self didChangePreferredContentSize];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
