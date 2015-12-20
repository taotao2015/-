//
//  YLEmotionsTool.m
//  微博
//
//  Created by tao on 15/12/18.
//  Copyright © 2015年 tao. All rights reserved.
//微博 

#import "YLEmotionsTool.h"
#define recentEmotionsFile  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"recentEmotion"]

static NSMutableArray *_recentEmotions;

@implementation YLEmotionsTool


+ (void)initialize
{
    
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:recentEmotionsFile];
    _recentEmotions = [NSMutableArray arrayWithArray:array];
}
+ (void)addRecentEmotions:(YLEmotions *)emotions{
// 取出原来表情
    
//    NSArray *originalRecentEmotions = [NSKeyedUnarchiver unarchiveObjectWithFile:recentEmotionsFile];
//    NSMutableArray *recentEmotions = [NSMutableArray arrayWithArray:originalRecentEmotions];
//    
    
    //[recentEmotions addObject:emotions];
    [_recentEmotions removeObject:emotions];
    [_recentEmotions insertObject:emotions atIndex:0];
    
    [NSKeyedArchiver archiveRootObject:_recentEmotions toFile:recentEmotionsFile];
    NSLog(@"%@",recentEmotionsFile);
    
}
+ (NSArray *)recentEmotions{
   
    //return [NSKeyedUnarchiver unarchiveObjectWithFile:recentEmotionsFile];
    return  _recentEmotions;

}
@end
