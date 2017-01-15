//
//  ThirdViewController.h
//  西邮快传1.0
//
//  Created by iOS 阿飞 on 16/1/26.
//  Copyright © 2016年 iOS 阿飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FileAsyncSocketModel.h"
#import "CodeJSON.h"

//获取本地图片名字及大小
//#import <AssetsLibrary/ALAsset.h>
//#import <AssetsLibrary/ALAssetsLibrary.h>
//#import <AssetsLibrary/ALAssetsGroup.h>
//#import <AssetsLibrary/ALAssetRepresentation.h>

@interface ThirdViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,FileAsycnSocketModelDelegate,UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate>
@property (atomic, strong)NSThread *thread;
@property(nonatomic, strong) UIImagePickerController *visitAlbum;
@property(nonatomic, strong) UITableView *downFileTableView;
@property(nonatomic, strong) UIWebView *webView;
@property(nonatomic, strong) UIButton *backButton;
@property(nonatomic, strong) NSData* imageData;
@property(nonatomic, strong) NSArray *fileNameArray;
@property(nonatomic, strong) UIActivityIndicatorView *thirdActivity;
@end
