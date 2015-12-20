//
//  YLpopButton.m
//  微博
//
//  Created by tao on 15/12/4.
//  Copyright © 2015年 tao. All rights reserved.
//

#import "YLpopButton.h"

@implementation YLpopButton

- (instancetype)initWithCustomView:(UIView *)view showView:(UIView *)showView{
    self = [super init];
    
    if (self) {
    self.width = SCREENW;
    self.height = SCREENH;
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"popover_background"]];
        imageView.userInteractionEnabled = YES;
        imageView.width = view.width + 10;
        imageView.height = view.height + 20;
        view.x = 5;
        view.y = 10;
        [imageView addSubview:view];
        CGRect rect = [showView.superview convertRect:showView.frame toView:[UIApplication sharedApplication].keyWindow];
        imageView.centerX = CGRectGetMidX(rect);
        imageView.y = CGRectGetMaxY(rect);
        [self addSubview:imageView];
        
    [self addTarget:self action:@selector(popButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return  self;
}

- (void)popButtonClicked:(UIButton *)btn{
    NSLog(@"%s",__func__);
    [self removeFromSuperview];
}
@end
