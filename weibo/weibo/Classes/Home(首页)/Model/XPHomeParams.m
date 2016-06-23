//
//  XPHomeParams.m
//  weibo
//
//  Created by dragon on 16/6/22.
//  Copyright © 2016年 win. All rights reserved.
//

#import "XPHomeParams.h"

@implementation XPHomeParams
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.page = 1;
        self.count = 10;
        self.since_id = @"0";
    }
    return self;
}
@end
