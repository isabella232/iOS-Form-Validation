//
//  IACResizingLabel.m
//  Accessibility 101
//
//  Created by Chris McMeeking on 3/31/15.
//  Copyright (c) 2015 Deque Systems. All rights reserved.
//

#import "DEQDynamicTypeLabel.h"
#import "DEQDynamicTypeTextView.h"

@implementation DEQDynamicTypeLabel {
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
    _contentSizeCategory = [DEQDynamicTypeTextView fontStyleForFont:self.font];
    
    [self didChangePreferredContentSize];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didChangePreferredContentSize)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
    
    self.numberOfLines = 0;

}

-(void)didChangePreferredContentSize {
    self.font = [UIFont preferredFontForTextStyle:_contentSizeCategory];
}

-(void)setContentSizeCategory:(NSString *)contentSizeCategory {
    
    if (_contentSizeCategory == UIFontTextStyleHeadline ||
        _contentSizeCategory == UIFontTextStyleSubheadline ||
        _contentSizeCategory == UIFontTextStyleFootnote ||
        _contentSizeCategory == UIFontTextStyleCaption2 ||
        _contentSizeCategory == UIFontTextStyleCaption1 ||
        _contentSizeCategory == UIFontTextStyleBody) {
        
        _contentSizeCategory = contentSizeCategory;
    } else {
        NSLog(@"%@ WARNING: Content Size Category not valid, setting to UIFontTextStyleHeadline by default", self);
        _contentSizeCategory = UIFontTextStyleHeadline;
    }
    
    [self didChangePreferredContentSize];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
