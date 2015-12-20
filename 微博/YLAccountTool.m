//
//  YLAccountTool.m
//  微博
//
//  Created by tao on 15/12/6.
//  Copyright © 2015年 tao. All rights reserved.
//

#import "YLAccountTool.h"
#define filePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.achiver"]
@implementation YLAccountTool
+ (void)setAccount:(YLAccount *)account{
    //YLAccount *account = [[YLAccount alloc]init];
    //NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.achiver"];
    
    [NSKeyedArchiver archiveRootObject:account toFile:filePath];
}

+ (YLAccount *)account{

//    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    filePath =  [filePath stringByAppendingPathComponent:@"account.achiver"];
    YLAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    // 判断token是否过期,创建的时间＋有效期是否大于当前时间
    NSDate *expiresTime = [account.creat_time dateByAddingTimeInterval:account.expires_in];
    
    NSDate *currentTime = [NSDate date];
    
    NSComparisonResult result = [currentTime compare:expiresTime];
    
    if (result == NSOrderedAscending) {
        return  account;
    }
    return nil;
}
@end
