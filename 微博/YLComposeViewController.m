//
//  YLComposeViewController.m
//  微博
//
//  Created by tao on 15/12/12.
//  Copyright © 2015年 tao. All rights reserved.
//

#import "YLComposeViewController.h"
#import "YLAccountTool.h"
#import "YLTextView.h"
#import "YLComposeTabBarView.h"
#import "YLComposePhotosView.h"
@interface YLComposeViewController ()<UITextViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property(weak,nonatomic)YLTextView *textView;
@property(weak,nonatomic)YLComposePhotosView *photosView;
@end

@implementation YLComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发微博";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNav];
    YLTextView *textView = [[YLTextView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    textView.ploceholder = @"第一次我说爱你的时候";
    textView.delegate = self;
    [self.view addSubview:textView];
    self.textView = textView;
    
    YLComposeTabBarView *tabBarView = [[YLComposeTabBarView alloc]init];
    [tabBarView setButtonChilk:^(ComposeTabBarViewButtonType type) {
        [self composeTabBarButtonClikWithType:type];
    }];
    tabBarView.width = SCREENW;
    tabBarView.height = 44;
    tabBarView.y = SCREENH - tabBarView.height;
    [self.view addSubview:tabBarView];
    YLComposePhotosView *photosView = [[YLComposePhotosView alloc]init];
    self.photosView = photosView;
    photosView.width = SCREENW;
    photosView.height = SCREENW;
    photosView.y = 200;
    [self.view addSubview:photosView];
    
}

- (void)setNav{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:@"返回" target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"发送" target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.numberOfLines = 0;
    NSString *preStr = @"发微博";
    NSString *nameStr = [YLAccountTool account].screen_name;
    NSString *titleStr = nil;
    if (nameStr) {
        titleStr = [NSString stringWithFormat:@"%@\n%@",preStr,nameStr];
    }else{
        titleStr = preStr;
    }
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:titleStr];
    NSRange preStrRange = [titleStr rangeOfString:preStr];
    NSRange nameStrRange = [titleStr rangeOfString:nameStr];
    
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:preStrRange];
    [attStr addAttribute:NSFontAttributeName value:FONT(16) range:preStrRange];
    if (nameStrRange.location != NSNotFound) {
        
        [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:nameStrRange];
        [attStr addAttribute:NSFontAttributeName value:FONT(14) range:nameStrRange];
    }
    titleLabel.attributedText = attStr;
    // 这行代码比较重要，之前忘写了，显示不出来
    [titleLabel sizeToFit];
    self.navigationItem.titleView = titleLabel;
    
}

- (void)composeTabBarButtonClikWithType:(ComposeTabBarViewButtonType)type{
    switch (type) {
        case ComposeTabBarViewButtonTypeCamer:{
            [self selectImageWithSourceType:UIImagePickerControllerSourceTypeCamera];
            NSLog(@"camer");
            break;
        }
        case ComposeTabBarViewButtonTypePicture:{
            [self selectImageWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
//            NSLog(@"picture");
//            UIImagePickerController *controller = [[UIImagePickerController alloc]init];
//            controller.delegate = self;
//            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//            controller.allowsEditing = YES;
//            [self presentViewController:controller animated:YES completion:nil];
            break;
        }
        case ComposeTabBarViewButtonTypeMention:
            NSLog(@"mention");
            break;
        case ComposeTabBarViewButtonTypeTrend:
            NSLog(@"trend");
            break;
        case ComposeTabBarViewButtonTypeEmotion:
            NSLog(@"emotion");
            break;
    }

}

- (void)selectImageWithSourceType:(UIImagePickerControllerSourceType )type{
    if (![UIImagePickerController isSourceTypeAvailable:type]) {
        NSLog(@"不可用");
        return;
    }
    UIImagePickerController *controller = [[UIImagePickerController alloc]init];
    controller.delegate = self;
    controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    controller.allowsEditing = YES;
    [self presentViewController:controller animated:YES completion:nil];


}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo{
    //self.textView.backgroundColor = [UIColor colorWithPatternImage:image];
    //YLComposePhotosView *photosView = [[YLComposePhotosView alloc]init];
    //[photosView addImage:image];
    [self.photosView addImage:image];
    [picker dismissViewControllerAnimated:YES completion:nil];

}

- (void)textViewDidChange:(UITextView *)textView{
    self.navigationItem.rightBarButtonItem.enabled = textView.text.length;
}


- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)send{


}

@end
