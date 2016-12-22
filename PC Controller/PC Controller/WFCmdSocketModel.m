//
//  WFCmdSocketModel.m
//  PC Controller
//
//  Created by iOS-aFei on 16/10/10.
//  Copyright © 2016年 iOS-aFei. All rights reserved.
//

#import "WFCmdSocketModel.h"
#import "AsyncSocket.h"

@interface WFCmdSocketModel () <AsyncSocketDelegate>
{
    BOOL _cutByUser;
    BOOL _firstReceived;
    NSMutableData *_receivedData;
}

@property(nonatomic, strong) AsyncSocket *cmdAsyncSocket;

@end

@implementation WFCmdSocketModel

+ (instancetype)cmdSharedInstance {
    static WFCmdSocketModel *cmdAsyncSocketModel = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        cmdAsyncSocketModel = [[WFCmdSocketModel alloc] init];
    });
    return cmdAsyncSocketModel;
}

- (void)initCmdSocket:(NSString *)ipString withPort:(int)port{
    _cmdSocketOnline = NO;
    _cmdAsyncSocket  = [[AsyncSocket alloc] initWithDelegate:self];
    NSError *error   = nil;
    [_cmdAsyncSocket connectToHost:ipString onPort:port error:&error];
}
- (void)sendCmd:(NSString *)cmdString {
    NSData *data = [cmdString dataUsingEncoding:NSUTF8StringEncoding];
    [_cmdAsyncSocket writeData:data withTimeout:-1 tag:0];
}
//当成功连接到服务器时激发该方法
- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port {
    self.hostIPString = host;
    _cmdSocketOnline  = YES;
    _firstReceived    = YES;
    _cutByUser        = NO;
    _cmdConnectSuccess();
    [_cmdAsyncSocket readDataWithTimeout:-1 tag:0];
}
- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    _receivedData = [[NSMutableData alloc] init];
    [_receivedData appendData:data];
    NSString *content = [[NSString alloc] initWithData:_receivedData encoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:_receivedData options:0 error:&error];
    if (error) {
        NNSLog(@"%@",error);
    }
    if (dictionary) {
        self.cmdReceivedData(dictionary);
    }
    [_cmdAsyncSocket readDataWithTimeout:-1 tag:0];
}
- (void)onSocketDidDisconnect:(AsyncSocket *)sock {
    _cmdSocketOnline = NO;
}
- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag {
}
-(void)cutOffCmdSocket{
    _cutByUser = YES;
    [_cmdAsyncSocket disconnect];
}
@end
