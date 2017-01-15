//
//  FileDownLoad.m
//  西邮快传1.0
//
//  Created by iOS 阿飞 on 16/2/6.
//  Copyright © 2016年 iOS 阿飞. All rights reserved.
//

#import "FileDownLoad.h"

@implementation FileDownLoad
+ (void)writeFile:(NSData *)data withFileName:(NSString *)name {
    BOOL exit = NO;
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/fileNameArray.plist"];
//    NSFileManager *fileManagerList = [[NSFileManager alloc] init];
//    if (![[NSFileManager defaultManager] fileExistsAtPath:path])
//    {
//        [fileManagerList createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
//    }

    NSMutableArray *fileNameArray = [[NSMutableArray alloc] initWithContentsOfFile:path];
    if (!fileNameArray) {
         fileNameArray = [[NSMutableArray alloc] init];
        [fileNameArray addObject:name];
    }else {
        for (NSString *string in fileNameArray) {
            if ([string isEqualToString:name]) {
                exit = YES;
            }
        }
        if (!exit)
            [fileNameArray addObject:name];
    }
    if (!exit) {
        BOOL success1 = [fileNameArray writeToFile:path atomically:YES];
        if (success1) {
            NSLog(@"写入成功!");
            NSNotification *didReadFileNameNotice = [NSNotification notificationWithName:@"didReadFileName" object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter]postNotification:didReadFileNameNotice];
        }
        NSString *folder = [NSString stringWithFormat:@"Documents/FileDownload"];
        NSString *homeDirectory = NSHomeDirectory();
       
        NSString *folderPath = [homeDirectory stringByAppendingPathComponent:folder];
        NSFileManager *fileManager = [[NSFileManager alloc] init];
            //文件是否存在
            if (![[NSFileManager defaultManager] fileExistsAtPath:folderPath])
            {
//                创建文件
                [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
            }
        NSString *filePath = [NSString stringWithFormat:@"Documents/FileDownload/%@",name];
        NSString *documentPaths = [homeDirectory stringByAppendingPathComponent:filePath];
        BOOL success = [data writeToFile:documentPaths atomically:YES];
        if (success) {
            NSLog(@"xieruchenggong");
        }
    }
    //    NSString *filePath = [NSString stringWithFormat:@"Documents/FileDownload"];
//    NSLog(@"%@",filePath);
//    NSString *homeDirectory = NSHomeDirectory();
//    NSLog(@"%@",homeDirectory);
//     NSString *createPath = [homeDirectory stringByAppendingPathComponent:filePath];
//    NSFileManager *fileManager = [[NSFileManager alloc] init];
//        if (![[NSFileManager defaultManager] fileExistsAtPath:createPath])
//    {
//        [fileManager createDirectoryAtPath:createPath withIntermediateDirectories:YES attributes:nil error:nil];
//    }
//    else 
//    {
//        NSLog(@"Have");
//    }

}
@end
