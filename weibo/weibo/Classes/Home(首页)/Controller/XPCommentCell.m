//
//  XPCommentCell.m
//  weibo
//
//  Created by tarena on 16/6/19.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "XPCommentCell.h"

@implementation XPCommentCell

-(void)awakeFromNib{
    
    self.commentTextLabel = [[UILabel alloc]initWithFrame:CGRectMake(kMargen, CGRectGetMaxY(self.headIV.frame)+kMargen, kScreenWidth-2*kMargen, 0)];
    self.commentTextLabel.font = [UIFont systemFontOfSize:kTextSize];
 
    [self addSubview:self.commentTextLabel];
    
}

-(void)setComment:(XPComment *)comment{
    _comment = comment;
    
    self.nameLabel.text = comment.user.name;
    self.sourceLabel.text = comment.source;
    self.timeLabel.text = comment.created_at;
    [self.headIV setImageWithURL:[NSURL URLWithString:comment.user.avatar_large]];

    //控制显示文本内容
    self.commentTextLabel.text = comment.text;
    
    CGRect frame = self.commentTextLabel.frame;
    frame.size.height = [comment getTextHeight];
    self.commentTextLabel.frame = frame;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
