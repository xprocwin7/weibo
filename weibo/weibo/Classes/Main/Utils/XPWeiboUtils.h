//
//  XPWeiboUtils.h
//  weibo
//
//  Created by dragon on 16/6/19.
//  Copyright © 2016年 win. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XPHomeParams.h"

typedef void (^MyCallback)(id obj);
@interface XPWeiboUtils : NSObject

+(void)requestTokenWithCode:(NSString *)code andCallback:(MyCallback)callback;

+(void)sendWeiboWithText:(NSString *)text andCallback:(MyCallback)callback;


+(void)sendWeiboWithText:(NSString *)text andImageData:(NSData*)data andCallback:(MyCallback)callback;


+(void)requestHomeWeibosWithCallback:(MyCallback)callback;

+(void)requestHomeWeibosWithHomeParams:(XPHomeParams *)homeParams andCallback:(MyCallback)callback;

+(void)requestCommentsWithWID:(NSString *)wid andCallback:(MyCallback)callback;

+(void)sendCommentWithText:(NSString *)text andWID:(NSString *)wid andCallback:(MyCallback)callback;

+(void)requestUserInfoWithCallback:(MyCallback)callback;

+(void)requestFriendsWithCallback:(MyCallback)callback;

+(void)requestUnReadCountWithCallback:(MyCallback)callback;

@end
