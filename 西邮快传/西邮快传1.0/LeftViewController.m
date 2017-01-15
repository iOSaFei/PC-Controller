//
//  LeftViewController.m
//  西邮快传1.0
//
//  Created by iOS 阿飞 on 16/1/26.
//  Copyright © 2016年 iOS 阿飞. All rights reserved.
//

#import "LeftViewController.h"

@interface LeftViewController ()

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    _titleArray = @[@"连接管理", @"使用说明", @"快传设置", @"我的反馈", @"关于快传"];
    [self initLeftTableView];
    [self initNotificationCenter];
}
- (void)initLeftTableView {
    _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(kWindowWidth/4, 0, kWindowWidth*3/4, kWindowHeight)];
    _leftTableView.backgroundColor = [UIColor clearColor];
    _leftTableView.dataSource = self;
    _leftTableView.delegate = self;
    _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_leftTableView];
}
- (void)initNotificationCenter {
    
    NSNotificationCenter *sweepNotificationCenter = [NSNotificationCenter defaultCenter];
    [sweepNotificationCenter addObserver:self selector:@selector(conect:) name:@"sweep" object:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;{
    return _titleArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.backgroundColor = [UIColor clearColor];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self setCell:cell index:indexPath];
    return cell;
}
- (void)setCell:(UITableViewCell *)cell index:(NSIndexPath *) indexPath{
    cell.textLabel.text = [_titleArray objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont systemFontOfSize:20];
    cell.imageView.image = [UIImage imageNamed:@"question"];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (kWindowHeight-kWindowHeight/3.0-kWindowHeight/10.0)/6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kWindowHeight/3.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return kWindowHeight/10.0;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIImageView *macImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 40, kWindowWidth/4, kWindowWidth/4)];
    macImageView.backgroundColor = [UIColor whiteColor];
    macImageView.layer.cornerRadius = kWindowWidth/8;
    macImageView.layer.masksToBounds = YES;
    UIImageView *subIamgeView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, kWindowWidth/4 - 20, kWindowWidth/4 - 20)];
    subIamgeView.image = [UIImage imageNamed:@"computerIcon"];
    [macImageView addSubview:subIamgeView];
    
    _conectOrCutButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _conectOrCutButton.frame = CGRectMake(kWindowWidth/2, 40 + kWindowWidth/8, kWindowWidth/8, kWindowWidth/8);
    [_conectOrCutButton setTitle:@" " forState:UIControlStateNormal];
    _conectOrCutButton.tintColor = [UIColor whiteColor];
    [_conectOrCutButton setBackgroundImage:[UIImage imageNamed:@"saoyisao"] forState:UIControlStateNormal];
    [_conectOrCutButton addTarget:self action:@selector(gotoNotification) forControlEvents:UIControlEventTouchUpInside];

    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithRed:32/255.0 green:172/255.0 blue:225/255.0 alpha:1.0];
    [view addSubview:macImageView];
    [view addSubview:_conectOrCutButton];
    return view;
    
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UILabel *labelName = [[UILabel alloc] initWithFrame:CGRectMake((kWindowWidth/4*3 - 200)/2, 20, 200, 30)];
    labelName.text = @"西 邮 快 传";
    labelName.textColor = [UIColor whiteColor];
    labelName.font = [UIFont systemFontOfSize:25];
    labelName.textAlignment = NSTextAlignmentCenter;
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [view addSubview:labelName];
    return view;
    
}
- (void)gotoNotification {
    if ([_conectOrCutButton.titleLabel.text isEqualToString:@" "]){
        NSNotification *leftTableViewNotification = [NSNotification notificationWithName:@"leftTableView" object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:leftTableViewNotification];
    } else {
        [_cmdAsyncSocketModel cutOffCmdSocket];
        [_fileAsyncSocketModel cutOffFileSocket];
        [_conectOrCutButton setTitle:@" " forState:UIControlStateNormal];
        [_conectOrCutButton setBackgroundImage:[UIImage imageNamed:@"saoyisao"] forState:UIControlStateNormal];
    }
}
- (void)conect:(NSNotification *)notification {
    NSString *ipString = [notification.userInfo objectForKey:@"IP"];
    _fileAsyncSocketModel = [FileAsyncSocketModel fileSharedInstance];
    _fileAsyncSocketModel.fileDelegate = self;
    [_fileAsyncSocketModel initFileSocket:ipString withPort:10241];
    _cmdAsyncSocketModel = [CmdAsyncSocketModel cmdSharedInstance];
    _cmdAsyncSocketModel.cmdDelegate = self;
    [_cmdAsyncSocketModel initCmdSocket:ipString withPort:10240];
    
}
//- (void)diskConectSuccess {
//    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"我的电脑", @"Lable", @"我的电脑", @"Name", @"我的电脑", @"FullName", nil];
//    NSString *json = [CodeJSON codeJson:dictionary];
//    NSString *s = [NSString stringWithFormat:@"XiYouInfo#%@",json];
//    DiskAsyncSocketModel *diskAsyncSocketModel = [DiskAsyncSocketModel diskSharedInstance];
//    [diskAsyncSocketModel sendDiskCmd:s];
//    [_conectOrCutButton setTitle:@"断开" forState:UIControlStateNormal];
//}
//- (void)noticeConectSuccess:(NSNotification *)sender {
//    
//   
//}
//- (void)diskConectFail {
//    [_conectOrCutButton setTitle:@"连接" forState:UIControlStateNormal];
//    
//    NSString *title = NSLocalizedString(@"服务器已断开", nil);
//    NSString *message = NSLocalizedString(@"请检查后重新操作", nil);
//    NSString *okActionTitle = NSLocalizedString(@"好的", nil);
//    UIAlertController *conectFailealert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okActionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//    }];
//    [conectFailealert addAction:okAction];
//    
//    [self presentViewController:conectFailealert animated:YES completion:nil];
//    

//}
- (void)cmdConectFail {
    [_conectOrCutButton setTitle:@" " forState:UIControlStateNormal];
    [_conectOrCutButton setBackgroundImage:[UIImage imageNamed:@"saoyisao"] forState:UIControlStateNormal];
    [_fileAsyncSocketModel cutOffFileSocket];
    NSString *title = NSLocalizedString(@"服务器已断开", nil);
    NSString *message = NSLocalizedString(@"请重新扫描连接", nil);
    NSString *okActionTitle = NSLocalizedString(@"好的", nil);
    UIAlertController *conectFailealert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okActionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    }];
    [conectFailealert addAction:okAction];
    
    [self presentViewController:conectFailealert animated:YES completion:nil];
}
- (void)cmdConectSuccess {
    [_conectOrCutButton setTitle:@"断开" forState:UIControlStateNormal];
    [_conectOrCutButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"我的电脑", @"Lable", @"我的电脑", @"Name", @"我的电脑", @"FullName",[NSNull null]
                         ,@"FileTyp", nil];
    NSString *dicJson = [CodeJSON codeJson:dic];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"2", @"Flag", dicJson, @"Msg", nil];
    NSString *json = [CodeJSON codeJson:dictionary];
    NSString *s = [NSString stringWithFormat:@"XiYou#%@",json];
    
    CmdAsyncSocketModel *cmdAsyncSocketModel = [CmdAsyncSocketModel cmdSharedInstance];
    [cmdAsyncSocketModel sendCmd:s];
}
- (void)diskDidReadData:(NSArray *)array {
}
- (void)fileConectSuccess {
    
}
- (void)fileConectFail {
    [_conectOrCutButton setTitle:@" " forState:UIControlStateNormal];
    [_conectOrCutButton setBackgroundImage:[UIImage imageNamed:@"saoyisao"] forState:UIControlStateNormal];
    [_cmdAsyncSocketModel cutOffCmdSocket];
    NSString *title = NSLocalizedString(@"服务器已断开", nil);
    NSString *message = NSLocalizedString(@"请重新扫描连接", nil);
    NSString *okActionTitle = NSLocalizedString(@"好的", nil);
    UIAlertController *conectFailealert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okActionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    }];
    [conectFailealert addAction:okAction];
    
    [self presentViewController:conectFailealert animated:YES completion:nil];
}
- (void)fileWriteSucceed {
    
}
- (void)fileDidReadData:(NSData *)data withFileName:(NSString *)name {
    
}
//-(void)diskDidReadData:(NSArray *)array {
//    
//}
//-(void)noticeConectFaile:(NSNotification *)sender {
//    }
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"%ld",indexPath.row);
//    NSNotification *notice = [NSNotification notificationWithName:@"leftTableVeiwCellNotification" object:nil userInfo:[NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%ld",indexPath.row] forKey:@"choose"]];
//    [[NSNotificationCenter defaultCenter]postNotification:notice];
//}
//

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
