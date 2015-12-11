//
//  YLComposeViewButton.m
//  微博
//
//  Created by tao on 15/12/11.
//  Copyright © 2015年 tao. All rights reserved.
//

#import "YLComposeViewButton.h"

@implementation YLComposeViewButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.font = FONT(14);
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = [UIColor grayColor];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = 80;
    self.imageView.height = 80;
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.height = self.height - self.imageView.height;
    self.titleLabel.width = self.width;

}

@end
