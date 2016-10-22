//
//  WFQuickStartController.m
//  PC Controller
//
//  Created by iOS-aFei on 16/9/21.
//  Copyright © 2016年 iOS-aFei. All rights reserved.
//

#import "WFQuickStartController.h"
#import "WFQuickStartView.h"
#import "WFQuickText.h"
#import "NSDictionary+CmdDictionary.h"
#import "WFCmdSocketModel.h"
#import "WFJsonModel.h"

@interface WFQuickStartController ()

@end

@implementation WFQuickStartController

#pragma mark - override
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kMainColor;
    [self setupViews];
}
#pragma mark - view
- (void)setupViews {
    UIButton *removeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [removeButton setImage:[UIImage imageNamed:@"remove"]
                  forState:UIControlStateNormal];
    removeButton.frame = CGRectMake(kWindowWidth - 50, 50, 40, 40);
    [removeButton addTarget:self action:@selector(removeSelf)
           forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:removeButton];
    
    WFQuickText *quickText = [[WFQuickText alloc] init];
    quickText.frame = CGRectMake(60, 40, kWindowWidth - 120, 200);
    [self.view addSubview:quickText];
    
    WS(weakself);
    WFQuickStartView *quickStartView = [[WFQuickStartView alloc] initWithFrame:CGRectMake(0, 260, kWindowWidth, kWindowHeight - 260)];
    quickStartView.touchEnded = ^(NSString *key) {
        [weakself handelNumber:key];
    };
    [self.view addSubview:quickStartView];
}
#pragma mark - buttonEvent
- (void)removeSelf {
    [UIView animateWithDuration:1.0 animations:^(){
        self.view.alpha = 0;
    } completion:^(BOOL isFinished) {
        self.view.alpha = 1;
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }];
}
- (void)handelNumber:(NSString *)string {
    NSString *value;
    if ([string isEqualToString:@"147"]) {
        value = @"10";
    } else if ([string isEqualToString:@"258"]) {
        value = @"11";
    } else if ([string isEqualToString:@"123"]) {
        value = @"-1024";
    } else if ([string isEqualToString:@"456"]) {
        value = @"18";
    } else if ([string isEqualToString:@"789"]) {
        value = @"20";
    } else {
        value = string;
    }
    NSDictionary *dictionary = [NSDictionary cmdDictionaryWithValue:value
                                                                key:@"remote"];
    WFCmdSocketModel *cmdSocketModel = [WFCmdSocketModel cmdSharedInstance];
    NSString *jsonString = [WFJsonModel jsonString:dictionary];
    [cmdSocketModel sendCmd:jsonString];
}

@end
