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
#import "YLEmotionsTool.h"
@interface YLEmotionButtonView()
@property(weak,nonatomic)UIButton *deleteBtn;

@property(copy,nonatomic)NSMutableArray *emotionButtons;

@property(weak,nonatomic)YLPopView *popView;
@end

@implementation YLEmotionButtonView

// 这个少不了，不然显示不出来表情
- (NSMutableArray *)emotionButtons{
    if (!_emotionButtons) {
        _emotionButtons = [NSMutableArray array];
        
    }
    return _emotionButtons;

}
- (YLPopView *)popView{

    if (!_popView) {
        _popView = [YLPopView popView];
        
    }
    return _popView;
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
        [deleteBtn addTarget:self action:@selector(deleteClicke:) forControlEvents:UIControlEventTouchUpInside];
        // 给当前的view添加一个长按手势
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]init];
        [longPress addTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:longPress];
        
    }
    return self;
}


- (void)longPress:(UILongPressGestureRecognizer *)longPress{
    
    NSLog(@"打出来了吗");
    if (longPress.state == UIGestureRecognizerStateBegan || longPress.state == UIGestureRecognizerStateChanged ) {
        CGPoint point = [longPress locationInView:self];
        
//        __block YLEmotionButton *resultButton = nil;
//        [self.emotionButtons enumerateObjectsUsingBlock:^(YLEmotionButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
//          BOOL result = CGRectContainsPoint(obj.frame, point);
//            if (result) {
//                resultButton = obj;
//                *stop = YES;
//            }
//            
//        }];
        
        YLEmotionButton *resultButton = [self buttonWithPoint:point];
        
        if (resultButton) {
//            UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
//            // 这是一次着了较长时间的bug，今后必须注意，只有懒加载才只有一个视图view ,产生相应效果
//            
////            YLPopView *popView = [YLPopView popView];
////            self.popView = popView;
//            self.popView.emotionButton.emotion = resultButton.emotion;
//            [self.popView.emotionButton.titleLabel setFont:FONT(35)];
//            CGRect rect = [resultButton convertRect:resultButton.bounds toView:window];
//            self.popView.centerX = CGRectGetMidX(rect);
//            self.popView.y = CGRectGetMidY(rect) - self.popView.height;
//            [window addSubview:self.popView];
            
            [self.popView showWithButton:resultButton];
            
            
        }
        
        
    }else {
        
        [self.popView removeFromSuperview];
        
    }

}


- (YLEmotionButton *)buttonWithPoint:(CGPoint)point{


    __block YLEmotionButton *resultButton = nil;
    [self.emotionButtons enumerateObjectsUsingBlock:^(YLEmotionButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL result = CGRectContainsPoint(obj.frame, point);
        if (result) {
            resultButton = obj;
            *stop = YES;
        }
        
    }];
    
    return resultButton;

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
    //UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    YLPopView *popView = [YLPopView popView];
//    popView.emotionButton.emotion = btn.emotion;
//    [popView.emotionButton.titleLabel setFont:FONT(35)];
//   CGRect rect = [btn convertRect:btn.bounds toView:window];
//    popView.centerX = CGRectGetMidX(rect);
//    popView.y = CGRectGetMidY(rect) - popView.height;
//    [window addSubview:popView];
    [popView showWithButton:btn];
    
    //移除
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [popView removeFromSuperview];
    });
    // 保存最近表情
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"emotion"] = btn.emotion;
    [YLEmotionsTool addRecentEmotions:btn.emotion];
       //发一个表情点击的通知，并将表情按钮对应的模型信息，传递出去
    [[NSNotificationCenter defaultCenter]postNotificationName:emotionDidSelected object:nil userInfo:dic];
    [[NSNotificationCenter defaultCenter]postNotificationName:UITextViewTextDidChangeNotification object:nil];
    

}

- (void)deleteClicke:(UIButton *)btn{


    [[NSNotificationCenter defaultCenter]postNotificationName:deleteBtnClicke object:nil];

}

@end
