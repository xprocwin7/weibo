//
//  XPMainTabBarController.m
//  weibo
//
//  Created by dragon on 16/6/19.
//  Copyright © 2016年 win. All rights reserved.
//

#import "XPMainTabBarController.h"
#import "XPTabBar.h"
#import "XPLoginViewController.h"
#import "XPHomeTableController.h"
#import "XPFriendsCollectionController.h"
#import "UserInfoViewController.h"
#import "XPSettingsTableController.h"
#import "XPMainNavigationController.h"

@interface XPMainTabBarController ()

@end

@implementation XPMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    XPHomeTableController *hvc = [XPHomeTableController new] ;
    XPFriendsCollectionController *fvc = [XPFriendsCollectionController new];
    UserInfoViewController *uvc = [UserInfoViewController new];
    XPSettingsTableController *svc = [[XPSettingsTableController alloc] initWithStyle:UITableViewStyleGrouped];
    hvc.title = @"首页";
    fvc.title = @"好友";
    uvc.title = @"用户";
    svc.title = @"设置";
    NSArray *menuImageNames = @[@"01全部话题_14.png",@"05侧滑分栏_12.png",@"05侧滑分栏_14.png",@"05侧滑分栏_17.png"];
    
    hvc.tabBarItem.image = [UIImage imageNamed:menuImageNames[0]];
    fvc.tabBarItem.image = [UIImage imageNamed:menuImageNames[1]];
    uvc.tabBarItem.image = [UIImage imageNamed:menuImageNames[2]];
    svc.tabBarItem.image = [UIImage imageNamed:menuImageNames[3]];
    
    [self addChildViewController:[[XPMainNavigationController alloc]initWithRootViewController:hvc]];
    
    [self addChildViewController:[[XPMainNavigationController alloc]initWithRootViewController:fvc]];
    [self addChildViewController:[[XPMainNavigationController alloc]initWithRootViewController:uvc]];
    [self addChildViewController:[[XPMainNavigationController alloc]initWithRootViewController:svc]];
    
    //    完全自己添加bar里面的各种按钮  把原来的bar 盖上
    //    UIView *barView = [[UIView alloc]initWithFrame:self.tabBar.frame];
    //    barView.backgroundColor = [UIColor redColor];
    //    [self.view addSubview:barView];
    
    
    XPTabBar *tabbar = [[XPTabBar alloc]initWithFrame:self.tabBar.frame];
    //    KVC 可以通过键值的方式对对象属性的进行赋值 和 取值
    [self setValue:tabbar forKey:@"tabBar"];
    
    self.tabBar.tintColor = [UIColor orangeColor];
    
    //未读微博数量检测
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(checkingUnRead:) userInfo:hvc repeats:YES];
    
    //    如果使用通知 不管是本地通知还是远程推送 都需要注册一下
    UIUserNotificationType types = UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
    
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];

    
}

-(void)checkingUnRead:(NSTimer*)timer{
    
    UIViewController *hvc = timer.userInfo;
    
    if ([XPAccount sharedAccount]) {
    
        [XPWeiboUtils requestUnReadCountWithCallback:^(id obj) {
            NSLog(@"未读：%@",obj);
            if (![obj isEqualToString:@"0"]) {
                hvc.tabBarItem.badgeValue = obj;
                
                //判断程序是否在后台运行
                if ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground&&[obj intValue]!=[UIApplication sharedApplication].applicationIconBadgeNumber) {
                    //添加本地通知
                    UILocalNotification *localNoti = [UILocalNotification new];
                    //显示时间
                    localNoti.fireDate = [NSDate new];
                    localNoti.applicationIconBadgeNumber = [obj intValue];
                    localNoti.alertBody = [NSString stringWithFormat:@"有%@条微博更新",obj];
                    
                    [[UIApplication sharedApplication]scheduleLocalNotification:localNoti];
                }
                
            }
            
        }];
    }
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //如果没有登录过则登录
    if (![XPAccount sharedAccount]) {
        
        XPLoginViewController *vc = [XPLoginViewController new];
        
        [self presentViewController:vc animated:YES completion:nil];
        
    }
    
}
@end
