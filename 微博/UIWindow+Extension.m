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
@implementation UIWindow (Extension)

- (void)switchRootController{

    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    filePath =  [filePath stringByAppendingPathComponent:@"account.achiver"];
    YLAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    
    if (!account) {
        YLOauthViewController *oauth = [[YLOauthViewController alloc]init];
        self.rootViewController = oauth;
    } else{
        YLTabBarViewController *tableViewController = [[YLTabBarViewController alloc]init];
        
        self.rootViewController = tableViewController;
    }


}
@end
