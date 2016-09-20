//
//  WFPopController.m
//  PC Controller
//
//  Created by iOS-aFei on 16/9/13.
//  Copyright © 2016年 iOS-aFei. All rights reserved.
//

#import "WFPopController.h"

@implementation WFPopController
{
    NSArray *_cellTextArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _cellTextArray = @[ @"扫码连接", @"输入连接" ];
    self.tableView.rowHeight = 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CELL_ID = @"popCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CELL_ID];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.font  = [UIFont systemFontOfSize:14];
    }
    cell.textLabel.text  = _cellTextArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _cellDidSelected(indexPath.row);
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
