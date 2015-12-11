//
//  YLTabBarViewController.m
//  微博
//
//  Created by tao on 15/12/2.
//  Copyright © 2015年 tao. All rights reserved.
//

#import "YLTabBarViewController.h"
#import "YLPluseTabBar.h"
#import "YLhomeTableViewController.h"
#import "YLdiscoverController.h"
#import "YLNavigationController.h"
#import "YLtabBarItem.h"
#import "YLComposeView.h"
@interface YLTabBarViewController ()<YLPluseTabBarDelegate>

@end

@implementation YLTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    YLPluseTabBar *tabBar = [[YLPluseTabBar alloc]init];
    //tabBar.delegate = self;
    [tabBar setPluseBlock:^{
        [self addComposeView];
    }];
    
    [self setValue:tabBar forKeyPath:@"tabBar"];
    
    YLhomeTableViewController *homeController = [[YLhomeTableViewController alloc]init];
    [self addChildViewController:homeController imageName:@"tabbar_home" title:@"首页"];
    UITableViewController *messageController = [[UITableViewController alloc]init];
    [self addChildViewController:messageController imageName:@"tabbar_message_center" title:@"消息"];
    YLdiscoverController *discoverController = [[YLdiscoverController alloc]init];
    [self addChildViewController:discoverController imageName:@"tabbar_discover" title:@"发现"];
    UITableViewController *profileController = [[UITableViewController alloc]init];
    [self addChildViewController:profileController imageName:@"tabbar_profile" title:@"我"];
   // NSLog(@"%@",self.tabBar);
       
}


- (void)addChildViewController:(UIViewController *)childController imageName:(NSString *)imageName title:(NSString *)title{
    
    YLtabBarItem *tabBarItem = [[YLtabBarItem alloc]init];
    childController.tabBarItem = tabBarItem;
    childController.title = title;
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childController.tabBarItem setTitleTextAttributes:dic forState:UIControlStateSelected];
    childController.tabBarItem.image = [UIImage imageNamed:imageName];
   
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",imageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    YLNavigationController *navController = [[YLNavigationController alloc]initWithRootViewController:childController];
    
    [self addChildViewController:navController];

}

-(void)tabBar:(YLPluseTabBar *)tabBar pluseBtnClicked:(UIButton *)btn{

    NSLog(@"%s",__func__);
}

- (void)addComposeView{
    YLComposeView *compose = [[YLComposeView alloc]init];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:compose];

}


@end
