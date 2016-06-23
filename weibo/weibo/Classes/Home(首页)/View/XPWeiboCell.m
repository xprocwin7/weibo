//
//  XPWeiboCell.m
//  微博登录
//
//  Created by tarena on 16/6/16.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "XPWeiboCell.h"
#import "UIImageView+AFNetworking.h"
@implementation XPWeiboCell
//初始化时控制圆角

//模型层对象
//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        
//    }
//    return self;
//}
//控件如果是完全通过代码创建时调用此方法
//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        
//    }
//    return self;
//}
//通过xib或sb创建控件时调用此方法 只是自身ok了 子控件此时为nil
//- (instancetype)initWithCoder:(NSCoder *)coder
//{
//    self = [super initWithCoder:coder];
//    if (self) {
//  
//    }
//    return self;
//}

//通过xib或sb创建控件时调用此方法 子控件也初始化好了
-(void)awakeFromNib{
    self.headIV.layer.cornerRadius = self.headIV.bounds.size.width/2;
    self.headIV.layer.masksToBounds = YES;
    //显示微博内容的自定义View 添加到cell
    self.weiboView = [[XPWeiboView alloc]initWithFrame:CGRectMake(0, 62, kScreenWidth, 0)];
    
    [self addSubview:self.weiboView];
    
    self.bottomView.layer.borderWidth = 1;
    self.bottomView.layer.borderColor = [UIColor lightGrayColor].CGColor;
}


-(void)setWeibo:(XPWeibo *)weibo{
    _weibo = weibo;
    
    self.nameLabel.text = weibo.user.name;
    self.sourceLabel.text = weibo.source;
    self.timeLabel.text = weibo.created_at;
    [self.headIV setImageWithURL:[NSURL URLWithString:weibo.user.avatar_large]];
    
    [self.repostBtn setTitle:weibo.reposts_count.stringValue forState:UIControlStateNormal];
    [self.commentBtn setTitle:weibo.comments_count.stringValue forState:UIControlStateNormal];
     [self.likeBtn setTitle:weibo.attitudes_count.stringValue forState:UIControlStateNormal];
    
    //把微博对象传递到weiboView中
    self.weiboView.weibo = weibo;
//   更新控件的高度
    CGRect frame = self.weiboView.frame;
    frame.size.height = [weibo getWeiboHeight];
    self.weiboView.frame = frame;
    
//    self.weiboView.backgroundColor = [UIColor yellowColor];
}

@end
