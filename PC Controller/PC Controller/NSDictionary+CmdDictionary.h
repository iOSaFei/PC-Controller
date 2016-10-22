//
//  NSDictionary+CmdDictionary.h
//  PC Controller
//
//  Created by iOS-aFei on 16/10/14.
//  Copyright © 2016年 iOS-aFei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (CmdDictionary)

+ (NSDictionary *)cmdDictionaryWithValue:(NSString *)value key:(NSString *)key;

@end
