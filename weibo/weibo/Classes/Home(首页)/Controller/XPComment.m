//
//  XPComment.m
//  weibo
//
//  Created by dragon on 16/6/20.
//  Copyright © 2016年 win. All rights reserved.
//

#import "XPComment.h"

@implementation XPComment
- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        
        self.text = dic[@"text"];
        self.created_at = dic[@"created_at"];
        self.source = dic[@"source"];
        
        NSDictionary *userDic = dic[@"user"];
        self.user = [[XPUser alloc]initWithDic:userDic];
        
        
        
        
        
        
    }
    return self;
}

//重写set方法
-(void)setSource:(NSString *)source{
    if ([source containsString:@">"]) {
        source = [source componentsSeparatedByString:@">"][1];
        
        source = [[source componentsSeparatedByString:@"<"]firstObject];
        
        _source = [@"来自：" stringByAppendingString:source];
    }else{
        _source = @"来自：未知";
    }
    
    
    
}




//重写了get方法
-(NSString *)created_at{
    //    Mon May 09 15:21:58 +0800 2016
    //获取微博发送时间
    //把获得的字符串时间 转成 时间戳
    //EEE（星期）  MMM（月份）dd（天） HH小时 mm分钟 ss秒 Z时区 yyyy年
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    format.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    //设置地区
    format.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    //微博发送时间
    NSDate *weiboDate = [format dateFromString:_created_at];
    
    //获取当前时间
    NSDate *nowDate = [NSDate new];
    
    long nowTime = [nowDate timeIntervalSince1970];
    long weiboTime = [weiboDate timeIntervalSince1970];
    //微博时间和当前时间的时间差
    long time = nowTime-weiboTime;
    if (time<60) {//一分钟内 显示刚刚
        return @"刚刚";
    }else if (time>60&&time<=3600){
        return [NSString stringWithFormat:@"%d分钟前",(int)time/60];
    }else if (time>3600&&time<3600*24){
        return [NSString stringWithFormat:@"%d小时前",(int)time/3600];
    }else{//直接显示日期
        format.dateFormat = @"MM月dd日";
        return  [format stringFromDate:weiboDate];
    }
    
    
}


-(float)getTextHeight{
    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:kTextSize]};
    
    
    //计算文本高度
    CGSize retSize = [self.text boundingRectWithSize:CGSizeMake(kScreenWidth-2*kMargen, CGFLOAT_MAX)
                                             options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
    
    return retSize.height;
    
}

@end
