//
//  WFQuickText.m
//  PC Controller
//
//  Created by iOS-aFei on 16/10/15.
//  Copyright © 2016年 iOS-aFei. All rights reserved.
//

#import "WFQuickText.h"

@interface WFQuickText () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *infoArray;

@end

@implementation WFQuickText

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.separatorStyle  = UITableViewCellSeparatorStyleNone;
        self.delegate        = self;
        self.dataSource      = self;
        self.rowHeight       = 30;
        self.layer.cornerRadius  = 20;
        self.layer.masksToBounds = YES;
    }
    return self;
}
- (NSArray *)infoArray {
    if (!_infoArray) {
        _infoArray = @[ @"多数字滑动有效",
                        @"1:打开cmd",
                        @"2:打开任务管理器",
                        @"3:打开资源管理器",
                        @"4:打开设备管理器",
                        @"5:打开磁盘管理器",
                        @"6:打开注册表编辑器",
                        @"7:打开计算器",
                        @"8:打开记事本",
                        @"9:打开画图板",
                        @"147:打开写字板",
                        @"258:打开浏览器",
                        @"123:关闭当前窗口",
                        @"456:ESC键",
                        @"789:回车"
                        ];
    }
    return _infoArray;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.infoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CELLID = @"quickCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLID];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    cell.textLabel.text      = _infoArray[indexPath.row];
    cell.textLabel.textColor = kMainColor;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:16.0];
    return cell;
}

@end
