//
//  TabarViewController.m
//  西邮快传1.0
//
//  Created by iOS 阿飞 on 16/1/26.
//  Copyright © 2016年 iOS 阿飞. All rights reserved.
//

#import "TabarViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourViewController.h"
@interface TabarViewController ()

@end

@implementation TabarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIColor orangeColor],
                                NSForegroundColorAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    [self initTabBarController];
    self.delegate = self;
}
-(void)initTabBarController {
    self.tabBar.barTintColor = [UIColor colorWithRed:32/255.0 green:172/255.0 blue:225/255.0 alpha:1.0];
    self.tabBar.tintColor = [UIColor whiteColor];
    FirstViewController *fvc=[[FirstViewController alloc]init];
    fvc.tabBarItem.image = [[UIImage imageNamed:@"computer1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    fvc.tabBarItem.selectedImage = [[UIImage imageNamed:@"computer"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    fvc.title = @"我的电脑";
    UINavigationController *nfvc=[[UINavigationController alloc]initWithRootViewController:fvc];
    
    SecondViewController *svc=[[SecondViewController alloc]init];
    svc.tabBarItem.image = [[UIImage imageNamed:@"control1"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    svc.tabBarItem.selectedImage = [[UIImage imageNamed:@"control"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    svc.title = @"遥控电脑";
    UINavigationController *nsvc=[[UINavigationController alloc]initWithRootViewController:svc];
    
    ThirdViewController *tvc=[[ThirdViewController alloc]init];
    tvc.tabBarItem.image = [[UIImage imageNamed:@"download1"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tvc.tabBarItem.selectedImage = [[UIImage imageNamed:@"download"]imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
    tvc.title = @"我的快传";
    UINavigationController *ntvc=[[UINavigationController alloc]initWithRootViewController:tvc];
    
    FourViewController *ffvc=[[FourViewController alloc]init];
    ffvc.tabBarItem.image = [[UIImage imageNamed:@"voice1"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    ffvc.tabBarItem.selectedImage = [[UIImage imageNamed:@"voice"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    ffvc.title = @"语音控制";
    UINavigationController *nffvc=[[UINavigationController alloc]initWithRootViewController:ffvc];
    //nffvc.navigationBar.topItem.title=@"语音控制";
    
    NSArray *nvc=@[ nfvc, nsvc, ntvc, nffvc];
    self.viewControllers=nvc;
    
    _sidebarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _sidebarButton.frame = CGRectMake(10, 30, 27, 24);
    [_sidebarButton setBackgroundImage:[UIImage imageNamed:@"side"] forState:UIControlStateNormal];
    [self.view addSubview:_sidebarButton];
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    switch (self.selectedIndex) {
        case 0:
            _sidebarButton.hidden = NO;
            break;
        case 1:
            _sidebarButton.hidden = YES;
            break;
        case 2:
            _sidebarButton.hidden = YES;
            break;
        case 3:
            _sidebarButton.hidden = YES;
            break;
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
