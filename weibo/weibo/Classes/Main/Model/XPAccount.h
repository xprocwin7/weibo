//
//  XPAccount.h
//  weibo
//
//  Created by dragon on 16/6/19.
//  Copyright © 2016年 win. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XPAccount : NSObject
@property (nonatomic, copy)NSString *access_token;
@property (nonatomic, copy)NSString *uid;

+(XPAccount *)sharedAccount;

- (void)logout;
@end
