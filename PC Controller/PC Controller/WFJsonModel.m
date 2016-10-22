//
//  WFJsonModel.m
//  PC Controller
//
//  Created by iOS-aFei on 16/10/13.
//  Copyright © 2016年 iOS-aFei. All rights reserved.
//

#import "WFJsonModel.h"

@implementation WFJsonModel

+ (NSString *)jsonString :(NSDictionary *)dictionary {
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary
                                                   options:0 error:nil];
    NSString *json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSString *j = [NSString stringWithFormat:@"%@\n",json];
    return j;
}

@end
