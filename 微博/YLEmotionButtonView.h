//
//  YLEmotionButtonView.h
//  微博
//
//  Created by tao on 15/12/16.
//  Copyright © 2015年 tao. All rights reserved.
//

#import <UIKit/UIKit.h>
#define MAX_CLO 7
#define MAX_ROW 3
#define MAX_EMOTION (MAX_CLO * MAX_ROW - 1)

@interface YLEmotionButtonView : UIView

@property(copy,nonatomic)NSArray *emotions;
@end
