//
//  YLEmotionTabBar.m
//  微博
//
//  Created by tao on 15/12/14.
//  Copyright © 2015年 tao. All rights reserved.
//

#import "YLEmotionTabBar.h"
#import "YLEmotionTabBarButton.h"
@interface YLEmotionTabBar()

@property(weak,nonatomic)YLEmotionTabBarButton *currentButton;
@end

@implementation YLEmotionTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addChildButtonWithTitle:@"最近" bgImageName:@"compose_emotion_table_left" type:YLEmotionTabBarButtonTypeRecent];
        [self addChildButtonWithTitle:@"默认" bgImageName:@"compose_emotion_table_mid" type: YLEmotionTabBarButtonTypeDefault];
        [self addChildButtonWithTitle:@"Emoji" bgImageName:@"compose_emotion_table_mid" type:YLEmotionTabBarButtonTypeEmoji];
        //[self addChildButtonWithTitle:@"浪小花" bgImageName:@"compose_emotion_table_right" type:];
        [self addChildButtonWithTitle:@"浪小花" bgImageName:@"compose_emotion_table_right" type:YLEmotionTabBarButtonTypeLxh];
       YLEmotionTabBarButton *button = [self viewWithTag:YLEmotionTabBarButtonTypeDefault];
        button.enabled = NO;
        self.currentButton = button;
    }
    return self;
}

- (void)addChildButtonWithTitle:(NSString *)title bgImageName:(NSString *)bgImageName type:(YLEmotionTabBarButtonType)type{

    YLEmotionTabBarButton *button = [[YLEmotionTabBarButton alloc]init];
    button.tag = type;
    [button setTitle:title forState:UIControlStateNormal];

    [button setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
    
    [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",bgImageName]] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",bgImageName]] forState:UIControlStateDisabled];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
}

- (void)setTabBarButtonClicked:(void (^)(YLEmotionTabBarButtonType))tabBarButtonClicked{
    _tabBarButtonClicked = tabBarButtonClicked;
    

}

- (void)layoutSubviews{
    [super layoutSubviews];
    NSInteger count = self.subviews.count;
    NSInteger buttonW = SCREENW / count;
    for (int i = 0; i < count; i++) {
        
        YLEmotionTabBarButton *button = self.subviews[i];
        button.width = buttonW;
        button.height = self.height;
        button.x = i * buttonW;
        //[button sizeToFit];
    }

}

- (void)buttonClicked:(UIButton *)btn{
    self.currentButton.enabled = YES;
    btn.enabled = NO;
    self.currentButton = (YLEmotionTabBarButton *)btn;
    if (self.tabBarButtonClicked) {
        self.tabBarButtonClicked(btn.tag);
    }
}

@end
