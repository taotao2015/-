//
//  YLPopView.m
//  微博
//
//  Created by tao on 15/12/17.
//  Copyright © 2015年 tao. All rights reserved.
//

#import "YLPopView.h"

@implementation YLPopView

+ (instancetype)popView{

    return [[[NSBundle mainBundle]loadNibNamed:@"YLPopView" owner:nil options:nil]lastObject];

}

@end
