//
//  UIImage+mask.m
//  tiaooo
//
//  Created by ClaudeLi on 16/4/22.
//  Copyright © 2016年 dali. All rights reserved.
//

#import "UIImage+mask.h"

@implementation UIImage (mask)

+ (UIImage *)maskImageWithMaskRect:(CGRect)maskRect clearRect:(CGRect)clearRect{
    UIGraphicsBeginImageContext(maskRect.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(ctx, 0,0,0,0.6);
    CGRect drawRect =maskRect;
    
    CGContextFillRect(ctx, drawRect);   //draw the transparent layer
    
    drawRect = clearRect;
    CGContextClearRect(ctx, drawRect);  //clear the center rect  of the layer
    
    UIImage* returnimage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return returnimage;
}

@end
