
//
//  YLEmotions.m
//  微博
//
//  Created by tao on 15/12/15.
//  Copyright © 2015年 tao. All rights reserved.
//

#import "YLEmotions.h"
#import "MJExtension.h"
@implementation YLEmotions

- (void)setPath:(NSString *)path{
    _path = path;
    self.fullPath = [NSString stringWithFormat:@"%@%@",self.path,self.png];

}

- (void)setType:(NSString *)type{
    _type = type;
    self.emoji = [type isEqualToString:@"1"];

}

MJCodingImplementation

- (BOOL)isEqual:(YLEmotions *)emotion{
    if ([emotion.chs isEqual:self.chs] || [[emotion code] isEqualToString:self.code ]) {
        return  YES;
    }
    return NO;
}

@end
