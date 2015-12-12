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
#import "POP.h"
#import "YLComposeViewController.h"
#import "YLNavigationController.h"
@interface YLComposeView()
@property(strong,nonatomic)NSMutableArray *childButtons;
@property(strong,nonatomic)UIViewController *target;
@end

@implementation YLComposeView

- (instancetype)initWithTarget:(UIViewController *)target{

    self = [super init];
    if (self) {
        self.target = target;
    }
    return self;
}

- (NSMutableArray *)childButtons{
    if (!_childButtons) {
        _childButtons = [NSMutableArray array];
    }

    return _childButtons;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.size = CGSizeMake(SCREENW, SCREENH);
        UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        bgImageView.image = [[self screenImage] applyLightEffect];
        [self addSubview:bgImageView];
        
        UIImageView *sloganView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"compose_slogan"]];
        //sloganView.image = [UIImage imageNamed:@"compose_slogan"];
        sloganView.x = 100;
        sloganView.y = 100;
        //[self addSubview:sloganView];
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
        [childButton addTarget:self action:@selector(menuButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        childButton.x = childW * col + childButtonMargin * (col + 1);
        childButton.y = (childH + childButtonMargin) * row + SCREENH ;
        [self addSubview:childButton];
        
        [self.childButtons addObject:childButton];
    }

}
- (void)menuButtonClick:(YLComposeViewButton *)btn{
    
    
    
[UIView animateWithDuration:0.25 animations:^{
    
    [self.childButtons enumerateObjectsUsingBlock:^(YLComposeViewButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj==btn) {
            obj.transform = CGAffineTransformMakeScale(1.5, 1.5);
            
        }else{
            obj.transform = CGAffineTransformMakeScale(0.3, 0.3);
        }
        obj.alpha = 0.3;
    }];
    
} completion:^(BOOL finished) {
    
    [self.childButtons enumerateObjectsUsingBlock:^(YLComposeViewButton  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.transform = CGAffineTransformIdentity;
        obj.alpha = 1;
    }];
    YLComposeViewController *composeController = [[YLComposeViewController alloc]init];
[self.target presentViewController:[[YLNavigationController alloc]initWithRootViewController:composeController] animated:YES completion:^{
    [self removeFromSuperview];

}];
    
}];


};

- (void)show{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    [self startAnimaion];
}

- (void)startAnimaion{
[self.childButtons enumerateObjectsUsingBlock:^(YLComposeViewButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
    [obj animationWithType:YLComposeViewButtonTypeUp count:idx];
//    POPSpringAnimation *pop = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
//    pop.toValue = [NSValue valueWithCGPoint:CGPointMake(obj.centerX,obj.centerY - 350 )];
//    pop.springBounciness = 12;
//    pop.springSpeed = 9;
//    pop.beginTime = CACurrentMediaTime() + 0.025 * idx ;
//    [obj pop_addAnimation:pop forKey:nil];
    
}];

};

- (void)hide{
    NSArray *menuButtons = [self.childButtons reverseObjectEnumerator].allObjects;
    

    [menuButtons enumerateObjectsUsingBlock:^(YLComposeViewButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [obj animationWithType:YLComposeViewButtonTypeDown count:idx];
        
//        POPSpringAnimation *pop = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
//        pop.toValue = [NSValue valueWithCGPoint:CGPointMake(obj.centerX,obj.centerY + 350 )];
//        pop.springBounciness = 12;
//        pop.springSpeed = 9;
//        pop.beginTime = CACurrentMediaTime() + 0.25 * idx ;
//        [obj pop_addAnimation:pop forKey:nil];
        
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });

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

    [self hide];
}

@end
