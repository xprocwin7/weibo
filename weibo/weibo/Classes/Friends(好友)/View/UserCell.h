//
//  UserCell.h
//  weibo
//
//  Created by tarena on 16/6/21.
//  Copyright © 2016年 win. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XPUser.h"
@interface UserCell : UICollectionViewCell

@property (nonatomic, strong)XPUser *user;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headIV;

@end
