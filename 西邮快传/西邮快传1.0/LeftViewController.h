//
//  LeftViewController.h
//  西邮快传1.0
//
//  Created by iOS 阿飞 on 16/1/26.
//  Copyright © 2016年 iOS 阿飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CmdAsyncSocketModel.h"
#import "FileAsyncSocketModel.h"
#import "CodeJSON.h"


@interface LeftViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,CmdAsycnSocketModelDelegate,FileAsycnSocketModelDelegate>
@property(nonatomic, strong) CmdAsyncSocketModel *cmdAsyncSocketModel;
@property(nonatomic, strong) FileAsyncSocketModel *fileAsyncSocketModel;
@property(nonatomic, strong) UITableView *leftTableView;
@property(nonatomic, strong) UIButton *conectOrCutButton;
@property(nonatomic, strong) NSArray *titleArray;

@end
