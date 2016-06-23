//
//  XPSettingsTableController.m
//  weibo
//
//  Created by dragon on 16/6/19.
//  Copyright © 2016年 win. All rights reserved.
//

#import "XPSettingsTableController.h"

@interface XPSettingsTableController ()

@end

@implementation XPSettingsTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }else
        return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) {
                cell.imageView.image = [UIImage imageNamed:@"hot_status"];
                cell.textLabel.text = @"热门微博";
            }else
            {
                cell.imageView.image = [UIImage imageNamed:@"find_people"];
                cell.textLabel.text = @"找人";
            }
            break;
            
        case 1:
            if (indexPath.row == 0) {
                cell.imageView.image = [UIImage imageNamed:@"game_center"];
                cell.textLabel.text = @"游戏中心";
            }else if(indexPath.row == 1)
            {
                cell.imageView.image = [UIImage imageNamed:@"near"];
                cell.textLabel.text = @"周边";
            }else
            {
                cell.imageView.image = [UIImage imageNamed:@"app"];
                cell.textLabel.text = @"应用";
            }
            break;
        case 2:
            if (indexPath.row == 0) {
                cell.imageView.image = [UIImage imageNamed:@"video"];
                cell.textLabel.text = @"视频";
            }else if(indexPath.row == 1)
            {
                cell.imageView.image = [UIImage imageNamed:@"music"];
                cell.textLabel.text = @"音乐";
            }else
            {
                cell.imageView.image = [UIImage imageNamed:@"movie"];
                cell.textLabel.text = @"电影";
            }
            break;
    }
    
    return cell;
}

@end
