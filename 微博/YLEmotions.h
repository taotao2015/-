//
//  YLEmotions.h
//  微博
//
//  Created by tao on 15/12/15.
//  Copyright © 2015年 tao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLEmotions : NSObject
@property(copy,nonatomic)NSString *chs;

@property(copy,nonatomic)NSString *cht;

@property(copy,nonatomic)NSString *png;

@property(copy,nonatomic)NSString *type;

@property(copy,nonatomic)NSString *code;

@property(copy,nonatomic)NSString *path;

@property(copy,nonatomic)NSString *fullPath;

@property(assign,nonatomic,getter=isEmoji)BOOL emoji;

@end
