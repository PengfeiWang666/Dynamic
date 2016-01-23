//
//  MyBezierPath.m
//  画板复习
//
//  Created by rzj on 16/1/6.
//  Copyright © 2016年 rzj. All rights reserved.
//

#import "MyBezierPath.h"

@implementation MyBezierPath

+ (instancetype)myBezierPathWithLineW:(CGFloat)lineW lineColor:(UIColor *)color startPoint:(CGPoint)point {

    MyBezierPath *path = [MyBezierPath bezierPath];

    path.lineWidth = lineW;
    
    path.color = color;
    
    path.lineCapStyle = kCGLineCapRound;
    
    path.lineJoinStyle = kCGLineJoinRound;
    
    [path moveToPoint:point];
    
    return path;

}
@end
