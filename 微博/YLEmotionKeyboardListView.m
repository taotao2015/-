
//
//  YLEmotionKeyboardListView.m
//  微博
//
//  Created by tao on 15/12/14.
//  Copyright © 2015年 tao. All rights reserved.
//

#import "YLEmotionKeyboardListView.h"
#import "YLEmotionButtonView.h"
@interface YLEmotionKeyboardListView()<UIScrollViewDelegate>

@property(weak,nonatomic)UIPageControl *pageControl;
@property(weak,nonatomic)UIScrollView *scrollView;
@property(copy,nonatomic)NSMutableArray *scrollChildView;

@end

@implementation YLEmotionKeyboardListView

- (NSMutableArray *)scrollChildView{

    if (!_scrollChildView) {
        _scrollChildView = [NSMutableArray array];
    }
    return _scrollChildView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //self.backgroundColor = randomColor;
        UIPageControl *pageControl = [[UIPageControl alloc]init];
        pageControl.backgroundColor = randomColor;
        self.pageControl = pageControl;
    //这里的_currentPageImage怎么找不到呢
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKeyPath:@"_currentPageImage"];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKeyPath:@"_pageImage"];
        [self addSubview:pageControl];
        
        UIScrollView *scrollView = [[UIScrollView alloc]init];
        scrollView.delegate = self;
       // scrollView.backgroundColor = randomColor;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;
        scrollView.bounces = NO;
        self.scrollView = scrollView;
        [self addSubview:scrollView];
        
    }
    return self;
}

- (void)setEmotions:(NSArray *)emotions{
    _emotions = emotions;
    [self.scrollChildView removeAllObjects];
    [self.scrollChildView makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSUInteger page = (emotions.count + MAX_EMOTION - 1) / MAX_EMOTION;
    
    for (int i = 0; i < page; i++) {
        NSRange range;
        range.location = i * MAX_EMOTION;
        range.length = MAX_EMOTION;
        if ((range.location + range.length) > emotions.count) {
            range.length = emotions.count - range.location;
        }
        
        NSArray *subEmotions = [emotions subarrayWithRange:range];
        
        YLEmotionButtonView *childView = [[YLEmotionButtonView alloc]init];
       // childView.backgroundColor = randomColor;
        childView.emotions = subEmotions;
        [self.scrollView addSubview:childView];
        [self.scrollChildView addObject:childView];
    }
    if (page==1) {
        self.pageControl.hidesForSinglePage = YES;
    }
    self.pageControl.numberOfPages = page;
    [self setNeedsLayout];
}

- (void)layoutSubviews{

    [super layoutSubviews];
    self.pageControl.width = self.width;
    self.pageControl.height = 44;
    self.pageControl.y = self.height - self.pageControl.height;
    self.scrollView.width = self.width;
    self.scrollView.height = self.pageControl.y;
    for (int i = 0; i < self.scrollChildView.count; i++) {
        UIView *childView = self.scrollChildView[i];
        childView.size = self.scrollView.size;
        childView.x = i * self.scrollView.width;
    }
    
    self.scrollView.contentSize = CGSizeMake(self.scrollChildView.count * self.width, 0);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

//self.pageControl.currentPage = scrollView.contentOffset.x / self.width;
    //先计算出当前偏移页数的小数
    CGFloat page = scrollView.contentOffset.x / scrollView.width;
    //再把小数四舍五入（加0.5转成整数）
    NSInteger pageNum = (int)(page + 0.5);
        if (self.pageControl.currentPage != pageNum) {
        self.pageControl.currentPage = pageNum;
    }


}

@end
