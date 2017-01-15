//
//  MyPcTableViewController.h
//  西邮快传1.0
//
//  Created by iOS 阿飞 on 16/1/27.
//  Copyright © 2016年 iOS 阿飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FileAsyncSocketModel.h"
#import "CmdAsyncSocketModel.h"
#import "CodeJSON.h"
@interface MyPcTableViewController : UITableViewController<CmdAsycnSocketModelDelegate>
@property(nonatomic, strong)UIActivityIndicatorView *activity;
@property(nonatomic, strong)NSArray *diskTvArray;
@end
