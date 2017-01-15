//
//  SecondViewController.m
//  西邮快传1.0
//
//  Created by iOS 阿飞 on 16/1/26.
//  Copyright © 2016年 iOS 阿飞. All rights reserved.
//

#import "SecondViewController.h"
@interface SecondViewController ()
{
    UIButton *_addButton;
}
@end

@implementation SecondViewController
BOOL isPoped = NO;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initArray];
    [self addNavigationBar];
    [self initTouchView];
    [self initPopBackView];
    [self initCollectionView];
}
- (void)addNavigationBar {
    _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _addButton.frame = CGRectMake(0, 0, 30, 30);
    [_addButton setBackgroundImage:[UIImage imageNamed:@"addPop"] forState:UIControlStateNormal];
    [_addButton addTarget:self action:@selector(popButtonView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:_addButton];
    self.navigationItem.rightBarButtonItem = buttonItem;
}
- (void)initArray {
    _cmdArray = [InitControlArrayModel initCmdArray];
    _collectionArray = [InitControlArrayModel initCollectionArray];
}
- (void)initTouchView {
    _touchControlView = [[TouchControlView alloc] initWithFrame:CGRectMake( 5, 5, kWindowWidth - 10, kWindowHeight - 64 - 49 - 10)];
    [self.view addSubview:_touchControlView];
}
- (void)initPopBackView {
    _popBackView = [[UIView alloc]initWithFrame:CGRectMake(0, -kWindowHeight, kWindowWidth, kWindowHeight/3)];
    _popBackView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
    [self.view addSubview:_popBackView];
}
- (void)popButtonView {
    if (!isPoped) {
        [UIView animateWithDuration:0.4 animations:^{
            _touchControlView.frame = CGRectMake( 5, kWindowHeight/3, kWindowWidth - 10, kWindowHeight - 64 - 49 - 10 - kWindowHeight/3);
            _popBackView.frame = CGRectMake(0, 0, kWindowHeight, kWindowHeight/3 - 10);
            [_addButton setBackgroundImage:[UIImage imageNamed:@"closePop"] forState:UIControlStateNormal];
        }];
        isPoped = YES;
            }else {
        [_addButton setBackgroundImage:[UIImage imageNamed:@"addPop"] forState:UIControlStateNormal];
        _popBackView.frame = CGRectMake(0, -kWindowHeight, kWindowWidth, kWindowHeight/3);
        _touchControlView.frame = CGRectMake( 5, 5, kWindowWidth - 10, kWindowHeight - 64 - 49 - 10);
        isPoped = NO;
    }
}
- (void)initCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.headerReferenceSize = CGSizeMake(kWindowWidth, 30);
    _controlCollectionView = [[ControlCollectionView alloc] initWithFrame:CGRectMake(0, 0, kWindowWidth, kWindowHeight/3 - 10) collectionViewLayout:flowLayout withArray:(NSArray *)_collectionArray];
    _controlCollectionView.passDeleate = self;
    [_popBackView addSubview:_controlCollectionView];
}
- (void)passSection:(NSInteger)section withRow:(NSInteger)row {
    NSString *passString = [CodeJSON codeJson:_cmdArray[section][row]];
    NSString *s = [NSString stringWithFormat:@"XiYouInfo#%@",passString];
    CmdAsyncSocketModel *cmdAsyncSocketModel = [CmdAsyncSocketModel cmdSharedInstance];
    [cmdAsyncSocketModel sendCmd:s];
    //创建一个消息对象
     //   NSNotification *cmdNotice = [NSNotification notificationWithName:@"cmdCenter" object:nil userInfo:@{@"cmdString":s}];
        //发送消息
     //   [[NSNotificationCenter defaultCenter]postNotification:cmdNotice];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
