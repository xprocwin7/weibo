//
//  XPFaceView.m
//  weibo
//
//  Created by dragon on 16/6/21.
//  Copyright © 2016年 win. All rights reserved.
//

#import "XPFaceView.h"

@implementation XPFaceView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIScrollView *faceSV = [[UIScrollView alloc]initWithFrame:self.bounds];
        [self addSubview:faceSV];
        
        NSString *path = [[NSBundle mainBundle]pathForResource:@"default" ofType:@"plist"];
        
        NSArray *faceArr = [NSArray arrayWithContentsOfFile:path];
        self.faceArr = faceArr;
        
        float size = 375/8.0;
        
        for (int i=0; i<faceArr.count; i++) {
            UIButton *faceBtn = [[UIButton alloc]initWithFrame:CGRectMake(i%32%8*size + i/32*375, i%32/8*size, size, size)];
            NSDictionary *faceDic = faceArr[i];
            
            [faceBtn setImage:[UIImage imageNamed:faceDic[@"png"]] forState:UIControlStateNormal];
            
            [faceSV addSubview:faceBtn];
            
            faceBtn.tag = i;
            [faceBtn addTarget:self action:@selector(tapFaceAction:) forControlEvents:UIControlEventTouchUpInside];
        }
        NSInteger page = faceArr.count%32==0?faceArr.count/32 : faceArr.count/32+1;
        faceSV.contentSize = CGSizeMake(375*page, 0);
        faceSV.pagingEnabled = YES;
        
        
        
    }
    return self;
}

-(void)tapFaceAction:(UIButton *)faceBtn{
    
    NSDictionary *faceDic = self.faceArr[faceBtn.tag];
    
    NSString *text = faceDic[@"chs"];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"FaceNotification" object:text];
    
    
}

@end
