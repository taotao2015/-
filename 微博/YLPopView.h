//
//  YLPopView.h
//  微博
//
//  Created by tao on 15/12/17.
//  Copyright © 2015年 tao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLEmotionButton.h"
@interface YLPopView : UIView
@property (weak, nonatomic) IBOutlet YLEmotionButton *emotionButton;
+ (instancetype)popView;

- (void)showWithButton:(YLEmotionButton *)emotionButton;
@end
