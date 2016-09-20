//
//  WFTabbarController.m
//  PC Controller
//
//  Created by iOS-aFei on 16/9/1.
//  Copyright © 2016年 iOS-aFei. All rights reserved.
//

#import "WFTabbarController.h"
#import "WFControlController.h"
#import "WFDocumentController.h"
#import "WFMyController.h"

@interface WFTabbarController ()

@end

@implementation WFTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.barTintColor = kMainColor;
    self.tabBar.tintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addController];
}
- (void)addController{
    WFControlController *control = [[WFControlController alloc]init];
    control.tabBarItem.image     = [[UIImage imageNamed:@"Control0"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    control.tabBarItem.selectedImage = [[UIImage imageNamed:@"Control1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    controlController.title = @"";
    UINavigationController *ncontrol = [[UINavigationController alloc]initWithRootViewController:control];
    
    WFDocumentController *document = [[WFDocumentController alloc]init];
    document.tabBarItem.image      = [[UIImage imageNamed:@"PC0"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    document.tabBarItem.selectedImage = [[UIImage imageNamed:@"PC1"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    document.title = @"遥控电脑";
    UINavigationController *ndocument = [[UINavigationController alloc]initWithRootViewController:document];
    
    WFMyController *myController  = [[WFMyController alloc]init];
    myController.tabBarItem.image = [[UIImage imageNamed:@"download1"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    myController.tabBarItem.selectedImage = [[UIImage imageNamed:@"download"]imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
//    tvc.title = @"我的快传";
    UINavigationController *nmyController = [[UINavigationController alloc]initWithRootViewController:myController];
    
    self.viewControllers = @[ ncontrol, ndocument, nmyController ];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
