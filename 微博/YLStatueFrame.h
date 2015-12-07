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

@property(assign,nonatomic)CGFloat cellHeight;

@end
