//
//  YLEmotionButton.m
//  微博
//
//  Created by tao on 15/12/17.
//  Copyright © 2015年 tao. All rights reserved.
//

#import "YLEmotionButton.h"
#import "YLEmotions.h"
#import "NSString+Emoji.h"
@implementation YLEmotionButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

//做一些当前控件初始化的逻辑
- (void)setup{
    self.titleLabel.font = [UIFont systemFontOfSize:35];
}


- (void)setEmotion:(YLEmotions *)emotion{
    _emotion = emotion;
    
    if (emotion.isEmoji) {
        [self setTitle:[emotion.code emoji] forState:UIControlStateNormal];
    }else{
        [self setImage:[UIImage imageNamed:emotion.fullPath] forState:UIControlStateNormal];
    }
    
    
}

@end
