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

- (void)setEmotion:(YLEmotions *)emotion{
    _emotion = emotion;
    
    if (emotion.isEmoji) {
        [self setTitle:[emotion.code emoji] forState:UIControlStateNormal];
    }else{
        [self setImage:[UIImage imageNamed:emotion.fullPath] forState:UIControlStateNormal];
    }
    
    
}

@end
