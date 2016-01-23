//
//  MyBezierPath.h
//  画板复习
//
//  Created by rzj on 16/1/6.
//  Copyright © 2016年 rzj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyBezierPath : UIBezierPath

/** 自定义路径颜色 */
@property(nonatomic,strong) UIColor *color;

/** 快速创建路径 初始化路径宽度，颜色，起点 */
+ (instancetype)myBezierPathWithLineW:(CGFloat)lineW lineColor:(UIColor *)color startPoint:(CGPoint)point;
@end
