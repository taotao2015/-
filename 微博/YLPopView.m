//
//  YLPopView.m
//  微博
//
//  Created by tao on 15/12/17.
//  Copyright © 2015年 tao. All rights reserved.
//

#import "YLPopView.h"

@implementation YLPopView

+ (instancetype)popView{

    return [[[NSBundle mainBundle]loadNibNamed:@"YLPopView" owner:nil options:nil]lastObject];

}

- (void)showWithButton:(YLEmotionButton *)emotionButton{

    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    self.emotionButton.emotion = emotionButton.emotion;
    [self.emotionButton.titleLabel setFont:FONT(35)];
    CGRect rect = [emotionButton convertRect:emotionButton.bounds toView:window];
    self.centerX = CGRectGetMidX(rect);
    self.y = CGRectGetMidY(rect) - self.height;
    [window addSubview:self];


}

@end
