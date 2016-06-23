//
//  XPAccount.m
//  weibo
//
//  Created by dragon on 16/6/19.
//  Copyright © 2016年 win. All rights reserved.
//

#import "XPAccount.h"

static XPAccount *_account;
@implementation XPAccount

+(XPAccount *)sharedAccount{
    
    @synchronized(self) {
        if (!_account) {
            //之前登录过
            NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:kAccountPath];
            NSLog(@"%@", dic);
            if (dic) {
                _account = [[XPAccount alloc]init];
                _account.access_token = dic[@"access_token"];
                _account.uid = dic[@"uid"];
                
            }
            
        }
    }
    return _account;
}

-(void)logout{
    NSLog(@"退出登录");
    //删除文件
    NSFileManager *fm = [NSFileManager defaultManager];
    [fm removeItemAtPath:kAccountPath error:nil];
    _account = nil;
}
@end
