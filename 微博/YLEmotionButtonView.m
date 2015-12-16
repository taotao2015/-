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
#import "UIButton+RemoveHighlightEffect.h"
#import "YLEmotionButton.h"
#import "YLPopView.h"
@interface YLEmotionButtonView()
@property(weak,nonatomic)UIButton *deleteBtn;

@property(copy,nonatomic)NSMutableArray *emotionButtons;
@end

@implementation YLEmotionButtonView

// 这个少不了，不然显示不出来表情
- (NSMutableArray *)emotionButtons{
    if (!_emotionButtons) {
        _emotionButtons = [NSMutableArray array];
        
    }
    return _emotionButtons;

}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *deleteBtn = [[UIButton alloc]init];
        [deleteBtn setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [deleteBtn setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [self addSubview:deleteBtn];
        self.deleteBtn = deleteBtn;
        
    }
    return self;
}


- (void)setEmotions:(NSArray *)emotions{

    _emotions = emotions;
    for (int i = 0; i < emotions.count; i++) {
        YLEmotionButton *button = [[YLEmotionButton alloc]init];
        [button addTarget:self action:@selector(selectEmotion:) forControlEvents:UIControlEventTouchUpInside];
        button.removeHighlightEffect = YES;
        //button.backgroundColor = randomColor;
        [button.titleLabel setFont:FONT(35)];
        button.emotion = emotions[i];
 //       YLEmotions *emotion = emotions[i];
//        if (emotion.isEmoji) {
//            [button setTitle:[emotion.code emoji] forState:UIControlStateNormal];
//        }else{
//            [button setImage:[UIImage imageNamed:emotion.fullPath] forState:UIControlStateNormal];
//        }
        
        [self addSubview:button];
        [self.emotionButtons addObject:button];
    }

}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat buttonW = self.width / MAX_CLO ;
    CGFloat buttonH = self.height / MAX_ROW ;
    for (int i = 0; i < self.emotionButtons.count; i++) {
        UIView *button = self.emotionButtons[i];
        button.width = buttonW;
        button.height = buttonH;
        int row = i / MAX_CLO;
        int col = i % MAX_CLO;
        
        button.x = col * buttonW;
        button.y = row * buttonH;
        
    }
    
    self.deleteBtn.size = CGSizeMake(buttonW, buttonH);
    self.deleteBtn.x = self.width - self.deleteBtn.width;
    self.deleteBtn.y = self.height - self.deleteBtn.height;

}

- (void)selectEmotion:(YLEmotionButton *)btn{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    YLPopView *popView = [YLPopView popView];
    popView.emotionButton.emotion = btn.emotion;
    [popView.emotionButton.titleLabel setFont:FONT(35)];
   CGRect rect = [btn convertRect:btn.bounds toView:window];
    popView.centerX = CGRectGetMidX(rect);
    popView.y = CGRectGetMidY(rect) - popView.height;
    [window addSubview:popView];
    
    //移除
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [popView removeFromSuperview];
    });

}

@end
