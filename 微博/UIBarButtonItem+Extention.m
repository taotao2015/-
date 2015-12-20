//
//  UIBarButtonItem+Extention.m
//  微博
//
//  Created by tao on 15/12/3.
//  Copyright © 2015年 tao. All rights reserved.
//

#import "UIBarButtonItem+Extention.h"

@implementation UIBarButtonItem (Extention)
+(instancetype)itemWithImageName:(NSString *)imageName addTarget:(id)target action:(SEL)action{

    UIButton *button = [[UIButton alloc]init];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_highlighted",imageName]] forState:UIControlStateHighlighted];
    button.size = button.currentImage.size;
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:button];
    
}


+(instancetype)itemWithImageName:(NSString *)imageName addTarget:(id)target action:(SEL)action title:(NSString *)title{

    UIButton *button = [[UIButton alloc]init];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_highlighted",imageName]] forState:UIControlStateHighlighted];
    
    [button setTitle:title forState:UIControlStateNormal];
    UIColor *color = RGB(68, 68, 68);
    
    [button setTitleColor:color forState:UIControlStateNormal];
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:button];

}

+ (instancetype)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action{
    
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    //设置不同状态下的文字颜色
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [button sizeToFit];
    
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}


@end
