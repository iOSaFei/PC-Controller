//
//  WFLightnessAndVolume.h
//  PC Controller
//
//  Created by iOS-aFei on 16/10/5.
//  Copyright © 2016年 iOS-aFei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WFLightnessAndVolume : UIView

@property (nonatomic, copy) void(^lProgressChanged)(NSString *value);
@property (nonatomic, copy) void(^vProgressChanged)(NSString *value);
- (void)showWithDuration:(NSTimeInterval)duration;

@end
