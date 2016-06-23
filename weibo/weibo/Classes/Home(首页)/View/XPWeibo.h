//
//  XPWeibo.h
//  weibo
//
//  Created by dragon on 16/6/20.
//  Copyright © 2016年 win. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XPUser.h"
@interface XPWeibo : NSObject
@property (nonatomic, copy)NSString *created_at;
@property (nonatomic, copy)NSString *text;
@property (nonatomic, copy)NSString *source;
@property (nonatomic, strong)NSNumber *reposts_count;
@property (nonatomic, strong)NSNumber *comments_count;
@property (nonatomic, strong)NSNumber *attitudes_count;
@property (nonatomic, strong)NSArray *pic_urls;
@property (nonatomic, strong)XPUser *user;
@property (nonatomic, copy)NSString *wid;

//记录转发
@property (nonatomic, strong)XPWeibo *reWeibo;

-(instancetype)initWithDic:(NSDictionary *)dic;

-(float)getWeiboHeight;

-(float)getTextHeight;

-(float)getImageHeight;

@end
