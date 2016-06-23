//
//  XPWeiboImageView.m
//  weibo
//
//  Created by dragon on 16/6/20.
//  Copyright © 2016年 win. All rights reserved.
//

#import "XPWeiboImageView.h"
#import "PhotoBroswerVC.h"

@implementation XPWeiboImageView
-(void)setImages:(NSArray *)images{
    
    _images = images;
    //清空原来的内容
    for (UIView *v in self.subviews) {
        [v removeFromSuperview];
    }
    
    
    //2种情况
    if (images.count==1) {//1张
        NSDictionary *imageDic = [images firstObject];
        
        NSString *path = imageDic[@"thumbnail_pic"];
        
        UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(kMargen, 0, kScreenWidth-2*kMargen, 200)];
        [self addSubview:iv];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        [iv setImageWithURL:[NSURL URLWithString:path]];
        //超出范围不显示
        iv.clipsToBounds = YES;
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [iv addGestureRecognizer:tap];
        iv.userInteractionEnabled  = YES;
    }else{//多张
        
        for (int i=0; i<images.count; i++) {
            NSDictionary *imageDic = images[i];
            
            NSString *path = imageDic[@"thumbnail_pic"];
            
            UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(i%3*(kImageSize+kMargen) + kMargen,i/3*(kImageSize+kMargen),kImageSize,kImageSize)];
            iv.contentMode = UIViewContentModeScaleAspectFill;
            [self addSubview:iv];
            [iv setImageWithURL:[NSURL URLWithString:path]];
            iv.clipsToBounds = YES;
            iv.tag = i;
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
            [iv addGestureRecognizer:tap];
            iv.userInteractionEnabled  = YES;
        }
        
        
        
        
    }
    
}
//*****************************
-(void)tapAction:(UITapGestureRecognizer *)tap{
    //得到点击到的图片
    UIImageView *iv = (UIImageView *)tap.view;
    //[UIApplication sharedApplication].keyWindow.rootViewController 得到的是当前程序window的根页面
    [PhotoBroswerVC show:[UIApplication sharedApplication].keyWindow.rootViewController type:PhotoBroswerVCTypeZoom index:iv.tag photoModelBlock:^NSArray *{
        
        NSMutableArray *modelsM = [NSMutableArray arrayWithCapacity:self.images.count];
        
        
        for (NSUInteger i = 0; i< self.images.count; i++) {
            PhotoModel *pbModel=[[PhotoModel alloc] init];
            pbModel.mid = i + 1;
            
            
            NSDictionary *imageDic = self.images[i];
            
            NSString *path = imageDic[@"thumbnail_pic"];
            
            //设置查看大图的时候的图片地址
            pbModel.image_HD_U = [path stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
            
            //源图片的frame
            pbModel.sourceImageView = iv;
            [modelsM addObject:pbModel];
        }
        return modelsM;
    }];
    
}
//************************

@end
