//
//  InitControlArrayModel.m
//  西邮快传1.0
//
//  Created by iOS 阿飞 on 16/1/26.
//  Copyright © 2016年 iOS 阿飞. All rights reserved.
//

#import "InitControlArrayModel.h"

@implementation InitControlArrayModel
+ (NSArray *)initCmdArray {
    NSDictionary *logoff = [NSDictionary dictionaryWithObjectsAndKeys:@"Cmd",@"Typ",@"Win_Logoff",@"Msg", nil];
    NSDictionary *shutdown = [NSDictionary dictionaryWithObjectsAndKeys:@"Cmd",@"Typ",@"Win_Shutdown",@"Msg", nil];
    NSDictionary *sleep = [NSDictionary dictionaryWithObjectsAndKeys:@"Cmd",@"Typ",@"Win_Sleep",@"Msg", nil];
    NSDictionary *reset = [NSDictionary dictionaryWithObjectsAndKeys:@"Cmd",@"Typ",@"Win_Reset",@"Msg", nil];
    NSDictionary *screenshot = [NSDictionary dictionaryWithObjectsAndKeys:@"Cmd",@"Typ",@"Win_Screenshot",@"Msg", nil];
    NSDictionary *volumeUp = [NSDictionary dictionaryWithObjectsAndKeys:@"Cmd",@"Typ",@"Win_VolumeUp",@"Msg", nil];
    NSDictionary *volumeDown = [NSDictionary dictionaryWithObjectsAndKeys:@"Cmd",@"Typ",@"Win_VolumeDown",@"Msg", nil];
    NSDictionary *close_PowerPoint = [NSDictionary dictionaryWithObjectsAndKeys:@"OfficeProgram",@"Typ",@"Close_PowerPoint",@"Msg", nil];
    NSDictionary *down_PowerPoint = [NSDictionary dictionaryWithObjectsAndKeys:@"OfficeProgram",@"Typ",@"Down_PowerPoint",@"Msg", nil];
    NSDictionary *up_PowerPoint = [NSDictionary dictionaryWithObjectsAndKeys:@"OfficeProgram",@"Typ",@"Up_PowerPoint",@"Msg", nil];
    NSDictionary *frist_PowerPoint = [NSDictionary dictionaryWithObjectsAndKeys:@"OfficeProgram",@"Typ",@"Frist_PowerPoint",@"Msg", nil];
    NSDictionary *last_PowerPoint = [NSDictionary dictionaryWithObjectsAndKeys:@"OfficeProgram",@"Typ",@"Last_PowerPoint",@"Msg", nil];
    NSArray *powerArray = @[logoff, shutdown, sleep, reset];
    NSArray *screenArray = @[screenshot];
    NSArray *voiceArray = @[volumeUp, volumeDown];
    NSArray *pptArray = @[close_PowerPoint, down_PowerPoint, up_PowerPoint, frist_PowerPoint, last_PowerPoint];
    NSArray *initArray = @[powerArray, screenArray, voiceArray, pptArray];
    return initArray;
}
+ (NSArray *)initCollectionArray {
    NSArray *powerArrayC = @[@"注销", @"关机", @"睡眠", @"重启"];
    NSArray *screenArrayC = @[@"截屏"];
    NSArray *voiceArrayC = @[@"音量+", @"音量-"];
    NSArray *pptArrayC = @[@"关闭ppt", @"下一页", @"上一页", @"到首页", @"到末页"];
    NSArray *initArrayC = @[powerArrayC, screenArrayC, voiceArrayC, pptArrayC];
    return initArrayC;
    
}

@end
