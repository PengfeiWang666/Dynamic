//
//  DarwingBoard.h
//  画板复习
//
//  Created by rzj on 16/1/6.
//  Copyright © 2016年 rzj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawingBoard : UIView

/** 清屏 */
- (void)clearScreen;

/** 撤销 */
-(void)undo;

/** 控制器传回的颜色 用于橡皮擦功能或者颜色选择 */
@property(nonatomic,strong) UIColor *color;

/** 用户选择的路径宽度 默认为2 */
@property(nonatomic,assign) CGFloat lineW;

/** 用户选择的图片 */
@property(nonatomic,strong) UIImage *selectImg;
@end
