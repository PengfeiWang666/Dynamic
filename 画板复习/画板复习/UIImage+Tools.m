//
//  UIImage+Tools.m
//  画板复习
//
//  Created by rzj on 16/1/6.
//  Copyright © 2016年 rzj. All rights reserved.
//

#import "UIImage+Tools.h"

@implementation UIImage (Tools)

+ (UIImage *)getClipScrennImage:(UIView *)view {
    
    //开启上下文
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
    
    //获取当前上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //将图层保存到上下文中
    [view.layer renderInContext:ctx];
    
    //获取上下文图片
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
#warning 记住关闭上下文
    UIGraphicsEndImageContext();
    
    return img;
    
}

@end
