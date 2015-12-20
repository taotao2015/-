//
//  YLUser.m
//  微博
//
//  Created by tao on 15/12/6.
//  Copyright © 2015年 tao. All rights reserved.
//

#import "YLUser.h"

@implementation YLUser

- (void)setMbtype:(NSInteger)mbtype{
    _mbrank = mbtype;
    _vip = mbtype > 2 ;

}

@end
