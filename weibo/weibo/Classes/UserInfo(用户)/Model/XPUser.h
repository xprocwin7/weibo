//
//  XPUser.h
//  weibo
//
//  Created by dragon on 16/6/20.
//  Copyright © 2016年 win. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XPUser : NSObject
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *location;
@property (nonatomic, copy)NSString *des;
@property (nonatomic, copy)NSString *avatar_large;
@property (nonatomic, copy)NSString *cover_image_phone;
@property (nonatomic, copy)NSString *gender;
@property (nonatomic, strong)NSNumber *followers_count;
@property (nonatomic, strong)NSNumber *friends_count;
@property (nonatomic, copy)NSString *created_at;

-(instancetype)initWithDic:(NSDictionary *)dic;

@end
