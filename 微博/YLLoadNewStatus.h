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
// 微博信息内容
@property(copy,nonatomic)NSString *text;
// 用户信息
@property(strong,nonatomic)YLUser *user;
// 微博创建时间
@property(copy,nonatomic)NSString *created_at;
// 微博来源
@property(copy,nonatomic)NSString *source;
// 缩略图
@property(copy,nonatomic)NSString *thumbnail_pic;
// 转发数
@property(assign,nonatomic)NSInteger reposts_count;
//评论数
@property(assign,nonatomic)NSInteger comments_count;
// 赞数
@property(assign,nonatomic)NSInteger attitudes_count;
// 图片地址列表
@property(strong,nonatomic)NSArray *pic_urls;

@property(assign,nonatomic)long long id;
@end
