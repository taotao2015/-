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

- (void)setSource:(NSString *)source{
    _source = source;
//<a href="http://weibo.com/" rel="nofollow">微博 weibo.com</a>,
    NSRange range = [source rangeOfString:@"\">"];
    if (range.location != NSNotFound) {
        NSRange subRange;
        subRange.location = range.location + range.length;
        
        subRange.length = [source rangeOfString:@"</"].location - subRange.location;
        if (subRange.length != NSNotFound) {
            _source = [source substringWithRange:subRange];
        }
       
    }
    
    
}

- (NSString *)created_at{
    
    NSDateFormatter *dateFormate = [[NSDateFormatter alloc]init];
    dateFormate.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    dateFormate.dateFormat = @"EEE MMM dd HH:mm:ss z yyyy";
    NSDate *date = [dateFormate dateFromString:_created_at];
    dateFormate.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
   return [dateFormate stringFromDate:date];
}

//- (void)setCreated_at:(NSString *)created_at{
//    _created_at = created_at;
//    NSDateFormatter *dateFormate = [[NSDateFormatter alloc]init];
//    dateFormate.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
//    dateFormate.dateFormat = @"EEE MMM dd HH:mm:ss z yyyy";
//    NSDate *date = [dateFormate dateFromString:created_at];
//    dateFormate.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//
//    _created_at = [dateFormate stringFromDate:date];
//
//}

@end
