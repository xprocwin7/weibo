//
//  XPHomeParams.h
//  weibo
//
//  Created by dragon on 16/6/22.
//  Copyright © 2016年 win. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XPHomeParams : NSObject
@property (nonatomic)NSInteger page;
@property (nonatomic)int count;
@property (nonatomic ,copy)NSString *since_id;
@end
