
//
//  YLEmotionKeyboardListView.m
//  微博
//
//  Created by tao on 15/12/14.
//  Copyright © 2015年 tao. All rights reserved.
//

#import "YLEmotionKeyboardListView.h"
@interface YLEmotionKeyboardListView()

@property(weak,nonatomic)UIPageControl *pageControl;
@property(weak,nonatomic)UIScrollView *scrollView;
@end

@implementation YLEmotionKeyboardListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = randomColor;
        UIPageControl *pageControl = [[UIPageControl alloc]init];
        pageControl.backgroundColor = randomColor;
        self.pageControl = pageControl;
    //这里的_currentPageImage怎么找不到呢
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKeyPath:@"_currentPageImage"];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKeyPath:@"_pageImage"];
        [self addSubview:pageControl];
        
        UIScrollView *scrollView = [[UIScrollView alloc]init];
        scrollView.backgroundColor = randomColor;
        self.scrollView = scrollView;
        [self addSubview:scrollView];
        
    }
    return self;
}

- (void)setEmotions:(NSArray *)emotions{
    _emotions = emotions;
    self.pageControl.numberOfPages = (emotions.count + 20 - 1) / 20;

}

- (void)layoutSubviews{

    [super layoutSubviews];
    self.pageControl.width = self.width;
    self.pageControl.height = 44;
    self.pageControl.y = self.height - self.pageControl.height;
    self.scrollView.width = self.width;
    self.scrollView.height = self.pageControl.y;
}

@end
