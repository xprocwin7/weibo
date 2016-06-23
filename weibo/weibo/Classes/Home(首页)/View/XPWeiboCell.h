//
//  XPWeiboCell.h
//  微博登录
//
//  Created by tarena on 16/6/16.
//  Copyright © 2016年 Tarena. All rights reserved.
//
#import "XPWeibo.h"
#import "XPWeiboView.h"
#import <UIKit/UIKit.h>

@interface XPWeiboCell : UITableViewCell
@property (nonatomic, strong)XPWeibo *weibo;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UIButton *repostBtn;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headIV;

@property (nonatomic, strong)XPWeiboView *weiboView;
@end
