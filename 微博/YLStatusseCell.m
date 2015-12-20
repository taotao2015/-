//
//  YLStatusseCell.m
//  微博
//
//  Created by tao on 15/12/7.
//  Copyright © 2015年 tao. All rights reserved.
//

#import "YLStatusseCell.h"
#import "YLhomeCellTabBarView.h"
#import "YLStatuePhotos.h"
@interface YLStatusseCell()
@property(weak,nonatomic)UIImageView *headImage;
@property(weak,nonatomic)UILabel *nameLabel;
@property(weak,nonatomic)UILabel *contentLabel;
@property(weak,nonatomic)UILabel *creatTimeLabel;
@property(weak,nonatomic)UILabel *sourceLabel;
@property(weak,nonatomic)UIImageView *thumbnail_pic;
@property(weak,nonatomic)YLhomeCellTabBarView *homeCellTabBarView;
@property(weak,nonatomic)YLStatuePhotos *statusPhotos;
// 转发微博整体view
@property(weak,nonatomic)UIView *retweetView;
// 转发微博内容
@property(weak,nonatomic)UILabel *retweetContent;
// 转发微博的相册
@property(weak,nonatomic)YLStatuePhotos *retweetPhoto;
// 添加cell之间分隔view
@property(weak,nonatomic)UIView *separateView;
//添加会员图标
@property(weak,nonatomic)UIImageView *memberImage;

@end

@implementation YLStatusseCell


- (void)setStatueFrame:(YLStatueFrame *)statueFrame{
    _statueFrame = statueFrame;
    //self.textLabel.text = statueFrame.statuses.text;
    self.separateView.frame = statueFrame.separateViewF;
    self.headImage.frame = statueFrame.headImageF;
    self.memberImage.frame = statueFrame.memberViewF;
    if (statueFrame.statuses.user.isVip) {
        self.memberImage.hidden = NO;
        self.memberImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"common_icon_membership_level%zd",statueFrame.statuses.user.mbrank]];
        self.nameLabel.textColor = [UIColor orangeColor];
        
    }else{
        self.memberImage.hidden = YES;
        self.nameLabel.textColor = [UIColor grayColor];
    
    }
    NSString *imageUrl = statueFrame.statuses.user.profile_image_url;
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    self.nameLabel.frame = statueFrame.nameLabelF;
    self.nameLabel.text = statueFrame.statuses.user.screen_name;
    self.contentLabel.frame = statueFrame.contentLabelF;
    self.contentLabel.text = statueFrame.statuses.text;
    
    self.creatTimeLabel.frame = statueFrame.createdTimeLabelF;
    self.creatTimeLabel.text = statueFrame.statuses.created_at;
    self.sourceLabel.frame = statueFrame.sourceF;
    self.sourceLabel.text = statueFrame.statuses.source;
   // self.thumbnail_pic.frame = statueFrame.thumbnail_pic;
    
    
    if (self.thumbnail_pic) {
        self.thumbnail_pic.hidden = NO;
//        NSString *imageUrl = [NSString stringWithFormat:@"%@",statueFrame.statuses.thumbnail_pic];
//        [self.thumbnail_pic sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
       // self.statusPhotos.number = statueFrame.statuses.pic_urls.count;
        self.statusPhotos.frame = statueFrame.photoViewF;
        
        self.statusPhotos.pic_urls = statueFrame.statuses.pic_urls;
        
        
    }else{
    
        self.thumbnail_pic.hidden = YES;
    }
    
    // 添加转发微博
    if (statueFrame.statuses.retweeted_status) {
        self.retweetView.hidden = NO;
        self.retweetContent.frame = statueFrame.retweetContentF;
        NSString *contentText = [NSString stringWithFormat:@"@%@:%@",statueFrame.statuses.retweeted_status.user.screen_name,statueFrame.statuses.retweeted_status.text];
        self.retweetContent.text = contentText;
        if (statueFrame.statuses.retweeted_status.pic_urls.count) {
           self.retweetPhoto.frame = statueFrame.retweetPhotoF;
            self.retweetPhoto.hidden = NO;
            self.retweetPhoto.pic_urls = statueFrame.statuses.retweeted_status.pic_urls;
            self.retweetPhoto.backgroundColor = RGBN(239, 239, 245, 0.5);
        }else{
        
            self.retweetPhoto.hidden = YES;
        }
        
        self.retweetView.frame = statueFrame.retweetViewF;
    }else{
    
        self.retweetView.hidden = YES;
    
    }
    
    self.homeCellTabBarView.frame = statueFrame.YLhomeCellTabBarView;
    self.homeCellTabBarView.status = statueFrame.statuses;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUpOriginalStatue];
        
        [self setUpRetweetStatue];
        
    }
    return self;
}

// 设置原创微博
- (void)setUpOriginalStatue{
    //添加分隔视图
    UIView *separateView = [[UIView alloc]init];
    self.separateView = separateView;
    [self.contentView addSubview:separateView];
    separateView.backgroundColor = [UIColor grayColor];
    // 添加会员图标
    UIImageView *memberView = [[UIImageView alloc]init];
    self.memberImage = memberView;
    
    [self.contentView addSubview:memberView];

    UIImageView *headImage = [[UIImageView alloc]init];
    self.headImage = headImage;
    
    [self.contentView addSubview:headImage];
    UILabel *nameLabel = [[UILabel alloc]init];
    self.nameLabel = nameLabel;
    nameLabel.textColor = [UIColor grayColor];
    nameLabel.font = FONT(12);
    [self.contentView addSubview:nameLabel];
    
    UILabel *contentLabel = [[UILabel alloc]init];
    self.contentLabel = contentLabel;
    contentLabel.textColor = [UIColor grayColor];
    contentLabel.numberOfLines = 0;
    contentLabel.font = FONT(13);
    [self.contentView addSubview:contentLabel];
    UILabel *creatTimeLabel = [[UILabel alloc]init];
    self.creatTimeLabel = creatTimeLabel;
    creatTimeLabel.textColor = [UIColor grayColor];
    creatTimeLabel.font = FONT(10);
    [self.contentView addSubview:creatTimeLabel];
    
    UILabel *sourceLabel = [[UILabel alloc]init];
    self.sourceLabel = sourceLabel;
    sourceLabel.textColor = [UIColor grayColor];
    sourceLabel.font = FONT(10);
    [self.contentView addSubview:sourceLabel];
    UIImageView *thumbnail_pic = [[UIImageView alloc]init];
    self.thumbnail_pic = thumbnail_pic;
    [self.contentView addSubview:thumbnail_pic];
    
    YLhomeCellTabBarView *homeCellTabBarView = [[YLhomeCellTabBarView alloc]init];
    self.homeCellTabBarView = homeCellTabBarView;
    //homeCellTabBarView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:homeCellTabBarView];
    
    YLStatuePhotos *statusPhoto = [[YLStatuePhotos alloc]init];
    self.statusPhotos = statusPhoto;
    [self.contentView addSubview:statusPhoto];

}


// 设置转发微博
- (void)setUpRetweetStatue{

    UIView *retweetView = [[UIView alloc]init];
    //retweetView.backgroundColor = RGBN(240, 240, 240, 1);
//    retweetView.backgroundColor = RGBN(239, 239, 243, 0.5);
    self.retweetView = retweetView;
    
    [self.contentView addSubview:retweetView];
    
    UILabel *retweetContent = [[UILabel alloc]init];
    self.retweetContent = retweetContent;
    retweetContent.numberOfLines = 0;
    retweetContent.font = FONT(10);
    retweetContent.textColor = [UIColor grayColor];
    [retweetView addSubview:retweetContent];
    
    YLStatuePhotos *retweetPhoto = [[YLStatuePhotos alloc]init];
    self.retweetPhoto = retweetPhoto;
    retweetPhoto.backgroundColor = [UIColor redColor];
    [retweetView addSubview:retweetPhoto];

}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    YLStatusseCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    cell.backgroundColor = [UIColor clearColor];
    return cell;

}


@end
