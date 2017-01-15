//
//  ViewController.m
//  西邮快传1.0
//
//  Created by iOS 阿飞 on 16/1/26.
//  Copyright © 2016年 iOS 阿飞. All rights reserved.
//

#import "ViewController.h"
#import "TabarViewController.h"
#import "LeftViewController.h"
#import "SaoYiSaoViewController.h"




@interface ViewController ()
@property(nonatomic,strong) TabarViewController *taBarController;
@property(nonatomic,strong) LeftViewController *leftViewController;
@property(nonatomic,strong) UIView *overView;
@property(nonatomic,strong) UITapGestureRecognizer *tap;
@property(nonatomic,strong) UIPanGestureRecognizer *pan;
@property(assign,nonatomic)CGFloat speed;
@property(assign,nonatomic)CGFloat scalef;
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:32/255.0 green:172/255.0 blue:225/255.0 alpha:1.0];
    _speed = 0.5;
    _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showTaBarView)];
    _overView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWindowWidth, kWindowHeight)];
    _overView.backgroundColor = [UIColor clearColor];
    [_overView addGestureRecognizer:_tap];
    [self initViewController];
    [self initNotification];
}
- (void)initNotification {
    NSNotificationCenter *leftTableViewNotificationCenter = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [leftTableViewNotificationCenter addObserver:self selector:@selector(gotoSweep) name:@"leftTableView" object:nil];
}
- (void)gotoSweep {
    SaoYiSaoViewController *sao = [[SaoYiSaoViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:sao];
    [self presentViewController:nav animated:YES completion:nil];

}
-(void)initViewController{
    //    UIImageView *backView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWindowWidth-kWindowWidth/2*0.8, kWindowHeight)];
    //    backView1.image = [UIImage imageNamed:@"leftViewBack1"];
    //    UIImageView *backView2 = [[UIImageView alloc] initWithFrame:CGRectMake(kWindowWidth-kWindowWidth/2*0.8, 0, kWindowWidth/2*0.8, kWindowHeight)];
    //    backView2.image = [UIImage imageNamed:@"leftViewBack1"];
    //    [self.view addSubview:backView1];
    //    [self.view addSubview:backView2];
    _pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    _leftViewController = [[LeftViewController alloc] init];
    _leftViewController.view.frame = CGRectMake(-kWindowWidth, 0, kWindowWidth, kWindowHeight);
    _taBarController = [[TabarViewController alloc]init];
    [_taBarController.view addGestureRecognizer:_pan];
    [self.view addSubview:_leftViewController.view];
    [self.view addSubview:_taBarController.view];
    [_taBarController.sidebarButton addTarget:self action:@selector(showLeftView) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)showTaBarView{
    [UIView animateWithDuration:0.3 animations:^{
        _leftViewController.view.frame = CGRectMake(-kWindowWidth, 0, kWindowWidth, kWindowHeight);
        _taBarController.view.center = CGPointMake( kWindowWidth/2, kWindowHeight/2);
    }];
    [_overView removeFromSuperview];
}
-(void)showLeftView{
    [UIView animateWithDuration:0.3 animations:^{
        _leftViewController.view.frame = CGRectMake(-kWindowWidth/4, 0, kWindowWidth, kWindowHeight);
        _taBarController.view.center = CGPointMake(kWindowWidth+kWindowWidth/4,[UIScreen mainScreen].bounds.size.height/2);
        
    }];
    [_taBarController.view addSubview:_overView];
}
- (void)handlePan:(UIPanGestureRecognizer *)pan {
    CGPoint point = [pan translationInView:self.view];
    _scalef = (point.x*_speed + _scalef);
    if (pan.view.frame.origin.x >= 0){
        pan.view.center = CGPointMake(pan.view.center.x + point.x*_speed,pan.view.center.y);
        [pan setTranslation:CGPointMake(0, 0) inView:self.view];
    }
    if (pan.state == UIGestureRecognizerStateEnded) {
        if (_scalef>140*_speed){
            [self showLeftView];
        }else{
            [self showTaBarView];
            _scalef = 0;
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
