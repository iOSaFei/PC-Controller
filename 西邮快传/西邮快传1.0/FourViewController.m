//
//  FourViewController.m
//  西邮快传1.0
//
//  Created by iOS 阿飞 on 16/1/26.
//  Copyright © 2016年 iOS 阿飞. All rights reserved.
//

#import "FourViewController.h"
#import "BDRecognizerViewController.h"
#import "BDRecognizerViewDelegate.h"
#import "BDRecognizerViewParamsObject.h"
#import "BDVRSConfig.h"
#define APPID       @"8152246"
#define APIKEY      @"DWYrlmcwT28wFeFtoyqAeszC"
#define SECRETKEY   @"b89a5886a9ded906615dd07ab1b9706d"
#define LANGUAGE    LANGUAGE_CHINESE


@interface FourViewController ()<BDRecognizerViewDelegate>

@property (nonatomic, retain) BDRecognizerViewController *recognizerViewController;


@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *voiceButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    voiceButton.frame = self.view.frame;
    voiceButton.backgroundColor = [UIColor redColor];
    [voiceButton addTarget:self action:@selector(startVoice) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:voiceButton];
}

- (void)startVoice {
    // 创建识别控件,origin	控件左上角的坐标,theme	控件的主题，如果为nil，则为默认主题
    BDRecognizerViewController *tmpRecognizerViewController = [[BDRecognizerViewController alloc] initWithOrigin:CGPointMake(9, 128) withTheme:[BDVRSConfig sharedInstance].theme];
    // 全屏UI
    tmpRecognizerViewController.enableFullScreenMode = YES;
    // 设置委托
    tmpRecognizerViewController.delegate = self;
    self.recognizerViewController = tmpRecognizerViewController;
    
    BDRecognizerViewParamsObject *paramsObject = [[BDRecognizerViewParamsObject alloc] init];
    // 开发者信息，必须修改API_KEY和SECRET_KEY为在百度开发者平台申请得到的值，否则示例不能工作
    paramsObject.apiKey = APIKEY;
    paramsObject.secretKey = SECRETKEY;
    // 设置是否需要语义理解，只在搜索模式有效
    paramsObject.isNeedNLU = [BDVRSConfig sharedInstance].isNeedNLU;
    
    // 设置识别语言
    paramsObject.language = [BDVRSConfig sharedInstance].recognitionLanguage;
    
    // 设置识别模式，分为搜索和输入
    paramsObject.recogPropList = @[[BDVRSConfig sharedInstance].recognitionProperty];
    
    // 设置城市ID，当识别属性包含EVoiceRecognitionPropertyMap时有效
    paramsObject.cityID = 1;
    
    // 开启联系人识别
    //    paramsObject.enableContacts = YES;
    
    // 设置显示效果，是否开启连续上屏
    if ([BDVRSConfig sharedInstance].resultContinuousShow)
    {
        paramsObject.resultShowMode = BDRecognizerResultShowModeContinuousShow;
    }
    else
    {
        paramsObject.resultShowMode = BDRecognizerResultShowModeWholeShow;
    }
    
    // 设置提示音开关，是否打开，默认打开
    if ([BDVRSConfig sharedInstance].uiHintMusicSwitch)
    {
        paramsObject.recordPlayTones = EBDRecognizerPlayTonesRecordPlay;
    }
    else
    {
        paramsObject.recordPlayTones = EBDRecognizerPlayTonesRecordForbidden;
    }
    
    //    paramsObject.isShowTipAfterSilence = YES;
    //    paramsObject.isShowHelpButtonWhenSilence = YES;
    paramsObject.tipsTitle = @"您可以说";
    paramsObject.tipsList = [NSArray arrayWithObjects:@"打开PPT", @"打开Word", @"打开百度", @"打开新浪微博", @"打开任务管理器", nil];
    paramsObject.disableCarousel = YES;
    // 开始识别
    [_recognizerViewController startWithParams:paramsObject];
        
}
-(void)onEndWithViews:(BDRecognizerViewController *)aBDRecognizerViewController withResults:(NSArray *)aResults{
    //创建语音识别客户对象,
    if ([[BDVoiceRecognitionClient sharedInstance] getRecognitionProperty] != EVoiceRecognitionPropertyInput) {
        NSMutableArray *audioResultData = (NSMutableArray *)aResults;
        NSMutableString *tmpString = [[NSMutableString alloc] initWithString:@""];
        
        for (int i=0; i < [audioResultData count]; i++)
        {
            [tmpString appendFormat:@"%@\r\n",[audioResultData objectAtIndex:i]];
        }
        NSLog(@"%@", tmpString);
    } else {
        NSString *tmpString = [[BDVRSConfig sharedInstance] composeInputModeResult:aResults];
        NSLog(@"%@", tmpString);
        
    }
}

- (void)VoiceRecognitionClientWorkStatus:(int) aStatus obj:(id)aObj
{
    switch (aStatus)
    {
        case EVoiceRecognitionClientWorkStatusFinish:
        {
            if ([[BDVoiceRecognitionClient sharedInstance] getRecognitionProperty] != EVoiceRecognitionPropertyInput)
            {
                NSMutableArray *audioResultData = (NSMutableArray *)aObj;
                NSMutableString *tmpString = [[NSMutableString alloc] initWithString:@""];
                
                for (int i=0; i<[audioResultData count]; i++)
                {
                    [tmpString appendFormat:@"%@\r\n",[audioResultData objectAtIndex:i]];
                }
                NSLog(@"%@", tmpString);
                //                self.resultView.text = nil;
                //                [self logOutToManualResut:tmpString];
                //                [tmpString release];
                NSLog(@"333333");
            }
            else
            {
                //                self.resultView.text = nil;
                NSString *tmpString = [[BDVRSConfig sharedInstance] composeInputModeResult:aObj];
                NSLog(@"%@", tmpString);
                //                [self logOutToManualResut:tmpString];
                NSLog(@"44444");
            }
            //            [self logOutToLogView:@"识别完成"];
            break;
        }
        case EVoiceRecognitionClientWorkStatusFlushData:
        {
            NSMutableString *tmpString = [[NSMutableString alloc] initWithString:@""];
            
            [tmpString appendFormat:@"%@",[aObj objectAtIndex:0]];
            NSLog(@"%@", tmpString);
            //            self.resultView.text = nil;
            //            [self logOutToManualResut:tmpString];
            //            [tmpString release];
            NSLog(@"55555");
            
            break;
        }
        case EVoiceRecognitionClientWorkStatusReceiveData:
        {
            if ([[BDVoiceRecognitionClient sharedInstance] getRecognitionProperty] == EVoiceRecognitionPropertyInput)
            {
                //                self.resultView.text = nil;
                NSString *tmpString = [[BDVRSConfig sharedInstance] composeInputModeResult:aObj];
                NSLog(@"%@", tmpString);
                //                [self logOutToManualResut:tmpString];
                NSLog(@"666666");
            }
            
            break;
        }
        case EVoiceRecognitionClientWorkStatusEnd:
        {
            break;
        }
        default:
        {
            break;
        }
    }
}

//语音识别完成会调用此函数。返回结果均为数组，搜索结果数组元素为整体识别结果，输入结果数组元素为字典。
//-(void)onEndWithViews:(BDRecognizerViewController *)aBDRecognizerViewController withResults:(NSArray *)aResults{
//}
// 实现委托
- (void)VoiceRecognitionClientErrorStatus:(int) aStatus subStatus:(int)aSubStatus
{
    // 处理出错
}
//- (void)VoiceRecognitionClientWorkStatus:(int)aStatus obj:(id)aObj
//{
//    //处理网络状态变化
//}
- (void)VoiceRecognitionClientNetWorkStatus:(int) aStatus
{
    // 处理网络状态变化
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
