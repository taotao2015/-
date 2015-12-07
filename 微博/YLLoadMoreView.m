//
//  YLLoadMoreView.m
//  微博
//
//  Created by tao on 15/12/6.
//  Copyright © 2015年 tao. All rights reserved.
//

#import "YLLoadMoreView.h"

@implementation YLLoadMoreView

+ (instancetype)loadMoreView{
    return [[[NSBundle mainBundle]loadNibNamed:@"YLLoadMoreView" owner:nil options:nil] lastObject];

}

@end
