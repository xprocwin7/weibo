//
//  XPWeibo.m
//  weibo
//
//  Created by dragon on 16/6/20.
//  Copyright © 2016年 win. All rights reserved.
//

#import "XPWeibo.h"
#import "YYTextView.h"

@implementation XPWeibo
-(instancetype)initWithDic:(NSDictionary *)dic{
    
    self = [super init];
    if (self) {
        self.wid = dic[@"id"];
        self.text = dic[@"text"];
        
        
        
        self.created_at = dic[@"created_at"];
        self.pic_urls = dic[@"pic_urls"];
        self.source = dic[@"source"];
        self.reposts_count = dic[@"reposts_count"];
        self.comments_count = dic[@"comments_count"];
        
        
        self.attitudes_count = dic[@"attitudes_count"];
        
        //解析用户相关
        NSDictionary *userDic = dic[@"user"];
        
        self.user = [[XPUser alloc]initWithDic:userDic];
        
        
        //解析转发
        
        NSDictionary *reWeiboDic = dic[@"retweeted_status"];
        if (reWeiboDic) {
            
            self.reWeibo = [[XPWeibo alloc]initWithDic:reWeiboDic];
            
        }
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

-(float)getWeiboHeight{
    
    float h = 0;
    //加上文本高度
    h += [self getTextHeight]+2*kMargen;
    //加上图片高度
    if (self.pic_urls.count>0) {
        h += [self getImageHeight]+kMargen;
    }
    
    //判断是否有转发
    if (self.reWeibo) {
        h += [self.reWeibo getWeiboHeight]-kMargen;
    }
    
    return h;
    
}

-(float)getTextHeight{
    
    
    YYTextView *tv = [[YYTextView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-2*kMargen, 0)];
    tv.font = [UIFont systemFontOfSize:kTextSize];
    
    tv.text = self.text;
    return tv.textLayout.textBoundingSize.height;
    
}

-(float)getImageHeight{
    
    NSInteger count = self.pic_urls.count;
    
    if (count==1) {
        return 200;
    }else if (count>1&&count<=3){
        return kImageSize;
    }else if (count>3&&count<=6){
        return 2*kImageSize+kMargen;
    }else if (count>6&&count<=9){
        
        return 3*kImageSize+2*kMargen;
        
    }
    
    return 0;
    
}

@end
