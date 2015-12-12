//
//  YLComposeViewButton.h
//  微博
//
//  Created by tao on 15/12/11.
//  Copyright © 2015年 tao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "POP.h"
typedef NS_ENUM(NSUInteger, YLComposeViewButtonType){
    YLComposeViewButtonTypeUp,
    YLComposeViewButtonTypeDown,
};
@interface YLComposeViewButton : UIButton
- (void)animationWithType:(YLComposeViewButtonType)type count:(NSInteger)count;
@end
