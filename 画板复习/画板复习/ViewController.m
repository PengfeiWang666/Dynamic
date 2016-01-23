//
//  ViewController.m
//  画板复习
//
//  Created by rzj on 16/1/6.
//  Copyright © 2016年 rzj. All rights reserved.
//

#import "ViewController.h"
#import "DrawingBoard.h"
#import "PhotoView.h"
#import "UIImage+Tools.h"

@interface ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UISlider *slider;

/** 画板 */
@property (weak, nonatomic) IBOutlet DrawingBoard *drawingView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)clearScreen:(id)sender {
    
    [_drawingView clearScreen];
}

- (IBAction)undo:(id)sender {
    
    [_drawingView undo];
}

- (IBAction)eraser:(id)sender {
    
    _drawingView.color = self.view.backgroundColor;
    
}
- (IBAction)sliderDidClick:(UISlider *)sender {
    
    _drawingView.lineW = sender.value;
    
}
- (IBAction)selectPhoto:(id)sender {
    
    //创建图片选择器
    UIImagePickerController *pickerView = [[UIImagePickerController alloc] init];
    
    //设置图片获取的数据源 (相机)
    pickerView.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    pickerView.delegate = self;
    
    [self presentViewController:pickerView animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {

    //处理BUG
    [_drawingView clearScreen];
    
    for (UIView *view in self.view.subviews ) {
        
        if ([view isKindOfClass:[PhotoView class]]) {
            
            [view removeFromSuperview];
            
        }
        
        
    }
    
    
    //获取用户选取的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    //初始化自定义view并且设置位置与画板一样
    PhotoView *view = [[PhotoView alloc]initWithFrame:_drawingView.frame];
    
    //传入图片
    view.img=image;
    
    //将自定义view加到父view 不是添加到_drawingView上 因为PhotoView设置的时父view的frame
    [self.view addSubview:view];
    

    //拿到截图的图片
    view.photoBlock = ^(UIImage *img) {
    
        //传给画板 画到屏幕
        _drawingView.selectImg = img;
    
    };
   
    //获取图片后关闭图片选择器
    [self dismissViewControllerAnimated:YES completion:nil];


}

- (IBAction)save:(id)sender {
    
    UIImage *img =  [UIImage getClipScrennImage:_drawingView];
    
    //保存到相册
    UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {

    if (!error) {
        
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"提示" message:@"保存成功!" preferredStyle:UIAlertControllerStyleAlert];
        
        [controller addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        
        
        [self presentViewController:controller animated:YES completion:nil];
    }

}


//由于路径的颜色只能设置一种 所以需要给路径增加自定义颜色属性
- (IBAction)selectColor:(UIButton *)sender {
    
    _drawingView.color = sender.backgroundColor;
    
}

@end
