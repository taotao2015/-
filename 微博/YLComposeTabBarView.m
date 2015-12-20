//
//  YLComposeTabBarView.m
//  微博
//
//  Created by tao on 15/12/13.
//  Copyright © 2015年 tao. All rights reserved.
//

#import "YLComposeTabBarView.h"

@implementation YLComposeTabBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        [self addChildButtonWithImageName:@"compose_camerabutton_background" type:ComposeTabBarViewButtonTypeCamer];
        [self addChildButtonWithImageName:@"compose_toolbar_picture" type:ComposeTabBarViewButtonTypePicture];
        [self addChildButtonWithImageName:@"compose_mentionbutton_background" type:ComposeTabBarViewButtonTypeMention];
        [self addChildButtonWithImageName:@"compose_trendbutton_background" type:ComposeTabBarViewButtonTypeTrend];
        [self addChildButtonWithImageName:@"compose_emoticonbutton_background" type:ComposeTabBarViewButtonTypeEmotion];
    }
    return self;
}

- (void)addChildButtonWithImageName:(NSString *)imageName type:(ComposeTabBarViewButtonType)type{
    UIButton *childButton = [[UIButton alloc]init];
    [childButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [childButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_highlighted",imageName]]forState:UIControlStateHighlighted];
    [self addSubview:childButton];
    // 标注tag
    childButton.tag = type;
    
    [childButton addTarget:self action:@selector(childButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)childButtonClicked:(UIButton *)btn{
    if (self.buttonChilk) {
        self.buttonChilk(btn.tag);
    }

}

- (void)setIsSystermKeyboard:(BOOL)isSystermKeyboard{
    _isSystermKeyboard = isSystermKeyboard;
    UIButton *button = [self viewWithTag:ComposeTabBarViewButtonTypeEmotion];
    if (isSystermKeyboard) {
        
        [button setImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] forState:UIControlStateHighlighted];
    }else{
        [button setImage:[UIImage imageNamed:@"compose_keyboardbutton_background"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"compose_keyboardbutton_background_highlighted"] forState:UIControlStateHighlighted];
    
    }

}

- (void)layoutSubviews{
    [super layoutSubviews];
    NSInteger count = self.subviews.count;
    CGFloat buttonW = SCREENW / count;
    for (int i = 0; i < count; i++) {
        UIButton *button = [self.subviews objectAtIndex:i];
        button.size = CGSizeMake(buttonW, self.height);
        button.x = i * buttonW;
        
    }

}

@end
