//
//  YLhomeCellTabBarView.m
//  微博
//
//  Created by tao on 15/12/7.
//  Copyright © 2015年 tao. All rights reserved.
//

#import "YLhomeCellTabBarView.h"

@interface YLhomeCellTabBarView()

@property(copy,nonatomic)NSMutableArray *childButtons;
@property(copy,nonatomic)NSMutableArray *chlidLines;
@end

@implementation YLhomeCellTabBarView

- (NSMutableArray *)childButtons{
    if (_childButtons == nil) {
        _childButtons = [NSMutableArray array];
    }
    return  _childButtons;
}

- (NSMutableArray *)chlidLines{
    if (_chlidLines == nil) {
        _chlidLines = [NSMutableArray array];
    }
    return  _chlidLines;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addChildButtonWithImage:@"timeline_icon_retweet" title:@"转发"];
        [self addChildButtonWithImage:@"timeline_icon_comment" title:@"评论"];
        [self addChildButtonWithImage:@"timeline_icon_unlike" title:@"赞"];
        [self addLine];
        [self addLine];
        
    }
    return self;
}


- (void)addChildButtonWithImage:(NSString *)imageName title:(NSString *)title{

    UIButton *button = [[UIButton alloc]init];
    //[button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    //[button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_highlighted",imageName]] forState:UIControlStateHighlighted];
    [button setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_background_highlighted"] forState:UIControlStateHighlighted];
    [button setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_background"] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    
//    [button setTintColor:[UIColor blackColor]];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    button.titleLabel.font = FONT(15);
    [self addSubview:button];
    [self.childButtons addObject:button];
}

- (void)addLine{
    UIImageView *line = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line"] highlightedImage:[UIImage imageNamed:@"timeline_card_bottom_line_highlighted"]];
    [self addSubview:line];
    
    [self.chlidLines addObject:line];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat buttonW = SCREENW / self.childButtons.count;
    for (int i = 0; i < self.childButtons.count; i++) {
        UIView *view = self.childButtons[i];
        view.x = buttonW * i;
        view.width = buttonW;
        view.height = self.height;
    }
    
    for (int j = 0; j < self.chlidLines.count; j++) {
        UIView *view = self.chlidLines[j];
        view.x = buttonW * (j + 1) - view.width * 0.5;
    }

}

@end
