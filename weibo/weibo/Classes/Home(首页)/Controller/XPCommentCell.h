//
//  XPCommentCell.h
//  weibo
//
//  Created by tarena on 16/6/19.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XPComment.h"
@interface XPCommentCell : UITableViewCell

@property (nonatomic, strong)XPComment *comment;
@property (nonatomic, strong)UILabel *commentTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headIV;
@end
