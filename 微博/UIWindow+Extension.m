//
//  UIWindow+Extension.m
//  微博
//
//  Created by tao on 15/12/6.
//  Copyright © 2015年 tao. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "YLOauthViewController.h"
#import "YLAccount.h"
#import "YLTabBarViewController.h"
#import "YLAccountTool.h"
@implementation UIWindow (Extension)

- (void)switchRootController{

//    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    filePath =  [filePath stringByAppendingPathComponent:@"account.achiver"];
//    YLAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
//    // 判断token是否过期,创建的时间＋有效期是否大于当前时间
//   NSDate *expiresTime = [account.creat_time dateByAddingTimeInterval:account.expires_in];
//    
//    NSDate *currentTime = [NSDate date];
//    
//    NSComparisonResult result = [currentTime compare:expiresTime];
    
    
    YLAccount *account = [YLAccountTool account];
    
    if (account) {
        YLTabBarViewController *tableViewController = [[YLTabBarViewController alloc]init];
        
        self.rootViewController = tableViewController;
    }else {
        YLOauthViewController *oauth = [[YLOauthViewController alloc]init];
        self.rootViewController = oauth;
    
    }
    
//    if (!account) {
//        YLOauthViewController *oauth = [[YLOauthViewController alloc]init];
//        self.rootViewController = oauth;
//    } else{
//        YLTabBarViewController *tableViewController = [[YLTabBarViewController alloc]init];
//        
//        self.rootViewController = tableViewController;
//    }


}
@end
