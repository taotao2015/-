//
//  YLUser.h
//  微博
//
//  Created by tao on 15/12/6.
//  Copyright © 2015年 tao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLUser : NSObject
@property(copy,nonatomic)NSString *screen_name;
// 用户头像地址
@property(copy,nonatomic)NSString *profile_image_url;
@end
