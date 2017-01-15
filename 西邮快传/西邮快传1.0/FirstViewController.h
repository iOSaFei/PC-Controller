//
//  FirstViewController.h
//  西邮快传1.0
//
//  Created by iOS 阿飞 on 16/1/29.
//  Copyright © 2016年 iOS 阿飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CmdAsyncSocketModel.h"
#import "MyPcTableViewController.h"
#import "MyPcTableView.h"
#import "CodeJSON.h"

@interface FirstViewController : UIViewController<CmdAsycnSocketModelDelegate,MyPcTableViewDeleate>
@property(nonatomic, strong) MyPcTableView *myPcTableView;
@end
