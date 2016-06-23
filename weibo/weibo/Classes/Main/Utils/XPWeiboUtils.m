//
//  XPWeiboUtils.m
//  weibo
//
//  Created by dragon on 16/6/19.
//  Copyright © 2016年 win. All rights reserved.
//

#import "XPWeiboUtils.h"
#import "AFNetworking.h"
#import "XPWeibo.h"
#import "XPAccount.h"
#import "XPComment.h"


@implementation XPWeiboUtils

+(void)requestTokenWithCode:(NSString *)code andCallback:(MyCallback)callback{
    
    NSString *path = @"https://api.weibo.com/oauth2/access_token";
    NSDictionary *params = @{@"client_id":kAppKey,@"client_secret":kAppSecret,@"grant_type":@"authorization_code",@"code":code,@"redirect_uri":@"http://www.baidu.com"};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        callback(dic);
        
        NSLog(@"请求成功");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败：%@",error);
    }];
    
    
    
    
    
    
    
    
}

+(void)sendWeiboWithText:(NSString *)text andCallback:(MyCallback)callback{
    
    NSString *path = @"https://api.weibo.com/2/statuses/update.json";
    
    NSDictionary *params = @{@"access_token":[XPAccount sharedAccount].access_token,@"status":text};
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        callback(dic);
        
        NSLog(@"发送微博成功");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"发送失败：%@",error);
    }];
    
    
    
    
}

+(void)sendWeiboWithText:(NSString *)text andImageData:(NSData *)data andCallback:(MyCallback)callback{
    
    NSString *path = @"https://upload.api.weibo.com/2/statuses/upload.json";
    
    NSDictionary *params = @{@"access_token":[XPAccount sharedAccount].access_token,@"status":text};
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [manager POST:path parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //把图片数据 添加到请求体里面
        [formData appendPartWithFileData:data name:@"pic" fileName:@"abc.jpg" mimeType:@"image/jpeg"];
        
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"进度：%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        callback(dic);
        
        NSLog(@"发送微博成功");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"发送失败：%@",error);
    }];
    
    
    
    
    
}

+(void)requestHomeWeibosWithCallback:(MyCallback)callback{
    
    NSString *path = @"https://api.weibo.com/2/statuses/home_timeline.json";
    
    NSDictionary *params = @{@"access_token":[XPAccount sharedAccount].access_token};
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //把返回的json字符串 从Data转成字符串
        //        NSString *jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        //        NSLog(@"%@",jsonStr);
        //
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        //从字典中解析出每一条微博数据
        NSArray *weiboArr = dic[@"statuses"];
        NSMutableArray *weibos = [NSMutableArray array];
        for (NSDictionary *weiboDic in weiboArr) {
            
            XPWeibo *w = [[XPWeibo alloc]initWithDic:weiboDic];
            
            
            [weibos addObject:w];
            
            
        }
        
        
        callback(weibos);
        
        NSLog(@"获取微博列表成功");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"获取微博列表失败：%@",error);
    }];
}

+(void)requestCommentsWithWID:(NSString *)wid andCallback:(MyCallback)callback{
    
    
    NSString *path = @"https://api.weibo.com/2/comments/show.json";
    
    NSDictionary *params = @{@"access_token":[XPAccount sharedAccount].access_token,@"id":wid};
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        //从字典中解析出每一条评论数据
        NSLog(@"%@",dic);
        NSArray *commentsArr = dic[@"comments"];
        
        NSMutableArray *comments = [NSMutableArray array];
        for (NSDictionary *commentDic in commentsArr) {
            XPComment *c = [[XPComment alloc]initWithDic:commentDic];
            [comments addObject:c];
            
        }
        
        callback(comments);
        
        
        NSLog(@"获取微博评论列表成功");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"获取微博评论列表失败：%@",error);
    }];
    
    
    
}


+(void)sendCommentWithText:(NSString *)text andWID:(NSString *)wid andCallback:(MyCallback)callback{
    
    
    NSString *path = @"https://api.weibo.com/2/comments/create.json";
    
    NSDictionary *params = @{@"access_token":[XPAccount sharedAccount].access_token,@"comment":text,@"id":wid};
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        callback(dic);
        
        NSLog(@"发送评论成功");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"发送失败：%@",error);
    }];
    
    
    
    
    
}


+(void)requestUserInfoWithCallback:(MyCallback)callback{
    NSString *path = @"https://api.weibo.com/2/users/show.json";
    NSDictionary *params = @{@"access_token":[XPAccount sharedAccount].access_token,@"uid":[XPAccount sharedAccount].uid};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [manager GET:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        //开始解析
        XPUser *user = [[XPUser alloc]initWithDic:dic];
        
        
        
        
        callback(user);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
    }];
    
}

+(void)requestFriendsWithCallback:(MyCallback)callback{
    NSString *path = @"https://api.weibo.com/2/friendships/friends.json";
    NSDictionary *params = @{@"access_token":[XPAccount sharedAccount].access_token,@"uid":[XPAccount sharedAccount].uid};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [manager GET:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        //开始解析
        NSLog(@"%@",dic);
        
        NSMutableArray *users = [NSMutableArray array];
        NSArray *userArr = dic[@"users"];
        for (NSDictionary *userDic in userArr) {
            XPUser *u = [[XPUser alloc]initWithDic:userDic];
            [users addObject:u];
            
        }
        
        callback(users);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
    }];
    
    
    
}
+(void)requestUnReadCountWithCallback:(MyCallback)callback{
    NSString *path = @"https://rm.api.weibo.com/2/remind/unread_count.json";
    NSDictionary *params = @{@"access_token":[XPAccount sharedAccount].access_token,@"uid":[XPAccount sharedAccount].uid};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [manager GET:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        //开始解析
        //        NSLog(@"%@",dic);
        
        NSString *unReadCount = [dic[@"status"] stringValue];
        
        callback(unReadCount);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
    }];
    
}


+(void)requestHomeWeibosWithHomeParams:(XPHomeParams *)homeParams andCallback:(MyCallback)callback{
    
    NSString *path = @"https://api.weibo.com/2/statuses/home_timeline.json";
    
    NSDictionary *params = @{@"access_token":[XPAccount sharedAccount].access_token,@"page":@(homeParams.page),@"count":@(homeParams.count),@"since_id":homeParams.since_id};
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //把返回的json字符串 从Data转成字符串
        //        NSString *jsonStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        //        NSLog(@"%@",jsonStr);
        //
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        //从字典中解析出每一条微博数据
        NSArray *weiboArr = dic[@"statuses"];
        NSMutableArray *weibos = [NSMutableArray array];
        for (NSDictionary *weiboDic in weiboArr) {
            
            XPWeibo *w = [[XPWeibo alloc]initWithDic:weiboDic];
            
            
            [weibos addObject:w];
            
            
        }
        
        
        callback(weibos);
        
        NSLog(@"获取微博列表成功");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"获取微博列表失败：%@",error);
    }];
    
}
@end
