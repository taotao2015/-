//
//  YLStatuePhotos.h
//  微博
//
//  Created by tao on 15/12/8.
//  Copyright © 2015年 tao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLStatuePhoto.h"
@interface YLStatuePhotos : UIView
// 图片地址列表
@property(strong,nonatomic)NSArray *pic_urls;

+ (CGSize)sizeWithPhotoCount:(NSInteger)count;
@end
