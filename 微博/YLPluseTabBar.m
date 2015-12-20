//
//  YLPluseTabBar.m
//  微博
//
//  Created by tao on 15/12/3.
//  Copyright © 2015年 tao. All rights reserved.
//

#import "YLPluseTabBar.h"

@interface YLPluseTabBar ()

@property(weak, nonatomic)UIButton *pluseBtn;
@end

@implementation YLPluseTabBar
@dynamic delegate;
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIButton *pluseButton = [[UIButton alloc]init];
        self.pluseBtn = pluseButton;
        [pluseButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [pluseButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [pluseButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [pluseButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
//        CGRect frame = pluseButton.frame;
//        frame.size = pluseButton.currentBackgroundImage.size;
//        pluseButton.frame = frame;
        pluseButton.size = pluseButton.currentBackgroundImage.size;
        [pluseButton addTarget:self action:@selector(pluseBtnClicked) forControlEvents:UIControlEventTouchUpInside];
       
        [self addSubview:pluseButton];
    }
    
    
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    NSInteger n = 0;
     CGFloat btnWidth = self.width * 0.2;
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            view.width = btnWidth;
            view.x = btnWidth * n;
            n++;
            if (n==2) {
                n++;
            }
            
        }
        
        //NSLog(@"%@",view);
    }
    
    self.pluseBtn.width = btnWidth;
    self.pluseBtn.x = btnWidth * 2;
    self.pluseBtn.y = 5;
}

-(void)pluseBtnClicked{

//    if ([self.delegate respondsToSelector:@selector(tabBar:pluseBtnClicked:)]) {
//        [self.delegate tabBar:self pluseBtnClicked:self.pluseBtn];
//    }
    
    if (self.pluseBlock) {
        self.pluseBlock();
    }
}

@end
