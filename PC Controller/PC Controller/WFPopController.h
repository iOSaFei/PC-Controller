//
//  WFPopController.h
//  PC Controller
//
//  Created by iOS-aFei on 16/9/13.
//  Copyright © 2016年 iOS-aFei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WFPopController : UITableViewController

@property (nonatomic, copy) void (^cellDidSelected)(NSUInteger row);

@end
