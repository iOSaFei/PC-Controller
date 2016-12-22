//
//  WFFileSocketModel.h
//  PC Controller
//
//  Created by iOS-aFei on 16/10/22.
//  Copyright © 2016年 iOS-aFei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WFFileSocketModel : NSObject

@property (nonatomic, copy) void (^receiveFinished)(NSMutableData *data);

+ (instancetype)fileSharedInstance;
- (void)initFileSocket:(NSString *)ipString withPort:(int)port;

@end
