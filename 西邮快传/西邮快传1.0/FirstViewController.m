//
//  FirstViewController.m
//  西邮快传1.0
//
//  Created by iOS 阿飞 on 16/1/29.
//  Copyright © 2016年 iOS 阿飞. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController
BOOL isFirst = YES;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationBar];
    [self initNotification];
    CmdAsyncSocketModel *cmdAsyncSocketModel = [CmdAsyncSocketModel cmdSharedInstance];
    cmdAsyncSocketModel.cmdDelegate = self;
}
- (void)viewWillAppear:(BOOL)animated {
    _myPcTableView.frame = CGRectMake(0, 0, kWindowWidth, kWindowHeight - 120);
}
- (void)addNavigationBar {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 30, 30);
    [button setBackgroundImage:[UIImage imageNamed:@"shuaxin"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(shuaxin) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = buttonItem;
}
- (void)shuaxin {
    isFirst = YES;
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"我的电脑", @"Lable", @"我的电脑", @"Name", @"我的电脑", @"FullName",[NSNull null]
,@"FileTyp", nil];
    NSString *dicJson = [CodeJSON codeJson:dic];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"2", @"Flag", dicJson, @"Msg", nil];
    NSString *json = [CodeJSON codeJson:dictionary];
    NSString *s = [NSString stringWithFormat:@"XiYou#%@",json];


    CmdAsyncSocketModel *cmdAsyncSocketModel = [CmdAsyncSocketModel cmdSharedInstance];
    cmdAsyncSocketModel.cmdDelegate = self;
    [cmdAsyncSocketModel sendCmd:s];
}
- (void)initNotification {
    //获取通知中心单例对象
    NSNotificationCenter * diskConectSuccessCenter = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [diskConectSuccessCenter addObserver:self selector:@selector(diskNotificationConectSuccess:) name:@"diskConectSuccess" object:nil];
    NSNotificationCenter * diskConectSuccessTf = [NSNotificationCenter defaultCenter];
    [diskConectSuccessTf addObserver:self selector:@selector(diskDidReceived:) name:@"diskDidReceived" object:nil];
}
- (void)diskNotificationConectSuccess:(NSNotification *)sender  {
    isFirst = YES;
}
//- (void)diskDidReadData:(NSArray *)array {
//
//        if (isFirst) {
//        _myPcTableView = [[MyPcTableView alloc] initWithFrame:CGRectMake(0, 0, kWindowWidth, kWindowHeight - 120) style:UITableViewStylePlain];
//        _myPcTableView.diskArray = array;
//        _myPcTableView.myPcTvcDeleate = self;
//        [self.view addSubview:_myPcTableView];
//        isFirst = NO;
//    }else{
//        MyPcTableViewController *myPcTableViewController = [[MyPcTableViewController alloc] init];
//        myPcTableViewController.diskTvArray = array;
//        NSLog(@"%@",myPcTableViewController.diskTvArray);
//        UINavigationController *nPcVc = [[UINavigationController alloc] initWithRootViewController:myPcTableViewController];
//        [self.navigationController presentViewController:nPcVc animated:YES completion:nil];
//        //[self.navigationController pushViewController:myPcTableViewController animated:YES];
//    }
//    
//}
- (void)diskDidReceived:(NSNotification *)sender {
    if (_myPcTableView) {
        [_myPcTableView removeFromSuperview];
    }
    if (isFirst) {
        _myPcTableView = [[MyPcTableView alloc] initWithFrame:CGRectMake(0, 0, kWindowWidth, kWindowHeight - 120) style:UITableViewStylePlain];
        _myPcTableView.diskArray = sender.userInfo[@"diskArray"];
        _myPcTableView.myPcTvcDeleate = self;
        [self.view addSubview:_myPcTableView];
        isFirst = NO;
    }else {
        MyPcTableViewController *myPcTableViewController = [[MyPcTableViewController alloc] init];
        myPcTableViewController.diskTvArray = sender.userInfo[@"diskArray"];
        NSLog(@"%@",myPcTableViewController.diskTvArray);
        UINavigationController *nPcVc = [[UINavigationController alloc] initWithRootViewController:myPcTableViewController];
        [self.navigationController presentViewController:nPcVc animated:YES completion:nil];
    }
}
- (void)myPcTableViewCmd:(NSDictionary *)diskCmdDic {
    NSString *dicJson = [CodeJSON codeJson:diskCmdDic];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"2", @"Flag", dicJson, @"Msg", nil];
    NSString *json = [CodeJSON codeJson:dictionary];
    NSString *diskCmdJson = [NSString stringWithFormat:@"XiYou#%@",json];
    CmdAsyncSocketModel *cmdAsyncSocketModel = [CmdAsyncSocketModel cmdSharedInstance];
    cmdAsyncSocketModel.cmdDelegate = self;
    [cmdAsyncSocketModel sendCmd:diskCmdJson];
}
- (void)cmdConectSuccess {
}
- (void)cmdConectFail {
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
