//
//  YLOauthViewController.m
//  微博
//
//  Created by tao on 15/12/5.
//  Copyright © 2015年 tao. All rights reserved.
//

#import "YLOauthViewController.h"

@interface YLOauthViewController ()<UIWebViewDelegate>

@end

@implementation YLOauthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    webView.delegate = self;
    NSString *usrString = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=300048342&redirect_uri=http://www.baidu.com/"];
    NSURL *url = [NSURL URLWithString:usrString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *urlStr = request.URL.absoluteString;
    if ([urlStr hasPrefix:@"http://www.baidu.com/"]) {
        NSString *str = @"code=";
        NSRange range = [urlStr rangeOfString:str];
        if (range.location != NSNotFound) {
            NSString *code = [urlStr substringFromIndex:range.location + range.length];
            
            NSLog(@"%@",code);
            
            return NO;
        }
    }
    
    return YES;
}

@end
