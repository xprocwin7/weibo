//
//  XPSendingViewController.m
//  weibo
//
//  Created by dragon on 16/6/19.
//  Copyright © 2016年 win. All rights reserved.
//

#import "XPSendingViewController.h"
#import "YYTextView.h"
#import "XPFaceView.h"
#import "XPFaceUtils.h"
@interface XPSendingViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *toolBar;
@property (nonatomic, strong)YYTextView *textView;
@property (nonatomic, strong)UIImageView *imageView;
@property (nonatomic, strong)NSData *imageData;
@property (nonatomic, strong)XPFaceView *faceView;
@end

@implementation XPSendingViewController

-(XPFaceView *)faceView{
    if (!_faceView) {
        _faceView = [[XPFaceView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 216)];
    }
    return _faceView;
}


-(UIImageView *)imageView{
    
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(kMargen, 250, 100, 100)];
        [self.view addSubview:_imageView];
    }
    
    return _imageView;
    
}

- (IBAction)imageAction:(id)sender {
    UIImagePickerController *vc = [UIImagePickerController new];
    vc.delegate = self;
    
    [self presentViewController:vc animated:YES completion:nil];
}
- (IBAction)faceAction:(id)sender {

    self.textView.inputView = self.faceView;
    
    //修改完软键盘后 需要刷新
    [self.textView reloadInputViews];
}



//-(YYTextView *)textView{
//    
//    if (!_textView) {
//        _textView = [[YYTextView alloc]initWithFrame:CGRectMake(kMargen, kMargen+64, kScreenWidth-2*kMargen, 150)];
//        _textView.backgroundColor = [UIColor yellowColor];
//        
//        [self.view addSubview:_textView];
//        
//        
//        //软键盘的附属视图 不能存在于sb中
//        [self.toolBar removeFromSuperview];
//        
//        _textView.inputAccessoryView = self.toolBar;
//    }
//    
//    return _textView;
//}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //进入页面的时候让文本输入框 开始响应
    [self.textView becomeFirstResponder];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textView = [[YYTextView alloc]initWithFrame:CGRectMake(100, 100, 200, 50)];
    self.textView.backgroundColor = [UIColor yellowColor];
    
    [self.view addSubview:self.textView];
    
    [XPFaceUtils faceBindingWithTextView:self.textView];
    
    self.title = @"新建微博";
    
    UIBarButtonItem *cancleItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelAction)];
    
    UIBarButtonItem *sendItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(sendAction)];
    
    
    self.navigationItem.leftBarButtonItem = cancleItem;
    self.navigationItem.rightBarButtonItem = sendItem;
    
    
    
    //    //添加软键盘的监听
    //     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardFrameChangeAction:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    
}

//-(void)faceBtnAction:(NSNotification *)noti{
//    NSString *text = noti.object;
//    
//    [self.textView insertText:text];
//    
//    
//}
//

//-(void)keyboardFrameChangeAction:(NSNotification *)noti{
//
//    NSLog(@"%@",noti);
//     CGRect keyboradFrame =  [noti.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
//
//    if (keyboradFrame.origin.y==667) {//收软键盘
//        //让 transform 重置  也就是让位置恢复
//        self.toolbar.transform = CGAffineTransformIdentity;
//
//    }else{//软键盘弹出
//        //让bar往上移动 软键盘的高度的距离
//        self.toolbar.transform = CGAffineTransformMakeTranslation(0, -keyboradFrame.size.height);
//
//
//    }
//
//
//}

- (void)sendAction{
    
    if (self.imageData) {
        //发送带图微博
        [XPWeiboUtils sendWeiboWithText:self.textView.text andImageData:self.imageData andCallback:^(id obj) {
            
            //发送完直接返回上一页面
            [self dismissViewControllerAnimated:YES completion:nil];
            
            
        }];
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }else{//不带图
        
        
        [XPWeiboUtils sendWeiboWithText:self.textView.text andCallback:^(id obj) {
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }];
        
    }
    
}




- (void)cancelAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    //把image转成data
    
    //    判断图片类型
    NSURL *imageUrl = info[UIImagePickerControllerReferenceURL];
    NSString *imagePath = [imageUrl description];
    
    
    if ([imagePath hasSuffix:@"PNG"]) {
        self.imageData = UIImagePNGRepresentation(image);
    }else{//jpg图片  0-1 压缩百分比
        self.imageData = UIImageJPEGRepresentation(image, .5);
        
    }
    
    
    self.imageView.image = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
