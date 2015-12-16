//
//  YLEmotionButtonView.m
//  微博
//
//  Created by tao on 15/12/16.
//  Copyright © 2015年 tao. All rights reserved.
//

#import "YLEmotionButtonView.h"
#import "YLEmotions.h"
#import "NSString+Emoji.h"
@implementation YLEmotionButtonView
- (void)setEmotions:(NSArray *)emotions{

    _emotions = emotions;
    for (int i = 0; i < emotions.count; i++) {
        UIButton *button = [[UIButton alloc]init];
        //button.backgroundColor = randomColor;
        [button.titleLabel setFont:FONT(35)];
        YLEmotions *emotion = emotions[i];
        if (emotion.isEmoji) {
            [button setTitle:[emotion.code emoji] forState:UIControlStateNormal];
        }else{
            [button setImage:[UIImage imageNamed:emotion.fullPath] forState:UIControlStateNormal];
        }
        
        [self addSubview:button];
    }

}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat buttonW = self.width / MAX_CLO ;
    CGFloat buttonH = self.height / MAX_ROW ;
    for (int i = 0; i < self.subviews.count; i++) {
        UIView *button = self.subviews[i];
        button.width = buttonW;
        button.height = buttonH;
        int row = i / MAX_CLO;
        int col = i % MAX_CLO;
        
        button.x = col * buttonW;
        button.y = row * buttonH;
        
    }

}

@end
