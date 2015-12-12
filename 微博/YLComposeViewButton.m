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
    self.titleLabel.width = self.imageView.width;
    self.titleLabel.height = 110 - 80;
    NSLog(@"%f,%f",self.imageView.width,self.width);
//    self.titleLabel.width = self.width;
//    self.titleLabel.height = self.height - self.imageView.height;
}


- (void)animationWithType:(YLComposeViewButtonType)type count:(NSInteger)count{
    POPSpringAnimation *pop = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    if (type==YLComposeViewButtonTypeUp) {
        pop.toValue = [NSValue valueWithCGPoint:CGPointMake(self.centerX,self.centerY - 350 )];
    }else{
        pop.toValue = [NSValue valueWithCGPoint:CGPointMake(self.centerX,self.centerY + 350 )];
    }
    pop.springBounciness = 12;
    pop.springSpeed = 9;
    pop.beginTime = CACurrentMediaTime() + 0.025 * count ;
    [self pop_addAnimation:pop forKey:nil];

}

@end
