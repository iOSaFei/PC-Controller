//
//  SecondViewController.h
//  西邮快传1.0
//
//  Created by iOS 阿飞 on 16/1/26.
//  Copyright © 2016年 iOS 阿飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InitControlArrayModel.h"
#import "CodeJSON.h"
#import "ControlCollectionView.h"
#import "CmdAsyncSocketModel.h"
#import "TouchControlView.h"

@interface SecondViewController : UIViewController<CollectionViewDeleate>
@property(nonatomic, strong) ControlCollectionView *controlCollectionView;
@property(nonatomic, strong) NSArray *cmdArray;
@property(nonatomic, strong) NSArray *collectionArray;
@property(nonatomic, strong) UIView *popBackView;
@property(nonatomic, strong) TouchControlView *touchControlView;
@end
