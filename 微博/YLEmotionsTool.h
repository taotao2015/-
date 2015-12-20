//
//  YLEmotionsTool.h
//  微博
//
//  Created by tao on 15/12/18.
//  Copyright © 2015年 tao. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YLEmotions;
@interface YLEmotionsTool : NSObject
+ (void)addRecentEmotions:(YLEmotions *)emotions;
+ (NSArray *)recentEmotions;
@end
