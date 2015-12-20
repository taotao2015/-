//
//  YLEmotionTabBar.h
//  微博
//
//  Created by tao on 15/12/14.
//  Copyright © 2015年 tao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,YLEmotionTabBarButtonType) {
    YLEmotionTabBarButtonTypeRecent,
    YLEmotionTabBarButtonTypeDefault,
    YLEmotionTabBarButtonTypeEmoji,
    YLEmotionTabBarButtonTypeLxh,

};
@interface YLEmotionTabBar : UIView

@property (copy,nonatomic)void (^tabBarButtonClicked)(YLEmotionTabBarButtonType type);
@end
