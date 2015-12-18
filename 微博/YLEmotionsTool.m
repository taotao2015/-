//
//  YLEmotionsTool.m
//  微博
//
//  Created by tao on 15/12/18.
//  Copyright © 2015年 tao. All rights reserved.
//

#import "YLEmotionsTool.h"
#define recentEmotionsFile  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingString:@"recentEmotions.archiver"]
@implementation YLEmotionsTool
+ (void)addRecentEmotions:(YLEmotions *)emotions{
// 取出原来表情
    NSArray *originalRecentEmotions = [NSKeyedUnarchiver unarchiveObjectWithFile:recentEmotionsFile];
    NSMutableArray *recentEmotions = [NSMutableArray arrayWithArray:originalRecentEmotions];
    [recentEmotions addObject:emotions];
    [NSKeyedArchiver archiveRootObject:recentEmotions toFile:recentEmotionsFile];
    NSLog(@"%@",recentEmotionsFile);
    
}
+ (NSArray *)recentEmotions{
   
    return [NSKeyedUnarchiver unarchiveObjectWithFile:recentEmotionsFile];

}
@end
