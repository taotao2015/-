//
//  YLEmotionKuyboardView.m
//  微博
//
//  Created by tao on 15/12/14.
//  Copyright © 2015年 tao. All rights reserved.
//

#import "YLEmotionKuyboardView.h"
#import "YLEmotionTabBar.h"
#import "YLEmotionKeyboardListView.h"
@interface YLEmotionKuyboardView()
@property(strong,nonatomic)YLEmotionKeyboardListView *recentListView;
@property(strong,nonatomic)YLEmotionKeyboardListView *defaultListView;
@property(strong,nonatomic)YLEmotionKeyboardListView *emojiListView;
@property(strong,nonatomic)YLEmotionKeyboardListView *lxhListView;
@property(strong,nonatomic)YLEmotionKeyboardListView *currentView;
@property(weak,nonatomic)YLEmotionTabBar *tabBar;
@end

@implementation YLEmotionKuyboardView

- (YLEmotionKeyboardListView *)recentListView{
    if (!_recentListView) {
        _recentListView = [[YLEmotionKeyboardListView alloc]init];
    }
    return _recentListView;
}

- (YLEmotionKeyboardListView *)defaultListView{
    if (!_defaultListView) {
        _defaultListView = [[YLEmotionKeyboardListView alloc]init];
    }
    return _defaultListView;
}
- (YLEmotionKeyboardListView *)emojiListView{
    if (!_emojiListView) {
        _emojiListView = [[YLEmotionKeyboardListView alloc]init];
    }
    return _emojiListView;
}
- (YLEmotionKeyboardListView *)lxhListView{
    if (!_lxhListView) {
        _lxhListView = [[YLEmotionKeyboardListView alloc]init];
    }
    return _lxhListView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //self.backgroundColor = [UIColor yellowColor];
        YLEmotionTabBar *tabBar = [[YLEmotionTabBar alloc]init];
        [tabBar setTabBarButtonClicked:^(YLEmotionTabBarButtonType type) {
            [self selectImageViewWithType:type];
        }];
        [self addSubview:tabBar];
        self.tabBar = tabBar;
        self.currentView = self.defaultListView;
    }
    return self;
}

- (void)selectImageViewWithType:(NSUInteger)type{
    [self.currentView removeFromSuperview];
    switch (type) {
        case YLEmotionTabBarButtonTypeRecent:
            NSLog(@"recent");
            [self addSubview:self.recentListView];
            break;
        case YLEmotionTabBarButtonTypeDefault:
            NSLog(@"default");
            [self addSubview:self.defaultListView];
            break;
        case YLEmotionTabBarButtonTypeEmoji:
            NSLog(@"emoji");
            [self addSubview:self.emojiListView];
            break;
        case YLEmotionTabBarButtonTypeLxh:
            NSLog(@"lax");
            [self addSubview:self.lxhListView];
            break;
    }
    self.currentView = [self.subviews lastObject];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.tabBar.width = SCREENW;
    self.tabBar.height = 37;
    self.tabBar.y = self.height - self.tabBar.height;
    self.currentView.width = self.width;
    self.currentView.height = self.tabBar.y;
    
}

@end
