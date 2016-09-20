//
//  WFFunction.h
//  PC Controller
//
//  Created by iOS-aFei on 16/9/1.
//  Copyright © 2016年 iOS-aFei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FunctionEventDelegate <NSObject>

- (void)voiceFunction;
- (void)quickStart;
- (void)PPTFunction;
- (void)shotScreen;
- (void)distanceDestop;
- (void)lightnessAndVolume;
- (void)powerFunction;
- (void)chatFunction;

@end

@interface WFFunction : UICollectionView <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, weak) id <FunctionEventDelegate>functionEventDelegate;

@end
