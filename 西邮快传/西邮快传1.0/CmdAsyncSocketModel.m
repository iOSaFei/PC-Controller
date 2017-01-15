   //
//  CmdAsyncSocketModel.m
//  西邮快传1.0
//
//  Created by iOS 阿飞 on 16/1/26.
//  Copyright © 2016年 iOS 阿飞. All rights reserved.
//

#import "CmdAsyncSocketModel.h"

@implementation CmdAsyncSocketModel

BOOL isOnline;
BOOL cutByUser = NO;
int diskCount = 0;
int diskLenth;

+ (instancetype)cmdSharedInstance {
    static CmdAsyncSocketModel *cmdAsyncSocketModel = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        cmdAsyncSocketModel = [[CmdAsyncSocketModel alloc] init];
    });
    return cmdAsyncSocketModel;
}
- (void) initCmdSocket:(NSString *)ipString withPort:(int)port{
    _cmdAsyncSocket = [[AsyncSocket alloc] initWithDelegate:self];
    NSError *error = nil;
    [_cmdAsyncSocket connectToHost:ipString onPort:port error:&error];
}
- (void)sendCmd:(NSString *)cmdString {
    if (isOnline) {
        NSData *data = [cmdString dataUsingEncoding:NSUTF8StringEncoding];
        [_cmdAsyncSocket writeData:data withTimeout:-1 tag:0];
    }
    else {
        NSLog(@"暂未连接服务器");
        [self.cmdDelegate cmdConectFail];
    }
}
//当成功连接到服务器时激发该方法
- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port {
    isOnline = YES;
    cutByUser = NO;
    [self.cmdDelegate cmdConectSuccess];
    NSNotification *diskConectSuccess = [NSNotification notificationWithName:@"diskConectSuccess" object:nil userInfo:nil];
    //发送消息
    [[NSNotificationCenter defaultCenter]postNotification:diskConectSuccess];
    NSLog(@"cmd连接成功");
//    //调用此方法读取数据
    [_cmdAsyncSocket readDataWithTimeout:-1 tag:0];
}
- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
//    //获取读到的数据
//    NSData *strData = [data subdataWithRange:NSMakeRange(0, [data length])];
//    NSString *content = [[NSString alloc] initWithData:strData encoding:NSUTF8StringEncoding];
//    if (content) {
//        NSLog(@"%@",content);
//    }
//    //再次读取数据
//    [_cmdAsyncSocket readDataWithTimeout:-1 tag:0];
    if (diskCount == 0) {
        
        _strData = [[NSMutableData alloc] init];
        //        NSString *content = [[NSString alloc] initWithData:strData encoding:NSUTF8StringEncoding];
        //        if (content) {
        //            NSLog(@"%@",content);
        //        }
        //        diskLenth = content.doubleValue;
        [data getBytes:&diskLenth length:sizeof(diskLenth)];
        diskCount ++;
    }else {
        [_strData appendData:[data subdataWithRange:NSMakeRange(0, [data length] )]];
        NSString *j1 = [[NSString alloc] initWithData:_strData encoding:NSUTF8StringEncoding];
        NSLog(@"%ld",(unsigned long)j1.length);
        NSLog(@"%@",j1);
        
        if (_strData.length < diskLenth) {
        }else{
            
            NSError *error = nil;
            NSArray *array = [NSJSONSerialization JSONObjectWithData:[_strData subdataWithRange:NSMakeRange(6, diskLenth - 6)] options:0 error:&error];
            
            _strData = nil;
            diskCount--;
            if (array) {
                NSLog(@"%@",array);
                NSNotification *diskDidReceivedNotice = [NSNotification notificationWithName:@"diskDidReceived" object:nil userInfo:[NSDictionary dictionaryWithObject:array forKey:@"diskArray"]];
                        //发送消息
                [[NSNotificationCenter defaultCenter]postNotification:diskDidReceivedNotice];
            }else if (error) {
                NSLog(@"《《%@》》",error);
            }else{
                
            }
        }
    }
    
    
    [_cmdAsyncSocket readDataWithTimeout:-1 tag:0];
}
- (void)onSocketDidDisconnect:(AsyncSocket *)sock {
    if (!cutByUser) {
        isOnline = NO;
        cutByUser = NO;
        [self.cmdDelegate cmdConectFail];
    }
}
-(void)cutOffCmdSocket{
    isOnline = NO;
    cutByUser = YES;
    [_cmdAsyncSocket disconnect];
}

//- (void)initCmdFaileNotification {
//    NSNotification *cmdConectFaileNotice = [NSNotification notificationWithName:@"cmdConectFaile" object:nil userInfo:nil];
//    //发送消息
//    [[NSNotificationCenter defaultCenter]postNotification:cmdConectFaileNotice];
//
//}
//-（void）onSocket:(Asyncsocket *)sock didReadPartialDataOfLength:(NSUInteger)partiaLength tag:(long)tag;
//当一个socket读取数据，但尚未完成读操作的时候调用，如果使用 readToData: or readToLength: 方法 会发生,可以被用来更新进度条等东西
//
//- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag {
//    
//}
//
//当一个socket已完成请求数据的写入时候调用
//-（void）onSocket:(AsyncSocket *)sock didWritePartialDataOfLength:(NSUInteger)partialLength tag:(long)tag;
//
//当一个socket写入一些数据，但还没有完成整个写入时调用，它可以用来更新进度条等东西
//
//-（void）readDataToLength: (NSUInteger)length withTimeout:(NSTimeInterval)tiemout buffer:(NSMutableData *)buffer bufferOffset:(NSUInteger) offset tag:(long)tag;
//
//读取给定的字节数,在给定的偏移开始，字节将被追加到给定的字节缓冲区
//
@end



