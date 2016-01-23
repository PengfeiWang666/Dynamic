//
//  PhotoView.h
//  画板复习
//
//  Created by rzj on 16/1/6.
//  Copyright © 2016年 rzj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PhotoViewBlock)(UIImage *);

@interface PhotoView : UIView

/** 从画板传入的图片 */
@property(nonatomic,strong) UIImage  *img;

@property(nonatomic,copy) PhotoViewBlock photoBlock;
@end
