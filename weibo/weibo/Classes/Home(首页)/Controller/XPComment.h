//
//  XPComment.h
//  weibo
//
//  Created by dragon on 16/6/20.
//  Copyright © 2016年 win. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XPUser.h"

@interface XPComment : NSObject

@property (nonatomic, copy)NSString *created_at;
@property (nonatomic, copy)NSString *text;
@property (nonatomic, strong)XPUser *user;
@property (nonatomic, copy)NSString *source;
-(instancetype)initWithDic:(NSDictionary *)dic;

-(float)getTextHeight;
@end
