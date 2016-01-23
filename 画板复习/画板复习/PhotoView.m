//
//  PhotoView.m
//  画板复习
//
//  Created by rzj on 16/1/6.
//  Copyright © 2016年 rzj. All rights reserved.
//

#import "PhotoView.h"
#import "UIImage+Tools.h"

@interface PhotoView()<UIGestureRecognizerDelegate>

@property(nonatomic,weak) UIImageView *imgView;

@end

@implementation PhotoView

/** 根据画板设置的位置初始化自定view 并且调用方法 */
- (instancetype)initWithFrame:(CGRect)frame {

    if (self == [super initWithFrame:frame]) {
        
        
        [self addImageView];
        
        [self addGestureRecognizer];
        
    }

    return self;
}

- (void)addGestureRecognizer {

    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(LongPressGestureRecognizer:)];

    [_imgView addGestureRecognizer:longPress];
    
    [self addPinchGestureRecognizer];
    
    [self addRotationGestureRecognizer];

}

- (void)LongPressGestureRecognizer:(UILongPressGestureRecognizer *)longPress {

    //长按结束
    if (longPress.state == UIGestureRecognizerStateEnded) {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            _imgView.alpha = 0.5;
            
        } completion:^(BOOL finished) {
            
            
           [UIView animateWithDuration:0.5 animations:^{
               
               _imgView.alpha = 1;
               
           } completion:^(BOOL finished) {
               
              
               // 截图
               UIImage *clipImg = [UIImage getClipScrennImage:self];
               
               //回传
               _photoBlock(clipImg);
               
               //移除自己 否则画板无法画画
               [self removeFromSuperview];
               
               
           }];
            
        }];
        
        
        
    }


}


//多个手势识别 必须设代理
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    
    return YES;
    
}



- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    //获取touch对象
    UITouch *touch =[touches anyObject];
    
    //获取当前点
    CGPoint currPoint = [touch locationInView:self];
    
    //获取上一个点
    CGPoint preivous = [touch previousLocationInView:self];
    
    //计算偏移量
    CGFloat offestX = currPoint.x - preivous.x;
    CGFloat offestY = currPoint.y - preivous.y;
    
    //赋值
    CGPoint center = self.center;
    
    center.x += offestX;
    center.y += offestY;
    
    self.center = center;
    
}

/** 添加旋转手势 */
- (void)addRotationGestureRecognizer {
    
    
    UIRotationGestureRecognizer *rote = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(RotationGestureRecognizer:)];
    
    rote.delegate = self;
    
    [_imgView addGestureRecognizer:rote];
    
}

- (void)RotationGestureRecognizer:(UIRotationGestureRecognizer *)rote
{
    
    _imgView.transform = CGAffineTransformRotate(_imgView.transform,rote.rotation);
    
    //归位
    rote.rotation = 0;
    
}

/**缩放*/
- (void)addPinchGestureRecognizer {
    
    
    UIPinchGestureRecognizer *pin = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(PinchGestureRecognizer:)];
    
    pin.delegate = self;
    
    [_imgView addGestureRecognizer:pin];
    
}

- (void)PinchGestureRecognizer:(UIPinchGestureRecognizer *) pin{
    
    
    _imgView.transform = CGAffineTransformScale(_imgView.transform, pin.scale, pin.scale);
    
    //复位
    pin.scale = 1;
    
    
}

- (void)setImg:(UIImage *)img {

    _img = img;
    
    _imgView.image = img;

}


//此方法只会在初始化的时候调用 因此重写img的set方法 传入图片立刻设置上去
- (void)addImageView {


    UIImageView *imgView = [[UIImageView alloc]initWithFrame:self.bounds];
    
    _imgView = imgView;
    
    //开启用户交互
    imgView.userInteractionEnabled = YES;
    
    [self addSubview:imgView];

}

@end
