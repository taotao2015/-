//
//  YLTextView.m
//  微博
//
//  Created by tao on 15/12/13.
//  Copyright © 2015年 tao. All rights reserved.
//

#import "YLTextView.h"
@interface YLTextView()


@end

@implementation YLTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *placeholderLabel = [[UILabel alloc]init];
        placeholderLabel.font = FONT(14);
        placeholderLabel.textColor = [UIColor grayColor];
        [self addSubview:placeholderLabel];
        
        self.placeholederLabel = placeholderLabel;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidChange:) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.placeholederLabel.x = 3;
    self.placeholederLabel.y = 6;
    CGSize size = CGSizeMake(SCREENW - self.placeholederLabel.x * 2, MAXFLOAT);
    self.placeholederLabel.size = [self.placeholederLabel.text sizeWithFont:FONT(14) constrainedToSize:size];
    

}
- (void)setFont:(UIFont *)font{
    [super setFont:font];
    self.placeholederLabel.font = font;

}
- (void)textViewDidChange:(NSNotification *)notif{
    self.placeholederLabel.hidden = self.text.length;

}
- (void)setPloceholder:(NSString *)ploceholder{
    _ploceholder = ploceholder;
    _placeholederLabel.text = ploceholder;
}
@end
