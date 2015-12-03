//
//  YLTabBarViewController.m
//  微博
//
//  Created by tao on 15/12/2.
//  Copyright © 2015年 tao. All rights reserved.
//

#import "YLTabBarViewController.h"
#import "YLPluseTabBar.h"
@interface YLTabBarViewController ()<YLPluseTabBarDelegate>

@end

@implementation YLTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    YLPluseTabBar *tabBar = [[YLPluseTabBar alloc]init];
    tabBar.delegate = self;
    [self setValue:tabBar forKeyPath:@"tabBar"];
    
    UITableViewController *homeController = [[UITableViewController alloc]init];
    [self addChildViewController:homeController imageName:@"tabbar_home" title:@"首页"];
    UITableViewController *messageController = [[UITableViewController alloc]init];
    [self addChildViewController:messageController imageName:@"tabbar_message_center" title:@"消息"];
    UITableViewController *discoverController = [[UITableViewController alloc]init];
    [self addChildViewController:discoverController imageName:@"tabbar_discover" title:@"发现"];
    UITableViewController *profileController = [[UITableViewController alloc]init];
    [self addChildViewController:profileController imageName:@"tabbar_profile" title:@"我"];
   // NSLog(@"%@",self.tabBar);
   
}


- (void)addChildViewController:(UIViewController *)childController imageName:(NSString *)imageName title:(NSString *)title{
    
    childController.title = title;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childController.tabBarItem setTitleTextAttributes:dic forState:UIControlStateSelected];
    childController.tabBarItem.image = [UIImage imageNamed:imageName];
   
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",imageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:childController];

}

-(void)tabBar:(YLPluseTabBar *)tabBar pluseBtnClicked:(UIButton *)btn{

    NSLog(@"%s",__func__);
}
@end
