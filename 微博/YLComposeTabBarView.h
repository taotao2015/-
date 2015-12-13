//
//  YLComposeTabBarView.h
//  微博
//
//  Created by tao on 15/12/13.
//  Copyright © 2015年 tao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger ,ComposeTabBarViewButtonType){
    ComposeTabBarViewButtonTypeCamer,
    ComposeTabBarViewButtonTypePicture,
    ComposeTabBarViewButtonTypeMention,
    ComposeTabBarViewButtonTypeTrend,
    ComposeTabBarViewButtonTypeEmotion,

};
@interface YLComposeTabBarView : UIView
@property(copy,nonatomic)void (^buttonChilk)(ComposeTabBarViewButtonType type);
@end
