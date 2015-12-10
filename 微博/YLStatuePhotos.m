//
//  YLStatuePhotos.m
//  微博
//
//  Created by tao on 15/12/8.
//  Copyright © 2015年 tao. All rights reserved.
//

#import "YLStatuePhotos.h"
@implementation YLStatuePhotos

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBN(239, 239, 243, 0.5);
         //self.backgroundColor = [UIColor yellowColor];
        for (int i = 0; i < 9; i++) {
            YLStatuePhoto *photoView = [[YLStatuePhoto alloc]init];
//            photoView.contentMode = UIViewContentModeScaleAspectFill;
//            photoView.clipsToBounds = YES;
            [self addSubview:photoView];
        }
    }
    return self;
}

- (void)setPic_urls:(NSArray *)pic_urls{
    _pic_urls = pic_urls;
    [self.subviews makeObjectsPerformSelector:@selector(setHidden:) withObject:@(YES)];
    
    for (int i = 0; i < pic_urls.count; i++) {
        
        YLPhoto *photo = pic_urls[i];
        YLStatuePhoto *childView = self.subviews[i];
        childView.photo = photo;
        
//        [childView sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
//        childView.hidden = NO;
    }

}

- (void)layoutSubviews{
    [super layoutSubviews];
    NSInteger count = self.pic_urls.count;
    NSInteger maxCol = (count==4 ? 2 : 3);
    for (int i = 0; i < count; i++) {
        UIView *childView = self.subviews[i];
       
        childView.x = (PHOTOWH + MARGIN) * (i % maxCol);
        childView.y = (PHOTOWH + MARGIN) * (i / maxCol);
        childView.width = PHOTOWH;
        childView.height = PHOTOWH;
        
    }

}
+ (CGSize)sizeWithPhotoCount:(NSInteger)count{

    NSInteger maxCol = (count==4 ? 2 : 3);
    NSInteger col = count > (maxCol - 1) ? maxCol : count;
    NSInteger row = (count + (maxCol - 1) )/ maxCol;
    CGFloat photoViewW = PHOTOWH * col + MARGIN * (col - 1);
    CGFloat photoViewH = PHOTOWH * row + MARGIN * (row - 1);

    return CGSizeMake(photoViewW, photoViewH);
}
@end
