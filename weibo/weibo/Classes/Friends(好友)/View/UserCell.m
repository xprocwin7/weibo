//
//  UserCell.m
//  weibo
//
//  Created by tarena on 16/6/21.
//  Copyright © 2016年 win. All rights reserved.
//

#import "UserCell.h"

@implementation UserCell

- (void)awakeFromNib {
    // Initialization code
}


-(void)setUser:(XPUser *)user{
    _user = user;
    
    self.nameLabel.text = user.name;
    [self.headIV setImageWithURL:[NSURL URLWithString:user.avatar_large]];
}
@end
