//
//  YLStatueFrame.m
//  微博
//
//  Created by tao on 15/12/7.
//  Copyright © 2015年 tao. All rights reserved.
//

#import "YLStatueFrame.h"
#import "YLStatuePhotos.h"
#define MARGIN 10

@implementation YLStatueFrame

- (void)setStatuses:(YLLoadNewStatus *)statuses{

    _statuses = statuses;
    CGFloat headImageFX = MARGIN;
    CGFloat headImageFY = MARGIN;
    CGFloat headImageW = 30;
    
    self.headImageF = CGRectMake(headImageFX, headImageFY, headImageW, headImageW);
    CGFloat nameLabelX = CGRectGetMaxX(self.headImageF) + MARGIN;
    CGSize nameLabelSize = [statuses.user.screen_name sizeWithFont:FONT(12)];
    self.nameLabelF = CGRectMake(nameLabelX, headImageFY, nameLabelSize.width, nameLabelSize.height);
    
    //CGSize contenLabelSize = [statuses.text sizeWithFont:[UIFont systemFontOfSize:14]];
    CGFloat contentLabelY = CGRectGetMaxY(self.headImageF) + MARGIN;
    CGSize contenLabelSize = [statuses.text sizeWithFont:FONT(13) constrainedToSize:CGSizeMake(SCREENW - 2 * MARGIN, MAXFLOAT)];
    self.contentLabelF = CGRectMake(headImageFX, contentLabelY, contenLabelSize.width, contenLabelSize.height);
    
    CGFloat creatTimeLabelX = CGRectGetMaxX(self.headImageF) + MARGIN;
    CGFloat creatTimeLabelY = CGRectGetMaxY(self.nameLabelF) + MARGIN * 0.5;
    CGSize creatTimeLabelSize = [statuses.created_at sizeWithFont:FONT(10)];
    self.createdTimeLabelF = CGRectMake(creatTimeLabelX, creatTimeLabelY, creatTimeLabelSize.width, creatTimeLabelSize.height);
    CGFloat sourceX = CGRectGetMaxX(self.createdTimeLabelF) + MARGIN * 0.5;
    CGSize sourceSize = [statuses.source sizeWithFont:FONT(10)];
    self.sourceF = CGRectMake(sourceX, creatTimeLabelY, sourceSize.width, sourceSize.height);
    
    
    
   
    CGFloat YLhomeCellTabBarViewY = CGRectGetMaxY(self.contentLabelF) + MARGIN;
    if (statuses.thumbnail_pic) {
        //计算相册框的大小
        CGFloat photoViewX = headImageFX;
        CGFloat photoViewY = CGRectGetMaxY(self.contentLabelF) + MARGIN;
       
        CGSize photoSize = [YLStatuePhotos sizeWithPhotoCount:statuses.pic_urls.count];
        self.photoViewF = CGRectMake(photoViewX, photoViewY, photoSize.width, photoSize.height);
//        CGFloat thumbnail_picX = headImageFX;
//        CGFloat thumbnail_picY = CGRectGetMaxY(self.contentLabelF) + MARGIN;
//        CGSize thumbnail_picSize = CGSizeMake(70, 70);
//        self.thumbnail_pic = CGRectMake(thumbnail_picX, thumbnail_picY, thumbnail_picSize.width, thumbnail_picSize.height);
//        
        YLhomeCellTabBarViewY = CGRectGetMaxY(self.photoViewF) + MARGIN;
    }
    
    
    self.YLhomeCellTabBarView = CGRectMake(0, YLhomeCellTabBarViewY, SCREENW, 35);
     self.cellHeight = CGRectGetMaxY(self.YLhomeCellTabBarView) + MARGIN * 0.5;
}
@end
