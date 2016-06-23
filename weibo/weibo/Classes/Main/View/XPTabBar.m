//
//  XPTabBar.m
//  weibo
//
//  Created by dragon on 16/6/19.
//  Copyright © 2016年 win. All rights reserved.
//

#import "XPTabBar.h"
#import "XPSendingViewController.h"
#import "XPMainNavigationController.h"

@implementation XPTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //添加进去+按钮
        
        UIButton *sendWeiboBtn = [[UIButton alloc]initWithFrame:CGRectMake(152, 1, 71, 48)];
        //设置图片
        [sendWeiboBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted.png"] forState:UIControlStateNormal];
        //设置背景图片
        [sendWeiboBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted.png"] forState:UIControlStateNormal];
        
        [self addSubview:sendWeiboBtn];
        
        [sendWeiboBtn addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)sendAction{
    
    XPSendingViewController *vc = [XPSendingViewController new];
    
    //得到项目中的tabbarController
    UIViewController *tbc = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    [tbc presentViewController:[[XPMainNavigationController alloc]initWithRootViewController:vc] animated:YES completion:nil];
    
}

//子控件布局方法  此方法 每次显示之前会调用
-(void)layoutSubviews{
    [super layoutSubviews];
    
//    NSLog(@"%@",self.subviews);
    UIView *fView = self.subviews[3];
    UIView *uView = self.subviews[4];
    fView.center = CGPointMake(115, fView.center.y);
    uView.center = CGPointMake(260, uView.center.y);
    
}

@end
