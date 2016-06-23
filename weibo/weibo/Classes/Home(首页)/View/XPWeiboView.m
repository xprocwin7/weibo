//
//  XPWeiboView.m
//  weibo
//
//  Created by dragon on 16/6/20.
//  Copyright © 2016年 win. All rights reserved.
//

#import "XPWeiboView.h"
#import "NSAttributedString+YYText.h"

@implementation XPWeiboView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.textLabel = [[YYTextView alloc]initWithFrame:CGRectMake(kMargen, kMargen, kScreenWidth-2*kMargen, 0)];
        self.textLabel.font = [UIFont systemFontOfSize:kTextSize];
        self.textLabel.scrollEnabled = NO;
        self.textLabel.editable = NO;
        self.textLabel.contentInset = UIEdgeInsetsMake(-4, 0, 0, 0);
        [self addSubview:self.textLabel];
        
        
        self.weiboIV = [[XPWeiboImageView alloc]initWithFrame:CGRectZero];
        [self addSubview:self.weiboIV];
        
        
        
    }
    return self;
}

-(void)setWeibo:(XPWeibo *)weibo{
    _weibo = weibo;
    //显示文本
    self.textLabel.attributedText = [self parseString:weibo.text];
    CGRect frame = self.textLabel.frame;
    frame.size.height = [weibo getTextHeight];
    self.textLabel.frame = frame;
    //显示图片   CGRectGetMaxY 获取某个控件的下边的y值
    
    self.weiboIV.images = weibo.pic_urls;
    //更新图片的高度
    self.weiboIV.frame = CGRectMake(0, CGRectGetMaxY(self.textLabel.frame)+kMargen, kScreenWidth, [weibo getImageHeight]);
    
    //    self.weiboIV.backgroundColor = [UIColor greenColor];
    
    
    //判断是否有转发
    if (weibo.reWeibo) {
        //如果没创建过 创建一次
        if (!self.reWeiboView) {
            self.reWeiboView = [[XPWeiboView alloc]initWithFrame:CGRectZero];
            self.reWeiboView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
            [self addSubview:self.reWeiboView];
        }
        
        //为了复用的时候 之前可能隐藏过
        self.reWeiboView.hidden = NO;
        //告诉转发weiboView显示的内容
        self.reWeiboView.weibo = weibo.reWeibo;
        
        self.reWeiboView.frame = CGRectMake(0, CGRectGetMaxY(self.textLabel.frame), kScreenWidth, [weibo.reWeibo getWeiboHeight]);
        
    }else{//没有转发
        self.reWeiboView.hidden = YES;
        
    }
    
    
}

-(NSAttributedString *)parseString:(NSString *)string{
    
    NSMutableAttributedString *aString = [[NSMutableAttributedString alloc]initWithString:string];
    
    //创建规则
    NSString *regexString = @"(@[\\w-]+)|(#\\w+#)|(http+:[^\\s]*)|([A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4})";
    //创建正则表达式对象
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexString options:0 error:nil];
    //规则是否规范
    if (regex) {
        
        //获取符合规则的内容
        NSArray *results = [regex matchesInString:string options:0 range:NSMakeRange(0, string.length)];
        
        for (long i=0;i<results.count;i++) {
            NSTextCheckingResult *result = results[i];
            
            NSRange resultRange = result.range;//- 相匹配的范围
            //截取出符合条件的内容
            NSString *s = [string substringWithRange:resultRange];
            //NSLog(@"%@",s);
            
            //添加点击事件
            
            [aString yy_setTextHighlightRange:resultRange color:[UIColor blueColor] backgroundColor:[UIColor redColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                
                if ([s hasPrefix:@"@"]) {
                    NSLog(@"点击了人名：%@",s);
                }else if ([s hasPrefix:@"#"]){
                    NSLog(@"点击了话题：%@",s);
                }else{
                    NSLog(@"点击了网址：%@",s);
                    
                    UIViewController *vc = [[UIViewController alloc]init];
                    UIWebView *wv = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
                    
                    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:s]];
                    [wv loadRequest:request];
                    
                    [vc.view addSubview:wv];
                    
                }
                
                
            }];
            
        }
    }
    
    return aString;
}

@end
