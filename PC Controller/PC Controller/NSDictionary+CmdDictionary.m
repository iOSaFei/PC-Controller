//
//  NSDictionary+CmdDictionary.m
//  PC Controller
//
//  Created by iOS-aFei on 16/10/14.
//  Copyright © 2016年 iOS-aFei. All rights reserved.
//

#import "NSDictionary+CmdDictionary.h"

@implementation NSDictionary (CmdDictionary)

+ (NSDictionary *)cmdDictionaryWithValue:(NSString *)value key:(NSString *)key {
    NSDictionary *dictionary = @{ @"command":key,
                                  @"parameter":value
                                };
    return dictionary;

}

@end
