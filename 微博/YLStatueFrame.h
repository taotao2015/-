//
//  YLStatueFrame.h
//  微博
//
//  Created by tao on 15/12/7.
//  Copyright © 2015年 tao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLLoadNewStatus.h"
#import "YLUser.h"
@interface YLStatueFrame : NSObject

@property(strong,nonatomic)YLLoadNewStatus *statuses;
//头像
@property(assign,nonatomic)CGRect headImageF;
//昵称
@property(assign,nonatomic)CGRect nameLabelF;
//内容
@property(assign,nonatomic)CGRect contentLabelF;
//行高
@property(assign,nonatomic)CGFloat cellHeight;
//创建时间
@property(assign,nonatomic)CGRect createdTimeLabelF;
//来源
@property(assign,nonatomic)CGRect sourceF;
// 缩略图
@property(assign,nonatomic)CGRect photoViewF;
//底部自定义视图
@property(assign,nonatomic)CGRect YLhomeCellTabBarView;
@end
