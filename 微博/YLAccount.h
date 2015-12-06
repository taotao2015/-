//
//  YLAccount.h
//  微博
//
//  Created by tao on 15/12/6.
//  Copyright © 2015年 tao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLAccount : NSObject<NSCoding>
//"access_token" = "2.00t52uhC05RyS1b495b5bc8c0Vl22j";
//"expires_in" = 157679999;
//"remind_in" = 157679999;
//uid = 2481076747;
@property(copy,nonatomic)NSString *access_token;
@property(assign,nonatomic)NSInteger expires_in;
@property(assign,nonatomic)NSInteger remind_in;
@property(assign,nonatomic)NSInteger uid;
@end
