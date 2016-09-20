//
//  WFControlController.m
//  PC Controller
//
//  Created by iOS-aFei on 16/9/1.
//  Copyright © 2016年 iOS-aFei. All rights reserved.
//

#import "WFControlController.h"
#import "WFPopController.h"
#import "WFFunction.h"
#import "WFTextfield.h"
#import "WFPowerPPTView.h"
#import "YXEasing.h"

@interface WFControlController () <UIPopoverPresentationControllerDelegate, FunctionEventDelegate>

@property (nonatomic, strong) WFFunction *functionCollectionView;
@property (nonatomic, strong) WFTextfield *textField;
@property (nonatomic, strong) WFPowerPPTView *PPTView;
@property (nonatomic, strong) WFPowerPPTView *powerView;

@end

@implementation WFControlController

#pragma mark - override
- (void)viewDidLoad {
    [super viewDidLoad];
    [self changeNavigationBar];
    [self addFunctionCollectionView];
}
#pragma mark - NavigationBar 
- (void)changeNavigationBar {
    self.navigationController.navigationBar.translucent  = NO;
    self.navigationController.navigationBar.clipsToBounds=YES;
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setImage:[UIImage imageNamed:@"connect"]
                 forState:UIControlStateNormal];
    rightButton.frame = CGRectMake(0, 0, 25, 25);
    [rightButton addTarget:self action:@selector(connectToServer) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}
#pragma mark - view
- (void)addFunctionCollectionView {
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _functionCollectionView = [[WFFunction alloc] initWithFrame:CGRectMake(0, 0, 100, CGRectGetMaxY(self.view.frame) - 113)
                                           collectionViewLayout:flowLayout];
    _functionCollectionView.functionEventDelegate = self;
    [self.view addSubview:_functionCollectionView];
    
    CALayer *line = [CALayer layer];
    line.frame = CGRectMake(100, 0, 1, CGRectGetMaxY(self.view.frame) - 113);
    line.backgroundColor = kMainColor.CGColor;
    [self.view.layer addSublayer:line];
    
    UILabel *mourseLabel      = [[UILabel alloc] initWithFrame:CGRectMake(kWindowWidth - 200, kWindowHeight - 150, 200, 50)];
    mourseLabel.textAlignment = NSTextAlignmentRight;
    mourseLabel.textColor     = kMainColor;
    mourseLabel.text          = @"右半边是触摸板哦";
    [self.view addSubview:mourseLabel];
}
#pragma mark - lazyLoad
- (WFTextfield *)textField {
    if (!_textField) {
        _textField =\
        [[WFTextfield alloc] initWithFrame:CGRectMake(0, -kWindowHeight, kWindowWidth, kWindowHeight)];
        [self.view addSubview:_textField];
    }
    return _textField;
}
- (void)addPPTViewWithTittle:(NSArray <NSString *> *)tittleArray {
    _PPTView = [[WFPowerPPTView alloc] initWithFrame:CGRectMake(kWindowWidth, 0, kWindowWidth - 100, 110) tittle:tittleArray];
    [self.view addSubview:_PPTView];
}
- (void)addPowerViewWithTittle:(NSArray <NSString *> *)tittleArray {
    _powerView = [[WFPowerPPTView alloc] initWithFrame:CGRectMake(kWindowWidth, 0, kWindowWidth - 100, 110) tittle:tittleArray];
    [self.view addSubview:_powerView];
}
#pragma mark - buttonEvent
- (void)connectToServer {
    WFPopController *popController = [[WFPopController alloc] init];
    popController.modalPresentationStyle = UIModalPresentationPopover;
    popController.popoverPresentationController.barButtonItem = self.navigationItem.rightBarButtonItem;
    popController.popoverPresentationController.delegate = self;
    popController.preferredContentSize = CGSizeMake(100, 100);
    popController.cellDidSelected = ^(NSUInteger row) {
        if (row == 1) {
            CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animation];
            keyAnimation.keyPath  = @"position";
            keyAnimation.duration = 2.f;
            keyAnimation.values   =\
            [YXEasing calculateFrameFromPoint:self.textField.center
                                      toPoint:CGPointMake(kWindowWidth/2, kWindowHeight/2)
                                         func:BounceEaseOut frameCount:30];
            self.textField.center = CGPointMake(kWindowWidth/2, kWindowHeight/2);
            [self.textField.layer addAnimation:keyAnimation forKey:nil];
        }
    };
    [self presentViewController:popController animated:YES completion:nil];
}
#pragma mark - delegate
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    return UIModalPresentationNone;
}
- (UIViewController *)presentationController:(UIPresentationController *)controller viewControllerForAdaptivePresentationStyle:(UIModalPresentationStyle)style
{
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller.presentedViewController];
    return navController;
}
- (BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
    return YES;   //点击蒙板popover不消失， 默认yes
}

- (void)voiceFunction {
    
}
- (void)quickStart {
    
}
- (void)PPTFunction {
    [self addPPTViewWithTittle:@[ @"全屏", @"下一页", @"上一页", @"结束"]];
    [_PPTView apperAnimation];
}
- (void)shotScreen {

}
- (void)distanceDestop {
    
}
- (void)lightnessAndVolume {
    
}
- (void)powerFunction {
    [self addPowerViewWithTittle:@[ @"关机", @"重启", @"睡眠", @"注销"]];
    [_powerView apperAnimation];
}
- (void)chatFunction {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
