//
//  MyPcTableView.h
//  西邮快传1.0
//
//  Created by iOS 阿飞 on 16/1/27.
//  Copyright © 2016年 iOS 阿飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyPcTableViewDeleate <NSObject>

@required

- (void)myPcTableViewCmd:(NSDictionary *)diskCmdDic;

@end
@interface MyPcTableView : UITableView<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, weak) id<MyPcTableViewDeleate>myPcTvcDeleate;
@property(nonatomic, strong) UIActivityIndicatorView *activity;
@property(nonatomic, strong) NSArray *diskArray;

@end
