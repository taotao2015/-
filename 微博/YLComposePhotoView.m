//
//  YLComposePhotoView.m
//  微博
//
//  Created by tao on 15/12/13.
//  Copyright © 2015年 tao. All rights reserved.
//

#import "YLComposePhotoView.h"

@interface YLComposePhotoView()

@property(weak,nonatomic)UIButton *button;

@end

@implementation YLComposePhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        UIButton *button = [[UIButton alloc]init];
        self.button = button;
        [button setImage:[UIImage imageNamed:@"compose_photo_close"] forState:UIControlStateNormal];
        [button sizeToFit];
        [button addTarget:self action:@selector(deleMethod:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    return self;
}

- (void)deleMethod:(UIButton *)btn{

    [self removeFromSuperview];

}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.button.x = self.width - self.button.width;

}

@end
