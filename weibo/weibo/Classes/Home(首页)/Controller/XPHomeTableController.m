//
//  XPHomeTableController.m
//  weibo
//
//  Created by dragon on 16/6/19.
//  Copyright © 2016年 win. All rights reserved.
//

#import "XPHomeTableController.h"
#import "XPWeiboCell.h"
#import "XPDetailTableController.h"
#import "XPWeibo.h"
#import "XPHomeParams.h"
#import "SVPullToRefresh.h"
//音频播放的系统库
#import <AudioToolbox/AudioToolbox.h>

@interface XPHomeTableController ()
@property (nonatomic, strong)NSMutableArray *weibos;
@property (nonatomic, strong)XPHomeParams *homeParams;
@end

//声明音频id
SystemSoundID soundID = 0;

@implementation XPHomeTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建一个默认的请求参数
    self.homeParams = [XPHomeParams new];
    self.weibos = [NSMutableArray array];
    
    //    绑定id
    NSString *path = [[NSBundle mainBundle]pathForResource:@"msgcome" ofType:@"wav"];
    NSURL *url = [NSURL fileURLWithPath:path];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &soundID);
    
    
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XPWeiboCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    
    //去掉tableView的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    __block XPHomeTableController *weakSelf = self;
    //设置下拉刷新
    [self.tableView addPullToRefreshWithActionHandler:^{
        //下拉刷新时 新的数据肯定是在第一页
        weakSelf.homeParams.page = 1;
        //如果请求过数据
        if (weakSelf.weibos.count>0) {
            //得到自己手里最新的微博
            XPWeibo *w = [weakSelf.weibos firstObject];
            //            设置最新微博id 为了要比我这条更新的微博
            weakSelf.homeParams.since_id = w.wid;
            
        }
        
        //判断如果登陆之后再请求
        if ([XPAccount sharedAccount]) {
            [XPWeiboUtils requestHomeWeibosWithHomeParams:weakSelf.homeParams andCallback:^(id obj) {
                
                NSArray *newWeibos = obj;
                
                [weakSelf.weibos insertObjects:newWeibos atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newWeibos.count)]];
                NSLog(@"新的微博数量为：%ld",newWeibos.count);
                if (newWeibos.count>0) {
                    [weakSelf showNewCountLabel:newWeibos.count];
                }
                
                
                [weakSelf.tableView reloadData];
                
                //结束动画
                [weakSelf.tableView.pullToRefreshView stopAnimating];
            }];
        }
    }];
    
    
    //自动触发下拉刷新
    //    [self.tableView triggerPullToRefresh];
    
    
    //设置上拉加载
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        //加载老微博时不能设置sinceid 不然什么都拿不到
        weakSelf.homeParams.since_id = @"0";
        
        //判断如果登陆之后再请求
        if ([XPAccount sharedAccount]) {
            
            
            weakSelf.homeParams.page = weakSelf.weibos.count/weakSelf.homeParams.count+1;
            
            
            [XPWeiboUtils requestHomeWeibosWithHomeParams:weakSelf.homeParams andCallback:^(id obj) {
                
                NSArray *newWeibos = obj;
                
                [weakSelf.weibos addObjectsFromArray:newWeibos];
                NSLog(@"老的微博数量为：%ld",newWeibos.count);
                [weakSelf.tableView reloadData];
                
                //结束动画
                [weakSelf.tableView.infiniteScrollingView stopAnimating];
            }];
        }
        
        
        
    }];
    
    

}

-(void)showNewCountLabel:(NSInteger)count{
    //把提示数量清空
    self.tabBarItem.badgeValue = nil;
    
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, -20, kScreenWidth, 20)];
    lable.backgroundColor = [UIColor orangeColor];
    lable.text = [NSString stringWithFormat:@"有%ld条新微博",count];
    lable.textColor = [UIColor whiteColor];
    lable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lable];
    
    [UIView animateWithDuration:.75 animations:^{
        lable.transform = CGAffineTransformMakeTranslation(0, 20);
        
        
        //播放音效
        AudioServicesPlaySystemSound(soundID);
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:.5 delay:.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
            lable.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [lable removeFromSuperview];
        }];
        
        
        
    }];
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //每次页面显示 触发下拉刷新
    [self.tableView triggerPullToRefresh];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.weibos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XPWeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    cell.weibo = self.weibos[indexPath.row];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XPWeibo *w = self.weibos[indexPath.row];
    
    return [w getWeiboHeight]+91;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XPDetailTableController *vc = [XPDetailTableController new];
    vc.weibo = self.weibos[indexPath.row];
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
}
@end
