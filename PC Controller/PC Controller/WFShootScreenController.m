//
//  WFShootScreenController.m
//  PC Controller
//
//  Created by iOS-aFei on 16/10/15.
//  Copyright © 2016年 iOS-aFei. All rights reserved.
//

#import "WFShootScreenController.h"

@interface WFShootScreenController () <UIScrollViewDelegate>
{
    UIImageView *_imageView;
}
@end

@implementation WFShootScreenController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupViews];
}
- (void)setupViews {
    CGFloat height = kWindowWidth*9/16;
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, 0, kWindowWidth, kWindowHeight);
    [self.view addSubview:scrollView];
    
    UIImage *image = [UIImage imageNamed:@"TEST"];
    _imageView = [[UIImageView alloc] initWithImage:image];
    _imageView.frame = CGRectMake(0, 0, _imageView.frame.size.width, _imageView.frame.size.height);
    [scrollView addSubview:_imageView];
    
    scrollView.contentSize = image.size;
    
    scrollView.delegate = self;
    // 设置最大伸缩比例
    scrollView.maximumZoomScale = 2.0;
    // 设置最小伸缩比例
    scrollView.minimumZoomScale = 0.2;
}
#pragma mark - UIScrollView 的 代理方法
#pragma mark 这个方法返回的控件就能进行捏合手势缩放操作
#pragma mark 当UIScrollView尝试进行缩放的时候就会调用
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}
#pragma mark 当缩放完毕的时候调用
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(double)scale
{
    //    NSLog(@"结束缩放 - %f", scale);
}
#pragma mark 当正在缩放的时候调用
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    //    NSLog(@"-----");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
