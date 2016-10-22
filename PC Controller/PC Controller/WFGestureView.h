//
//  WFGestureView.h
//  PC Controller
//
//  Created by iOS-aFei on 16/10/14.
//  Copyright © 2016年 iOS-aFei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WFGestureView : UIView

@property (nonatomic, copy) void(^handelGesture) (NSDictionary *dictionary);

@end

