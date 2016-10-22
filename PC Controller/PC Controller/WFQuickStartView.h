//
//  WFQuickStartView.h
//  PC Controller
//
//  Created by iOS-aFei on 16/10/5.
//  Copyright © 2016年 iOS-aFei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WFQuickStartView : UIView

@property (nonatomic, copy) void (^touchEnded)(NSString *key);

@end
