//
//  FileAsyncSocketModel.m
//  西邮快传1.0
//
//  Created by iOS 阿飞 on 16/1/27.
//  Copyright © 2016年 iOS 阿飞. All rights reserved.
//

#import "FileAsyncSocketModel.h"

@implementation FileAsyncSocketModel
BOOL fileIsOnline;
BOOL cutFileByUser = NO;
int fileCount = 0;
double fileLength;
+ (instancetype)fileSharedInstance {
    
    static FileAsyncSocketModel *fileAsyncSocketModel = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        fileAsyncSocketModel = [[FileAsyncSocketModel alloc] init];
    });
    return fileAsyncSocketModel;
}
- (void)initFileSocket:(NSString *)ipString withPort:(int)port{
    _fileAsyncSocket = [[AsyncSocket alloc] initWithDelegate:self];
    NSError *error = nil;
    [_fileAsyncSocket connectToHost:ipString onPort:port error:&error];
}
- (void)sendFileCmd:(NSString *)fileCmdString withFileName:(NSString *)name {
    if (fileIsOnline) {
        _fileName = name;
        NSData *data = [fileCmdString dataUsingEncoding:NSUTF8StringEncoding];
        [_fileAsyncSocket writeData:data withTimeout:-1 tag:0];
    }
    else {
        NSLog(@"file暂未连接服务器");
        [self.fileDelegate fileConectFail];
       // [self initFileFaileNotification];
    }
}
- (void)sendFileData:(NSData *)data {
    if (fileIsOnline) {
        [_fileAsyncSocket writeData:data withTimeout:-1 tag:0];
    }
    else {
        NSLog(@"file暂未连接服务器");
        [self.fileDelegate fileConectFail];
        // [self initFileFaileNotification];
    }
}

//当成功连接到服务器时激发该方法
- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port {
    fileIsOnline = YES;
    cutFileByUser = NO;
    [self.fileDelegate fileConectSuccess];
    NSLog(@"file连接成功");
    //调用此方法读取数据
    [_fileAsyncSocket readDataWithTimeout:-1 tag:0];
}
- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    if (fileCount == 0) {
        //NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingGB_18030_2000);
        NSData *strData = [data subdataWithRange:NSMakeRange(0, [data length])];
        _fileData = [[NSMutableData alloc] init];
        NSString *content = [[NSString alloc] initWithData:strData encoding:NSUTF8StringEncoding];
        if (content) {
            NSLog(@"%@",content);
        }
        fileLength = content.doubleValue;
        fileCount ++;
    }else {
        [_fileData appendData:[data subdataWithRange:NSMakeRange(0, [data length])]];
        if (_fileData.length < fileLength) {
        }else{
            fileCount --;
            [FileDownLoad writeFile:_fileData withFileName:_fileName];
        }
    }
    [_fileAsyncSocket readDataWithTimeout:-1 tag:0];
}
- (void)onSocketDidDisconnect:(AsyncSocket *)sock {
    if (!cutFileByUser) {
        fileIsOnline = NO;
        cutFileByUser = NO;
        [self.fileDelegate fileConectFail];
    }
}
-(void)cutOffFileSocket{
    fileIsOnline = NO;
    cutFileByUser = YES;
    [_fileAsyncSocket disconnect];
}
- (void)onSocket:(AsyncSocket *)sock didWritePartialDataOfLength:(NSUInteger)partialLength tag:(long)tag {
    NSLog(@"[[[[[[%ld %ld",partialLength,tag);
    [self.fileDelegate fileWriteSucceed];
}
- (void)readDataToLength: (NSUInteger)length withTimeout:(NSTimeInterval)tiemout buffer:(NSMutableData *)buffer bufferOffset:(NSUInteger) offset tag:(long)tag {
    NSLog(@"%ld",offset);
}

//- (void)initFileFaileNotification {
//    NSNotification *fileConectFaileNotice = [NSNotification notificationWithName:@"fileConectFaile" object:nil userInfo:nil];
//    [[NSNotificationCenter defaultCenter]postNotification:fileConectFaileNotice];
//    
//}

@end
