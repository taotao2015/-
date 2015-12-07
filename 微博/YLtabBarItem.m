//
//  YLtabBarItem.m
//  微博
//
//  Created by tao on 15/12/7.
//  Copyright © 2015年 tao. All rights reserved.
//

#import "YLtabBarItem.h"
#import <objc/runtime.h>
@implementation YLtabBarItem
- (void)setBadgeValue:(NSString *)badgeValue{
    [super setBadgeValue:badgeValue];
    UITabBarController *tabBarCtrl = [self valueForKeyPath:@"_target"];
    
    for (UIView *childTabBarButton in tabBarCtrl.tabBar.subviews) {
        if ([childTabBarButton isKindOfClass:[NSClassFromString(@"UITabBarButton") class]]) {
            for (UIView *childBadgeView in childTabBarButton.subviews) {
                
                if ([childBadgeView isKindOfClass:[NSClassFromString(@"_UIBadgeView") class]]) {
                    
                    for (UIView *childBadgeBackGround in childBadgeView.subviews) {
                        
                        if ([childBadgeBackGround isKindOfClass:[NSClassFromString(@"_UIBadgeBackground") class]] ) {
                            
                            //NSLog(@"%@",childBadgeBackGround);
                            unsigned int count;
                            Ivar * ivars = class_copyIvarList([childBadgeBackGround class], &count);
                            for (int i = 0; i < count; i++) {
                                
                                Ivar ivar =ivars[i];
                                //获取属性的名字
                                NSString *ivarName = [NSString stringWithCString:ivar_getName(ivar) encoding:NSUTF8StringEncoding];
                                NSLog(@"%@",ivarName);
                                // 判断是不是这个属性
                                if ([ivarName isEqualToString:@"_image"]) {
                                    UIImage *imageName = [UIImage imageNamed:@"main_badge"];
                                    //利用kvc赋值
                                    [childBadgeBackGround setValue:imageName forKeyPath:@"_image"];
                                }
                                
                            }
                            
                        }
                    }
                    
                }
            }
        }
    }
    


}
@end
