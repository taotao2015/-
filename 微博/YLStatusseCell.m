//
//  YLStatusseCell.m
//  微博
//
//  Created by tao on 15/12/7.
//  Copyright © 2015年 tao. All rights reserved.
//

#import "YLStatusseCell.h"
@interface YLStatusseCell()
@property(weak,nonatomic)UIImageView *headImage;
@property(weak,nonatomic)UILabel *nameLabel;
@property(weak,nonatomic)UILabel *contentLabel;
@property(weak,nonatomic)UILabel *creatTimeLabel;
@property(weak,nonatomic)UILabel *sourceLabel;
@property(weak,nonatomic)UIImageView *thumbnail_pic;

@end

@implementation YLStatusseCell


- (void)setStatueFrame:(YLStatueFrame *)statueFrame{
    _statueFrame = statueFrame;
    //self.textLabel.text = statueFrame.statuses.text;
    self.headImage.frame = statueFrame.headImageF;
    
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
    self.thumbnail_pic.frame = statueFrame.thumbnail_pic;
    
    if (self.thumbnail_pic) {
        self.thumbnail_pic.hidden = NO;
        NSString *imageUrl = [NSString stringWithFormat:@"%@",statueFrame.statuses.thumbnail_pic];
        [self.thumbnail_pic sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        
    }else{
    
        self.thumbnail_pic.hidden = YES;
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
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
        
        
    }
    return self;
}


+ (instancetype)cellWithTableView:(UITableView *)tableView{
    YLStatusseCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    
    return cell;

}


@end
