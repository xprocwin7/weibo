//
//  UserInfoViewController.m
//  weibo
//
//  Created by tarena on 16/5/5.
//  Copyright © 2016年 win. All rights reserved.
//

#import "UserInfoViewController.h"

@interface UserInfoViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *coverIV;
@property (weak, nonatomic) IBOutlet UILabel *introTopLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameTopLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headIV;
@property (weak, nonatomic) IBOutlet UILabel *introLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *funsCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UILabel *nickLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headIV.layer.cornerRadius = self.headIV.bounds.size.height/2;
    self.headIV.layer.masksToBounds = YES;
    self.headIV.layer.borderWidth = 3;
    self.headIV.layer.borderColor = [UIColor whiteColor].CGColor;
    
    if (self.user) {//显示别人
        [self initUIWithUserInfo:self.user];
    }else{
        //发送请求
        [XPWeiboUtils requestUserInfoWithCallback:^(id obj) {
            
            [self initUIWithUserInfo:obj];
        }];
    }
}

-(void)initUIWithUserInfo:(XPUser *)userInfo{
    
    //判断是否有背景图片
    if (userInfo.cover_image_phone) {
        [self.coverIV setImageWithURL:[NSURL URLWithString:userInfo.cover_image_phone]];
    }
 
    self.nameLabel.text = self.nameTopLabel.text = userInfo.name;
    self.nickLabel.text = userInfo.name;
    self.introLabel.text = self.introTopLabel.text = userInfo.des;
    self.locationLabel.text = userInfo.location;
    
    [self.headIV setImageWithURL:[NSURL URLWithString:userInfo.avatar_large]];
    self.sexLabel.text = userInfo.gender;
    self.funsCountLabel.text = userInfo.friends_count.stringValue;
    
}

@end
