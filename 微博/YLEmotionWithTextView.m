//
//  YLEmotionWithTextView.m
//  微博
//
//  Created by tao on 15/12/18.
//  Copyright © 2015年 tao. All rights reserved.
//

#import "YLEmotionWithTextView.h"
#import "NSString+Emoji.h"
@implementation YLEmotionWithTextView

- (void)insertEmotion:(YLEmotions *)emotion{

    NSMutableAttributedString *origialText = [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
    //取出当前textView显示的位置
    NSRange selecteRange = self.selectedRange;
    
    if (emotion.isEmoji ) {
        
        // 初始化一个不可变的属性文字
//        NSAttributedString *emojiStr = [[NSAttributedString alloc]initWithString:[emotion.code emoji]];
//        [origialText replaceCharactersInRange:selecteRange withAttributedString:emojiStr];
        [self insertText:[emotion.code emoji]];
    }else{
        //初始化一个可以包含图片的文字附件
        NSTextAttachment *attachement = [[NSTextAttachment alloc]init];
        attachement.image = [UIImage imageNamed:emotion.fullPath];
        CGFloat imageH = self.font.lineHeight;
        attachement.bounds = CGRectMake(0, -4, imageH, imageH);
        //通过文字附件初始化一个带有图片的属性文字
        NSAttributedString *attrString = [NSAttributedString attributedStringWithAttachment:attachement];
        [origialText replaceCharactersInRange:selecteRange withAttributedString:attrString];
        
    }
    if (self.text.length) {
        [origialText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, origialText.length)];
    }else {
        
        [origialText addAttribute:NSFontAttributeName value:FONT(14) range:NSMakeRange(0, origialText.length)];
    }
    
    
    
    self.attributedText = origialText;
    
    selecteRange.location ++;
    selecteRange.length = 0;
    self.selectedRange = selecteRange;
    
    //如果当前表情添加完毕,调用一个textView的textDidChange这个代理方法
    if ([self.delegate respondsToSelector:@selector(textViewDidChange:)]) {
        [self.delegate textViewDidChange:self];
    }

    [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self];

}

@end
