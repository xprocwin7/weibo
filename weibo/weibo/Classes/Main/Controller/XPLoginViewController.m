//
//  XPLoginViewController.m
//  weibo
//
//  Created by dragon on 16/6/19.
//  Copyright © 2016年 win. All rights reserved.
//

#import "XPLoginViewController.h"

@interface XPLoginViewController ()<UIWebViewDelegate>

@end

@implementation XPLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *web = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    web.delegate = self;
    [self.view addSubview:web];
    
    NSString *path = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=http://www.baidu.com",kAppKey];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:path]];
    [web loadRequest:request];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //得到即将请求的地址
    NSString *path = request.URL.description;
    if ([path containsString:@"code"]) {
        NSString *code = [[path componentsSeparatedByString:@"="]lastObject];
        //通过code换token
        [XPWeiboUtils requestTokenWithCode:code andCallback:^(id obj) {
            NSLog(@"%@", obj);
            
            NSDictionary *dic = obj;
            [dic writeToFile:kAccountPath atomically:YES];
            
            //得到了token之后返回到自己页面
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }];
        
        //不让浏览器显示百度页面
        return NO;
    }
    return YES;
}
@end
