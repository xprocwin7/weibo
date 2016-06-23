//
//  XPDetailTableController.m
//  weibo
//
//  Created by dragon on 16/6/20.
//  Copyright © 2016年 win. All rights reserved.
//

#import "XPDetailTableController.h"
#import "XPComment.h"
#import "XPWeiboView.h"
#import "XPCommentCell.h"

@interface XPDetailTableController ()
@property (nonatomic, strong)NSArray *comments;
@end

@implementation XPDetailTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    XPWeiboView *wv = [[XPWeiboView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, [self.weibo getWeiboHeight])];
    wv.weibo = self.weibo;
    
    self.tableView.tableHeaderView = wv;
    
    UIBarButtonItem *commentItem = [[UIBarButtonItem alloc]initWithTitle:@"评论" style:UIBarButtonItemStyleDone target:self action:@selector(commentAction)];
    self.navigationItem.rightBarButtonItem = commentItem;
    
    
    [self loadComments];
    
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XPCommentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    
}

-(void)loadComments{
    [XPWeiboUtils requestCommentsWithWID:self.weibo.wid andCallback:^(id obj) {
        
        
        self.comments = obj;
        
        [self.tableView reloadData];
        
        
    }];
}

- (void)commentAction {
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入评论的内容？" preferredStyle:UIAlertControllerStyleAlert];
    
    [ac addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"说点什么吧。。。";
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //得到用户输入的内容
        UITextField *tf = ac.textFields[0];
        [XPWeiboUtils sendCommentWithText:tf.text andWID:self.weibo.wid andCallback:^(id obj) {
            
            
            [self loadComments];
            
        }];
        
        
        
        
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [ac addAction:action1];
    [ac addAction:action2];
    [self presentViewController:ac animated:YES completion:nil];
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.comments.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XPCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.comment = self.comments[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XPComment *c = self.comments[indexPath.row];
    
    return 66+[c getTextHeight]+kMargen;
}
@end
