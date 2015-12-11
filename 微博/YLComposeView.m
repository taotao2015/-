//
//  YLComposeView.m
//  微博
//
//  Created by tao on 15/12/11.
//  Copyright © 2015年 tao. All rights reserved.
//

#import "YLComposeView.h"
#import "YLComposeViewButton.h"
#import "YLComposeButtonInfo.h"
@implementation YLComposeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.size = CGSizeMake(SCREENW, SCREENH);
        UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        bgImageView.image = [[self screenImage] applyLightEffect];
        [self addSubview:bgImageView];
        // 添加子控件的按钮
        [self addChildButton];
        
    }
    return self;
}


// 添加自控件按钮
- (void)addChildButton{
    CGFloat childH = 110;
    CGFloat childW = 80;
    CGFloat childButtonMargin = (SCREENW - childW * 3) / 4;
    //NSArray *buttonPlist = [NSArray arrayWithContentsOfFile:[NSBundle mainBundle]]
    
    //NSArray *buttonMenue = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"compose" ofType:@"plist"]];
    NSArray *buttonMenue = [YLComposeButtonInfo objectArrayWithFilename:@"compose.plist"];
    for (int i = 0; i < 6; i++) {
        YLComposeViewButton *childButton = [[YLComposeViewButton alloc]init];
        YLComposeButtonInfo *button = buttonMenue[i];
        [childButton setImage:[UIImage imageNamed:button.icon] forState:UIControlStateNormal];
        [childButton setTitle:button.title forState:UIControlStateNormal];
        NSInteger col = i % 3;
        NSInteger row = i / 3;
        childButton.width = childW;
        childButton.height = childH;
       
        childButton.x = childW * col + childButtonMargin * (col + 1);
        childButton.y = (childH + childButtonMargin) * row + SCREENH;
        [self addSubview:childButton];
        
    }

}

-(UIImage *)screenImage{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIGraphicsBeginImageContext(window.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [window.layer renderInContext:context];
   UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self removeFromSuperview];
}

@end
