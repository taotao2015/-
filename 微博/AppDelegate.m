//
//  AppDelegate.m
//  微博
//
//  Created by tao on 15/12/2.
//  Copyright © 2015年 tao. All rights reserved.
//

#import "AppDelegate.h"
#import "YLTabBarViewController.h"
#import "YLFearcherViewController.h"
#import "YLOauthViewController.h"
#import "YLAccount.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    // 版本更新首先进入新特性，判断有没登录，没有登录，进入登录，有就进入主页
    
    
   YLTabBarViewController *tableViewController = [[YLTabBarViewController alloc]init];
    YLFearcherViewController *fearcherViewController = [[YLFearcherViewController alloc]init];
    
    NSDictionary *infoDic = [NSBundle mainBundle].infoDictionary;
    NSString *currentVersion = infoDic[@"CFBundleShortVersionString"];
    
    NSString *saveVersion = [[NSUserDefaults standardUserDefaults] valueForKey:KCFBundleShortVersionString];
   NSComparisonResult result = [currentVersion compare:saveVersion];
    if (!saveVersion || result == NSOrderedDescending) {
        self.window.rootViewController = fearcherViewController;
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:KCFBundleShortVersionString];
    } else{
        
//        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//        filePath =  [filePath stringByAppendingPathComponent:@"account.achiver"];
//        
//        YLAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
//        
//        if (!account) {
//            YLOauthViewController *oauth = [[YLOauthViewController alloc]init];
//            self.window.rootViewController = oauth;
//        } else{
//             self.window.rootViewController = tableViewController;
//        }
        [self.window switchRootController];
        
    }
    
//    YLOauthViewController *oauth = [[YLOauthViewController alloc]init];
//    self.window.rootViewController = oauth;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
