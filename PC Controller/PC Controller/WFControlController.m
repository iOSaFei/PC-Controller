//
//  WFControlController.m
//  PC Controller
//
//  Created by iOS-aFei on 16/9/1.
//  Copyright © 2016年 iOS-aFei. All rights reserved.
//

#import "WFControlController.h"
#import "SCanQRCodeViewController.h"
#import "WFPopController.h"
#import "WFQuickStartController.h"
#import "WFShootScreenController.h"
#import "WFGestureView.h"
#import "WFFunction.h"
#import "WFTextfield.h"
#import "WFPowerPPTView.h"
#import "WFLightnessAndVolume.h"
#import "SVProgressHUD.h"
#import "WFCmdSocketModel.h"
#import "WFJsonModel.h"
#import "NSObject+GetIP.h"
#import "NSDictionary+CmdDictionary.h"
#import "YXEasing.h"

@interface WFControlController () <UIPopoverPresentationControllerDelegate, FunctionEventDelegate>

@property (nonatomic, strong) WFQuickStartController *quickStartController;
@property (nonatomic, strong) WFGestureView          *gestureView;
@property (nonatomic, strong) WFFunction             *functionCollectionView;
@property (nonatomic, strong) WFTextfield            *textField;
@property (nonatomic, strong) WFPowerPPTView         *PPTView;
@property (nonatomic, strong) WFPowerPPTView         *powerView;
@property (nonatomic, strong) WFLightnessAndVolume   *lightAndVolume;

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
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.gestureView];
    
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
}
#pragma mark - lazyLoad
- (WFTextfield *)textField {
    if (!_textField) {
        WS(weakself);
        _textField =\
        [[WFTextfield alloc] initWithFrame:CGRectMake(0, -kWindowHeight, kWindowWidth, kWindowHeight)];
        _textField.inputFinished = ^(NSString *string) {
            [weakself linkToSetver:string];
        };
        [self.view addSubview:_textField];
    }
    return _textField;
}
- (WFGestureView *)gestureView {
    if (!_gestureView) {
        WS(weakself);
        _gestureView = [[WFGestureView alloc] initWithFrame:self.view.frame];
        _gestureView.handelGesture = ^(NSDictionary *dictionary) {
            [weakself sendCmdWithDictionary:dictionary];
        };
    }
    return _gestureView;
}
- (WFPowerPPTView *)PPTView {
    if (!_PPTView) {
        WS(weakself);
        NSArray *tittleArray = @[ @"全屏", @"下一页", @"上一页", @"结束"];
        _PPTView = [[WFPowerPPTView alloc] initWithFrame:CGRectMake(kWindowWidth, 0, kWindowWidth - 100, 110) tittle:tittleArray];
        _PPTView.ppdidSelectItem = ^(NSInteger row) {
            NSDictionary *dictionary = nil;
            switch (row) {
                case 0:
                    dictionary = [NSDictionary cmdDictionaryWithValue:@"17" key:@"remote"];
                    break;
                case 1:
                    dictionary = [NSDictionary cmdDictionaryWithValue:@"12" key:@"remote"];
                    break;
                case 2:
                    dictionary = [NSDictionary cmdDictionaryWithValue:@"13" key:@"remote"];
                    break;
                case 3:
                    dictionary = [NSDictionary cmdDictionaryWithValue:@"18" key:@"remote"];
                    break;
            }
            [weakself sendCmdWithDictionary:dictionary];
        };
        [self.view addSubview:_PPTView];
    }
    [self.view bringSubviewToFront:_PPTView];
    return _PPTView;
}
- (WFPowerPPTView *)powerView {
    if (!_powerView) {
        WS(weakself);
        NSArray *tittleArray = @[ @"关机", @"重启", @"注销", @"睡眠"];
        _powerView = [[WFPowerPPTView alloc] initWithFrame:CGRectMake(kWindowWidth, 0, kWindowWidth - 100, 110) tittle:tittleArray];
        _powerView.ppdidSelectItem = ^(NSInteger row) {
            NSDictionary *dictionary = nil;
            switch (row) {
                case 0:
                    dictionary = [NSDictionary cmdDictionaryWithValue:@"1" key:@"power"];
                    break;
                case 1:
                    dictionary = [NSDictionary cmdDictionaryWithValue:@"2" key:@"power"];
                    break;
                case 2:
                    dictionary = [NSDictionary cmdDictionaryWithValue:@"3" key:@"power"];
                    break;
                case 3:
                    dictionary = [NSDictionary cmdDictionaryWithValue:@"4" key:@"power"];
                    break;
            }
            [weakself sendCmdWithDictionary:dictionary];
        };
        [self.view addSubview:_powerView];
    }
    [self.view bringSubviewToFront:_powerView];
    return _powerView;
}
- (WFQuickStartController *)quickStartController {
    if (!_quickStartController) {
        _quickStartController = [[WFQuickStartController alloc] init];
    }
    return _quickStartController;
}
- (WFLightnessAndVolume *)lightAndVolume {
    if (!_lightAndVolume) {
        WS(weakself);
        _lightAndVolume = [[WFLightnessAndVolume alloc] initWithFrame:CGRectMake(kWindowWidth, 0, kWindowWidth - 100, 200)];
        _lightAndVolume.lProgressChanged = ^(NSString *value) {
            NSDictionary *dictionary = [NSDictionary cmdDictionaryWithValue:value key:@"bright"];
            [weakself sendCmdWithDictionary:dictionary];
        };
        _lightAndVolume.vProgressChanged = ^(NSString *value) {
            NSDictionary *dictionary = [NSDictionary cmdDictionaryWithValue:value key:@"volume"];
            [weakself sendCmdWithDictionary:dictionary];
        };
        [self.view addSubview:_lightAndVolume];
    }
    [self.view bringSubviewToFront:_lightAndVolume];
    return _lightAndVolume;
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
            keyAnimation.duration = 2.0;
            keyAnimation.values   =\
            [YXEasing calculateFrameFromPoint:self.textField.center
                                      toPoint:CGPointMake(kWindowWidth/2, kWindowHeight/2)
                                         func:BounceEaseOut frameCount:30];
            self.textField.center = CGPointMake(kWindowWidth/2, kWindowHeight/2);
            [self.textField.layer addAnimation:keyAnimation forKey:nil];
        } else {
            SCanQRCodeViewController *scan = [[SCanQRCodeViewController alloc] init];
            scan.recognitionCodeFinished = ^ (NSString *codeString) {
                [self connectToServerWithIP: codeString];
            };
            scan.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:scan animated:YES];
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
    [self addChildViewController:self.quickStartController];
    [self.view addSubview:self.quickStartController.view];
    self.quickStartController.view.center = CGPointMake( -self.view.frame.size.width/2, self.view.frame.size.height/2);
    [UIView animateWithDuration:1.5
                          delay:0
         usingSpringWithDamping:0.5
          initialSpringVelocity:0.5
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
        self.quickStartController.view.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    } completion:^(BOOL finished) {
    }];
}
- (void)PPTFunction {
    [self.PPTView apperAnimation];
}
- (void)shotScreen {
    WFShootScreenController *shootScreen = [[WFShootScreenController alloc] init];
    [self.navigationController pushViewController:shootScreen animated:YES];
}
- (void)distanceDestop {
    
}
- (void)lightnessAndVolume {
    [self.lightAndVolume showWithDuration:0.5];
}
- (void)powerFunction {
    [self.powerView apperAnimation];
}
- (void)chatFunction {
    
}
#pragma mark - bolok_back
- (void)connectToServerWithIP:(NSString *)IPString {
    [self linkToSetver:IPString];
}
#pragma mark sendCmd
- (void)linkToSetver:(NSString *)IPString {
    WFCmdSocketModel *cmdSocketModel = [WFCmdSocketModel cmdSharedInstance];
    __weak __typeof(&*cmdSocketModel)weakCmd = cmdSocketModel;
    cmdSocketModel.cmdConnectSuccess = ^ {
        [SVProgressHUD showSuccessWithStatus:@"连接成功！"];
        NSString *IPString = [NSObject deviceIPAdress];
        NSDictionary *dictionary = [NSDictionary cmdDictionaryWithValue:IPString key:@"link"];
        NNSLog(@"%@",IPString);
        NSString *jsonString = [WFJsonModel jsonString:dictionary];
        [weakCmd sendCmd:jsonString];
    };
    [cmdSocketModel initCmdSocket:IPString withPort:59671];
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 3ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        WFCmdSocketModel *cmdSocketModel = [WFCmdSocketModel cmdSharedInstance];
        if (!cmdSocketModel.cmdSocketOnline) {
            [SVProgressHUD showErrorWithStatus:@"请确保手机与电脑在同一个局域网下"];
        }
    });
}
- (void)sendCmdWithDictionary:(NSDictionary *)dictionary {
    WFCmdSocketModel *cmdSocketModel = [WFCmdSocketModel cmdSharedInstance];
    NSString *jsonString = [WFJsonModel jsonString:dictionary];
    [cmdSocketModel sendCmd:jsonString];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
