//
//  WFFileSocketModel.m
//  PC Controller
//
//  Created by iOS-aFei on 16/10/22.
//  Copyright © 2016年 iOS-aFei. All rights reserved.
//

#import "WFFileSocketModel.h"
#import "AsyncSocket.h"
@interface WFFileSocketModel () <AsyncSocketDelegate>
{
    NSMutableData *_receiveData;
    BOOL _isFirst;
    int  _dataLength;
}
@property(nonatomic, strong) AsyncSocket *fileAsyncSocket;
@property(nonatomic, strong) AsyncSocket *receiveAsyncSocket;


@end

@implementation WFFileSocketModel

+ (instancetype)fileSharedInstance {
    static WFFileSocketModel *fileAsyncSocketModel = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        fileAsyncSocketModel = [[WFFileSocketModel alloc] init];
    });
    return fileAsyncSocketModel;
}
- (void)initFileSocket:(NSString *)ipString withPort:(int)port{
    _fileAsyncSocket = [[AsyncSocket alloc] initWithDelegate:self];
    NSError *error   = nil;
    BOOL result = [_fileAsyncSocket acceptOnPort:port error:&error];
    if (result && !error) {
        // 开放成功
        NNSLog(@"successssssss");
    }
}
- (void)onSocket:(AsyncSocket *)sock didAcceptNewSocket:(AsyncSocket *)newSocket {

    /*  sock为服务端的socket，服务端的socket只负责客户端的连接，不负责数据的读取。
        newSocket为与客户端传输数据的socket
     */
    _receiveAsyncSocket = newSocket;
    _isFirst = YES;
    _dataLength = 0;
    _receiveData = [[NSMutableData alloc] init];
    [_receiveAsyncSocket readDataWithTimeout:-1 tag:100];
}

- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    if (_isFirst) {
        _isFirst = NO;
        
        
        //  获取到数据的大小
        int value = CFSwapInt32BigToHost(*(int*)([data bytes]));
        NNSLog(@"理论大小：%d",value);
        _dataLength = value;
        [sock readDataWithTimeout:-1 tag:0];
    } else {
        [_receiveData appendData:data];
        NNSLog(@"+++:%lu", (unsigned long)_receiveData.length);
        if (_receiveData.length < _dataLength - 10000) {
            [sock readDataWithTimeout:-1 tag:0];
        } else {
            self.receiveFinished(_receiveData);
            _isFirst = YES;
            _dataLength = 0;
            _receiveData = [[NSMutableData alloc] init];
        }
    }
}

@end
