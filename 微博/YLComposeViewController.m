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
#import "YLEmotionKuyboardView.h"
#import "YLEmotions.h"
#import "NSString+Emoji.h"
#import "YLEmotionWithTextView.h"
@interface YLComposeViewController ()<UITextViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property(weak,nonatomic)YLEmotionWithTextView *textView;
@property(weak,nonatomic)YLComposePhotosView *photosView;
@property(weak,nonatomic)YLComposeTabBarView *tabBarView;
@property(assign,nonatomic)BOOL isSystermKeyboard;
@property(strong,nonatomic)YLEmotionKuyboardView *keyboard;
@end

@implementation YLComposeViewController
- (YLEmotionKuyboardView *)keyboard{
    if (!_keyboard) {
        _keyboard = [[YLEmotionKuyboardView alloc] init];
        _keyboard.height = 216;
        _keyboard.width = SCREENW;
    }
    return _keyboard;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发微博";
    self.view.backgroundColor = [UIColor whiteColor];
    // 设置导航栏
    [self setNav];
    
    // 添加子控件
    [self addChildView];
    
    [self.textView becomeFirstResponder];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(KeyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    //注册监听表情按钮点击的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(emotionButtonClicked:) name:emotionDidSelected object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(btnDeleted:) name:deleteBtnClicke object:nil];
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

    // 添加子控件
- (void)addChildView{
    YLEmotionWithTextView *textView = [[YLEmotionWithTextView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    textView.ploceholder = @"第一次我说爱你的时候";
    textView.delegate = self;
    [self.view addSubview:textView];
    self.textView = textView;
    
    YLComposeTabBarView *tabBarView = [[YLComposeTabBarView alloc]init];
    [tabBarView setButtonChilk:^(ComposeTabBarViewButtonType type) {
        [self composeTabBarButtonClikWithType:type];
    }];
    self.tabBarView = tabBarView;
    tabBarView.width = SCREENW;
    tabBarView.height = 44;
    tabBarView.y = SCREENH - tabBarView.height;
    [self.view addSubview:tabBarView];
    YLComposePhotosView *photosView = [[YLComposePhotosView alloc]init];
    self.photosView = photosView;
    photosView.width = SCREENW;
    photosView.height = SCREENW;
    photosView.y = 200;
    //[self.view addSubview:photosView];
    [self.view insertSubview:photosView belowSubview:tabBarView];

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
        {
            NSLog(@"emotion");
            self.isSystermKeyboard = YES;
            [self.textView resignFirstResponder];
            if (self.textView.inputView) {
                self.textView.inputView = nil;
            }else{
//                YLEmotionKuyboardView *emotionKeyboardView = [[YLEmotionKuyboardView alloc]init];
//                emotionKeyboardView.width = SCREENW;
//                emotionKeyboardView.height = 216;
              //  emotionKeyboardView.y = SCREENH - emotionKeyboardView.height;
                self.textView.inputView = self.keyboard;
            }
            self.isSystermKeyboard = NO;
            self.tabBarView.isSystermKeyboard = !self.textView.inputView;
            [self.textView becomeFirstResponder];
    
            break;
        }
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

// 通知
- (void)KeyboardWillChangeFrame:(NSNotification *)noti{
   // NSLog(@"%@",noti);
//        NSConcreteNotification 0x7f8bdbe54290 {name = UIKeyboardWillChangeFrameNotification; userInfo = {
//        UIKeyboardFrameBeginUserInfoKey = NSRect: {{0, 568}, {320, 253}},
//        UIKeyboardCenterEndUserInfoKey = NSPoint: {160, 441.5},
//        UIKeyboardBoundsUserInfoKey = NSRect: {{0, 0}, {320, 253}},
//        UIKeyboardFrameEndUserInfoKey = NSRect: {{0, 315}, {320, 253}},
//        UIKeyboardAnimationDurationUserInfoKey = 0.25,
//        UIKeyboardCenterBeginUserInfoKey = NSPoint: {160, 694.5},
//        UIKeyboardAnimationCurveUserInfoKey = 7,
//        UIKeyboardIsLocalUserInfoKey = 1
    if (!self.isSystermKeyboard) {
        NSValue *value = noti.userInfo[UIKeyboardFrameEndUserInfoKey];
        [UIView animateWithDuration:0.25 animations:^{
           self.tabBarView.y = [value CGRectValue].origin.y - self.tabBarView.height;
        }];
    }

}

- (void)emotionButtonClicked:(NSNotification *)noti{

    NSLog(@"%@",noti.userInfo[@"emotion"]);
    YLEmotions *emotion = noti.userInfo[@"emotion"];
//    YLEmotionWithTextView *emotionTextView = [[YLEmotionWithTextView alloc]init];
//    [emotionTextView insertEmotion:emotion];
    
    [self.textView insertEmotion:emotion];
    
    // 取出原有带有属性的文字
//    NSMutableAttributedString *origialText = [[NSMutableAttributedString alloc]initWithAttributedString:self.textView.attributedText];
//    //取出当前textView显示的位置
//    NSRange selecteRange = self.textView.selectedRange;
//    
//    if (emotion.isEmoji ) {
//        
//        // 初始化一个不可变的属性文字
//        NSAttributedString *emojiStr = [[NSAttributedString alloc]initWithString:[emotion.code emoji]];
//        [origialText replaceCharactersInRange:selecteRange withAttributedString:emojiStr];
//    }else{
//    //初始化一个可以包含图片的文字附件
//        NSTextAttachment *attachement = [[NSTextAttachment alloc]init];
//        attachement.image = [UIImage imageNamed:emotion.fullPath];
//        CGFloat imageH = self.textView.font.lineHeight;
//        attachement.bounds = CGRectMake(0, -4, imageH, imageH);
//    //通过文字附件初始化一个带有图片的属性文字
//        NSAttributedString *attrString = [NSAttributedString attributedStringWithAttachment:attachement];
//        [origialText replaceCharactersInRange:selecteRange withAttributedString:attrString];
//    
//    }
//    if (self.textView.attributedText.length) {
//        [origialText addAttribute:NSFontAttributeName value:self.textView.font range:NSMakeRange(0, origialText.length)];
//    }else {
//    
//        [origialText addAttribute:NSFontAttributeName value:FONT(14) range:NSMakeRange(0, origialText.length)];
//    }
//    
//    
//    
//    self.textView.attributedText = origialText;
//    
//    selecteRange.location++;
//    selecteRange.length = 0;
//    self.textView.selectedRange = selecteRange;
    
    

}

- (void)btnDeleted:(UIButton *)btn{

    [self.textView deleteBackward];

}

- (void)dealloc{

    [[NSNotificationCenter defaultCenter]removeObserver:self];

}
- (void)textViewDidChange:(UITextView *)textView{
    self.navigationItem.rightBarButtonItem.enabled = textView.text.length;
}


- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)send{


}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"%@",NSStringFromCGSize(scrollView.contentSize));
    
    [self.view endEditing:YES];
}


@end
