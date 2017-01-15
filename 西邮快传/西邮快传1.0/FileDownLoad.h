//
//  FileDownLoad.h
//  西邮快传1.0
//
//  Created by iOS 阿飞 on 16/2/6.
//  Copyright © 2016年 iOS 阿飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileDownLoad : NSObject
+ (void)writeFile:(NSData *)data withFileName:(NSString *)name;
@end
