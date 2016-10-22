//
//  WFGestureView.m
//  PC Controller
//
//  Created by iOS-aFei on 16/10/14.
//  Copyright © 2016年 iOS-aFei. All rights reserved.
//

#import "WFGestureView.h"
#import "NSDictionary+CmdDictionary.h"

@interface WFGestureView ()
{
    int _flag;
}
@end

@implementation WFGestureView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.95
                                               green:0.95
                                                blue:0.95
                                               alpha:1.0];
        _flag = 0;
        [self addLabel];
        [self addTouchGestureRecognizer];
    }
    return self;
}
- (void)addLabel {
    UILabel *mourseLabel      = [[UILabel alloc] initWithFrame:CGRectMake(kWindowWidth - 200, kWindowHeight - 150, 200, 50)];
    mourseLabel.textAlignment = NSTextAlignmentRight;
    mourseLabel.textColor     = kMainColor;
    mourseLabel.text          = @"右半边是触摸板哦";
    [self addSubview:mourseLabel];
}
- (void)addTouchGestureRecognizer {
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    pan.maximumNumberOfTouches = 1;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    UITapGestureRecognizer *twoTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(twoTap:)];
    twoTap.numberOfTouchesRequired = 2;
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    UISwipeGestureRecognizer *swipDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDown:)];
    swipDown.direction = UISwipeGestureRecognizerDirectionDown;
    swipDown.numberOfTouchesRequired = 2;
    UISwipeGestureRecognizer *swipUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeUp:)];
    swipUp.direction = UISwipeGestureRecognizerDirectionUp;
    swipUp.numberOfTouchesRequired = 2;
    [self addGestureRecognizer:pan];
    [self addGestureRecognizer:tap];
    [self addGestureRecognizer:twoTap];
    [self addGestureRecognizer:pinch];
    [self addGestureRecognizer:swipDown];
    [self addGestureRecognizer:swipUp];
}
- (void)handlePan:(UIPanGestureRecognizer *)pan {
    _flag ++;
//    if (_flag % 5 == 0) {
        _flag = 0;
        CGPoint translation = [pan translationInView:self];
        NSString *str = [NSString stringWithFormat:@"1:%f:%f", translation.x/10, translation.y/10];
        [self setupDictionary:str];
//    }
}
- (void)tap:(UITapGestureRecognizer *)tap {
    NSString *str = @"6";
    [self setupDictionary:str];
}
- (void)twoTap:(UITapGestureRecognizer *)twoTap {
    NSString *str = @"5";
    [self setupDictionary:str];
}
- (void)pinch:(UIPinchGestureRecognizer *)pinch {
//    if (pinch.state == UIGestureRecognizerStateEnded) {
//        if (pinch.scale > 1) {
//            NSString *str = @"0,0,Big,";
//            [self setupDictionary:str];
//        }else if(pinch.scale <1) {
//            NSString *str = @"0,0,Small,";
//            [self setupDictionary:str];
//        }
//    }
}
- (void)swipeDown:(UISwipeGestureRecognizer *)swipDown {
    NSString *str = @"9";
    [self setupDictionary:str];
}
- (void)swipeUp:(UISwipeGestureRecognizer *)swipUp {
    NSString *str = @"8";
    [self setupDictionary:str];
}
- (void)setupDictionary: (NSString *)string {
    NSDictionary *dictionary = [NSDictionary cmdDictionaryWithValue:string
                                                                key:@"mouse"];
    self.handelGesture(dictionary);
}
@end
