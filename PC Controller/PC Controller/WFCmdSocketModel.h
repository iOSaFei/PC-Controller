//
//  WFCmdSocketModel.h
//  PC Controller
//
//  Created by iOS-aFei on 16/10/10.
//  Copyright © 2016年 iOS-aFei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WFCmdSocketModel : NSObject

@property (nonatomic, assign) BOOL cmdSocketOnline;
@property (nonatomic, copy)   void (^cmdConnectSuccess)();

+ (instancetype)cmdSharedInstance;
- (void)initCmdSocket:(NSString *)ipString withPort:(int)port;
- (void)sendCmd:(NSString *)cmdString;
- (void)cutOffCmdSocket;

@end
