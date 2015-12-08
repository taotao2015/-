//
//  YLLoadNewStatus.m
//  微博
//
//  Created by tao on 15/12/6.
//  Copyright © 2015年 tao. All rights reserved.
//

#import "YLLoadNewStatus.h"
#import "YLPhoto.h"
@implementation YLLoadNewStatus
 //告诉pic_urls这个集合,里面存的是什么对象,也就是告诉字典转模型的框架,pic_urls里面存的是什么,它就用指定的class去转
+ (NSDictionary *)objectClassInArray{
    return @{@"pic_urls" : [YLPhoto class]};
}

@end
