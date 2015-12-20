//
//  NSString+Extension.m
//  微博
//
//  Created by tao on 15/12/9.
//  Copyright © 2015年 tao. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
- (CGSize)sizeWithFont:(UIFont*)font{
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    dict[NSFontAttributeName] = font;
    //return [self sizeWithAttributes:dict];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    return [self sizeWithAttributes:dict];
}

- (CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size{
    NSDictionary *dict = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;

}
@end
