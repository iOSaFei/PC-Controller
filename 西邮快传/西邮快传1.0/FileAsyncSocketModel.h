//
//  FileAsyncSocketModel.h
//  西邮快传1.0
//
//  Created by iOS 阿飞 on 16/1/27.
//  Copyright © 2016年 iOS 阿飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncSocket.h"
#import "FileDownLoad.h"
@protocol FileAsycnSocketModelDelegate <NSObject>

- (void)fileConectSuccess;
- (void)fileConectFail;
- (void)fileWriteSucceed;
- (void)fileDidReadData:(NSData *)data withFileName:(NSString *)name;
@end

@interface FileAsyncSocketModel : NSObject<AsyncSocketDelegate>
@property(nonatomic, weak) id<FileAsycnSocketModelDelegate>fileDelegate;
@property(nonatomic, strong) AsyncSocket *fileAsyncSocket;
@property(nonatomic, strong) NSMutableData *fileStrData;
@property(nonatomic, strong) NSString *fileName;
@property(nonatomic, strong) NSMutableData *fileData;
+ (instancetype)fileSharedInstance;
- (void) initFileSocket:(NSString *)ipString withPort:(int)port;
- (void)sendFileCmd:(NSString *)fileCmdString withFileName:(NSString *)name;
- (void)sendFileData:(NSData *)data;
- (void)cutOffFileSocket;
@end
