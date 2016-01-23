//
//  DarwingBoard.m
//  画板复习
//
//  Created by rzj on 16/1/6.
//  Copyright © 2016年 rzj. All rights reserved.
//

#import "DrawingBoard.h"
#import "MyBezierPath.h"

@interface DrawingBoard()

@property(nonatomic,strong) NSMutableArray *pathArray;

@end

@implementation DrawingBoard

- (NSMutableArray *)pathArray {

    if (_pathArray == nil) {
        
        _pathArray = [NSMutableArray array];
        
    }

    return _pathArray;
}

- (CGPoint)pointWithTouches:(NSSet *)touches {


    UITouch *touch =[touches anyObject];
    
    return [touch locationInView:self];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    //采用自定义路径 类方法快速创建路径
    MyBezierPath *path = [MyBezierPath myBezierPathWithLineW:_lineW lineColor:_color startPoint:[self pointWithTouches:touches]];

  
    
    //将路径追加到数组
    [self.pathArray addObject:path];

}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    //连写 取出数组中最后一个元素 因为上面设置的时路径起点 所以可以直接添加线段
    [[self.pathArray lastObject] addLineToPoint:[self pointWithTouches:touches]];
    
    [self setNeedsDisplay];

}


- (void)drawRect:(CGRect)rect {

    
    if (!self.pathArray.count) {
        
        return;
        
    }
  
    //遍历数组 渲染
    for (MyBezierPath *path in self.pathArray) {
        
        //可能是路径数组有图片 所以要判断
        if ([path isKindOfClass:[UIImage class]]) {
            
            UIImage *image = (UIImage *)path;
            
            [image drawAtPoint:CGPointZero];
            
        }else {
        
            //设置路径颜色
            [path.color set];
            
            [path stroke];
            
    
        }
     
    }
  

}

#warning 由于不知道用户什么时候选择图片 所以使用set方法 控制器传过来图片 马上画到画板
- (void)setSelectImg:(UIImage *)selectImg {


    _selectImg = selectImg;
    
    [self.pathArray addObject:selectImg];
    
    [self setNeedsDisplay];
    
//    [selectImg drawAtPoint:CGPointZero];
//    
//    [self setNeedsDisplay];

}

//初始化路径
- (void)awakeFromNib {


    _lineW = 2;

}

- (void)clearScreen {

    [self.pathArray removeAllObjects];
    
    [self setNeedsDisplay];

}

- (void)undo {

    [self.pathArray removeLastObject];
    
    [self setNeedsDisplay];

}
@end
