//
//  YLLoadNewStatus.h
//  微博
//
//  Created by tao on 15/12/6.
//  Copyright © 2015年 tao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLUser.h"
@interface YLLoadNewStatus : NSObject
@property(copy,nonatomic)NSString *text;

@property(strong,nonatomic)YLUser *user;
@property(assign,nonatomic)long long id;
@end
