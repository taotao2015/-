//
//  YLPluseTabBar.h
//  微博
//
//  Created by tao on 15/12/3.
//  Copyright © 2015年 tao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YLPluseTabBar;
@protocol YLPluseTabBarDelegate <NSObject,UITabBarDelegate>

-(void)tabBar:(YLPluseTabBar *)tabBar pluseBtnClicked:(UIButton *)btn;

@end

@interface YLPluseTabBar : UITabBar
@property(weak, nonatomic)id<YLPluseTabBarDelegate> delegate;
@property(copy, nonatomic)void (^pluseBlock)();
@end
