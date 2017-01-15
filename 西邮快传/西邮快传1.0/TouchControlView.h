//
//  TouchControlView.h
//  西邮快传1.0
//
//  Created by iOS-aFei on 16/5/11.
//  Copyright © 2016年 iOS 阿飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CodeJSON.h"
#import "CmdAsyncSocketModel.h"
@interface TouchControlView : UIView
@property(nonatomic, strong) CmdAsyncSocketModel *cmdAsyncSocketModel;
@end
