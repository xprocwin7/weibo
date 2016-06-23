//
//  XPFaceUtils.m
//  weibo
//
//  Created by dragon on 16/6/21.
//  Copyright © 2016年 win. All rights reserved.
//

#import "XPFaceUtils.h"

@implementation XPFaceUtils
+(void)faceBindingWithTextView:(YYTextView *)textView{
    
    
    //如何在文本中显示表情
    YYTextSimpleEmoticonParser *parser = [[YYTextSimpleEmoticonParser alloc]init];
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"default" ofType:@"plist"];
    
    NSArray *faceArr = [NSArray arrayWithContentsOfFile:path];
    NSMutableDictionary *emoticonMapper = [NSMutableDictionary dictionary];
    
    for (NSDictionary *faceDic in faceArr) {
        NSString *text = faceDic[@"chs"];
        NSString *imageName = faceDic[@"png"];
        
        [emoticonMapper setObject:[UIImage imageNamed:imageName] forKey:text];
    }
    
    parser.emoticonMapper = emoticonMapper;
    
    textView.textParser = parser;
}

@end
