//
//  XPUser.m
//  weibo
//
//  Created by dragon on 16/6/20.
//  Copyright © 2016年 win. All rights reserved.
//

#import "XPUser.h"

@implementation XPUser
-(instancetype)initWithDic:(NSDictionary *)dic{
    
    self = [super init];
    if (self) {
        self.name = dic[@"name"];
        self.created_at = dic[@"created_at"];
        self.avatar_large = dic[@"avatar_large"];
        self.cover_image_phone = dic[@"cover_image_phone"];
        self.followers_count = dic[@"followers_count"];
        self.friends_count = dic[@"friends_count"];
        self.gender = dic[@"gender"];
        self.location = dic[@"location"];
        
        self.des = dic[@"description"];
        
    }
    return self;
}

@end
