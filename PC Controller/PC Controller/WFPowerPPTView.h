//
//  WFPowerPPTView.h
//  PC Controller
//
//  Created by iOS-aFei on 16/9/15.
//  Copyright © 2016年 iOS-aFei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WFPowerPPTView : UIView

- (instancetype)initWithFrame:(CGRect)frame tittle:(NSArray<NSString *> *)tittleArray;
- (void)apperAnimation;
- (void)disapperAnimation;
@end
