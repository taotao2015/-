//
//  YLhomeTittleButton.m
//  微博
//
//  Created by tao on 15/12/3.
//  Copyright © 2015年 tao. All rights reserved.
//

#import "YLhomeTittleButton.h"

@implementation YLhomeTittleButton

-(void)layoutSubviews{
    [super layoutSubviews];
    self.titleLabel.x = 0;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + 5;
    self.width = CGRectGetMaxX(self.imageView.frame);
    self.centerX = self.superview.centerX;
    //self.centerY = self.superview.centerY;
}

@end
