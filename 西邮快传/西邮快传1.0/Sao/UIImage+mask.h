//
//  UIImage+mask.h
//  tiaooo
//
//  Created by ClaudeLi on 16/4/22.
//  Copyright © 2016年 dali. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (mask)
/**
 *  遮罩层, RGBA=(0, 0, 0, 0.6)
 *
 *  @param maskRect  遮罩层的Rect
 *  @param clearRect 镂空的Rect
 *
 *  @return 遮罩层图片
 */
+ (UIImage *)maskImageWithMaskRect:(CGRect)maskRect clearRect:(CGRect)clearRect;

@end
