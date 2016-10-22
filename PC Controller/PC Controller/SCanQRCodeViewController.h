//
//  SCanQRCodeViewController.h
//  QRCode
//
//  Created by LeeWong on 16/9/6.
//  Copyright © 2016年 LeeWong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCanQRCodeViewController : UIViewController

@property (nonatomic, copy) void (^ recognitionCodeFinished)(NSString *codeSting);

@end
