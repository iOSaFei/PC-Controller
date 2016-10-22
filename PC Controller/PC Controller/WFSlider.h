//
//  WFSlider.h
//  WFSlider
//
//  Created by iOS-aFei on 16/10/5.
//  Copyright © 2016年 iOS-aFei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WFSlider : UISlider

@property (nonatomic, copy) void (^progressChanged)(NSString *number);

@end
