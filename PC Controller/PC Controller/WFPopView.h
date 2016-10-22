//
//  WFPopView.h
//  WFSlider
//
//  Created by iOS-aFei on 16/10/5.
//  Copyright © 2016年 iOS-aFei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WFPopView : UIImageView

- (void)contendChanged:(NSString *)string;
- (void)showWithContent:(NSString *)string duration:(NSTimeInterval)duration;
- (void)hideWithDuration:(NSTimeInterval) duration;

@end
