//
//  YLNavigationController.m
//  微博
//
//  Created by tao on 15/12/3.
//  Copyright © 2015年 tao. All rights reserved.
//

#import "YLNavigationController.h"

@interface YLNavigationController ()

@end

@implementation YLNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {

NSString *title = @"返回";
    if (self.childViewControllers.count == 1) {
        title = [[self.childViewControllers firstObject] title];
    }
    
    if (self.childViewControllers.count) {
        
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_back_withtext" addTarget:self action:@selector(back) title:title];
    }
    
    [super pushViewController:viewController animated:YES];
}


- (void)back{

    [self popToRootViewControllerAnimated:YES];
}
@end
