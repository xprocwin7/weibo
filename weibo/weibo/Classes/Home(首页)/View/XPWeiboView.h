//
//  XPWeiboView.h
//  weibo
//
//  Created by dragon on 16/6/20.
//  Copyright © 2016年 win. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XPWeibo.h"
#import "YYTextView.h"
#import "XPWeiboImageView.h"

@interface XPWeiboView : UIView
@property (nonatomic, strong)XPWeibo *weibo;
@property (nonatomic, strong)YYTextView *textLabel;

@property (nonatomic, strong)XPWeiboImageView *weiboIV;
@property (nonatomic, strong)XPWeiboView *reWeiboView;

@end
