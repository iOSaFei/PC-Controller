//
//  CmdAsyncSocketModel.h
//  西邮快传1.0
//
//  Created by iOS 阿飞 on 16/1/26.
//  Copyright © 2016年 iOS 阿飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncSocket.h"

@protocol CmdAsycnSocketModelDelegate <NSObject>

- (void)cmdConectSuccess;
- (void)cmdConectFail;
- (void)diskDidReadData:(NSArray *)array;

@end

@interface CmdAsyncSocketModel : NSObject<AsyncSocketDelegate>

@property(nonatomic, weak) id<CmdAsycnSocketModelDelegate>cmdDelegate;
@property(nonatomic, strong) NSMutableData *strData;
@property(nonatomic, strong) AsyncSocket *cmdAsyncSocket;

+ (instancetype)cmdSharedInstance;
- (void) initCmdSocket:(NSString *)ipString withPort:(int)port;
- (void)sendCmd:(NSString *)cmdString;
-(void)cutOffCmdSocket;

@end



