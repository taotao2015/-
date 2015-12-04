//
//  YLFearcherViewController.m
//  微博
//
//  Created by tao on 15/12/4.
//  Copyright © 2015年 tao. All rights reserved.
//

#import "YLFearcherViewController.h"
#import "YLTabBarViewController.h"
@interface YLFearcherViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic)UIPageControl *pageControl;
@end

@implementation YLFearcherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     NSUInteger count = 4;
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    self.pageControl = pageControl;
    pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    pageControl.pageIndicatorTintColor = [UIColor blackColor];
    pageControl.numberOfPages = count;
    pageControl.centerX = SCREENW * 0.5;
    pageControl.centerY = SCREENH - 50;
    [self.view addSubview:pageControl];
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    scrollView.userInteractionEnabled = YES;
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
   
    for (int i = 0; i < count; i++) {
        NSString *imageName = [NSString stringWithFormat:@"new_feature_%d",i + 1];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
        imageView.userInteractionEnabled = YES;
        imageView.x = SCREENW * i;
        imageView.size = self.view.bounds.size;
        [scrollView addSubview:imageView];
        if (i == count - 1) {
            [self showClickeBtn:imageView];
            [self showShareBtn:imageView];
        }
    }
    scrollView.contentSize = CGSizeMake(SCREENW * count, 0);
    
    [self.view insertSubview:scrollView belowSubview:pageControl];
}

// 添加进入微博按钮
- (void)showClickeBtn:(UIImageView *)imageView{

    UIButton *button = [[UIButton alloc]init];
    [button setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [button setTitle:@"进入微博" forState:UIControlStateNormal];
    button.size = button.currentBackgroundImage.size;
    button.centerX = SCREENW * 0.5;
    button.centerY = SCREENH - 100;
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:button];

}

// 添加分享按钮
- (void)showShareBtn:(UIImageView *)imageView{
    UIButton *shareBtn = [[UIButton alloc]init];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateSelected];
   
    [shareBtn setTitle:@"微博分享" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    //先要调整大小
    [shareBtn sizeToFit];
    //然后设置位置
    shareBtn.centerX = SCREENW * 0.5;
    shareBtn.centerY = SCREENH - 140;
    [shareBtn addTarget:self action:@selector(shareBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:shareBtn];
}

- (void)buttonClicked:(UIButton *)btn{

    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    YLTabBarViewController *tabBarController = [[YLTabBarViewController alloc]init];
    window.rootViewController = tabBarController;
}

- (void)shareBtnClicked:(UIButton *)btn{
    btn.selected = !btn.selected;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"%f",scrollView.contentOffset.x);
    self.pageControl.currentPage = scrollView.contentOffset.x / SCREENW;
}

@end
