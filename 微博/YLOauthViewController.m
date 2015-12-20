//
//  YLOauthViewController.m
//  微博
//
//  Created by tao on 15/12/5.
//  Copyright © 2015年 tao. All rights reserved.
//

#import "YLOauthViewController.h"
#import "AFNetworking.h"
#import "YLAccount.h"
#define client_id @"300048342"
#define client_secret @"50a1ba41a49576127a2a985f314e89c3"
#define redirect_uri @"http://www.baidu.com/"
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
            
            //NSLog(@"%@",code);
            [self getAccessTokenWithCode:code];
            return NO;
        }
    }
    
    return YES;
}

// 根据code获取 Accesstoken
- (void)getAccessTokenWithCode:(NSString *)code{

//    https://api.weibo.com/oauth2/access_token
//    client_id	true	string	申请应用时分配的AppKey。
//    client_secret	true	string	申请应用时分配的AppSecret。
//    grant_type	true	string	请求的类型，填写authorization_code
//    
//    grant_type为authorization_code时
//    必选	类型及范围	说明
//    code	true	string	调用authorize获得的code值。
//    redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
    NSString *urlString = @"https://api.weibo.com/oauth2/access_token";

    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    
    parameter[@"client_id"] = client_id;
    parameter[@"client_secret"] = client_secret;
    parameter[@"grant_type"] = @"authorization_code";
    parameter[@"code"] = code;
    parameter[@"redirect_uri"] = redirect_uri;
    AFHTTPRequestOperationManager *requestOperationManager = [AFHTTPRequestOperationManager manager];

    [requestOperationManager POST:urlString parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject = %@",responseObject);
        YLAccount *account = [[YLAccount alloc]init];
        [account setValuesForKeysWithDictionary:responseObject];
        
        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        filePath =  [filePath stringByAppendingPathComponent:@"account.achiver"];
      [NSKeyedArchiver archiveRootObject:account toFile:filePath];
        NSLog(@"%@",filePath);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error = %@",error);
    }];

}



@end
