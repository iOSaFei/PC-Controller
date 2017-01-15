//
//  TouchControlView.m
//  西邮快传1.0
//
//  Created by iOS-aFei on 16/5/11.
//  Copyright © 2016年 iOS 阿飞. All rights reserved.
//

#import "TouchControlView.h"

@implementation TouchControlView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
        [self addLabel];
        [self addTouchGestureRecognizer];
        _cmdAsyncSocketModel = [CmdAsyncSocketModel cmdSharedInstance];
    }
    return self;
}
- (void)addLabel {
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, kWindowWidth - 30, 30)];
    nameLabel.text = @"西 邮 快 传";
    nameLabel.textColor = [UIColor colorWithRed:32/255.0 green:172/255.0 blue:225/255.0 alpha:1.0];
    nameLabel.font = [UIFont systemFontOfSize:28];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:nameLabel];
    UILabel *touchLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 90, kWindowWidth - 30, 30)];
    touchLabel.text = @"触 摸 板";
    touchLabel.textColor = [UIColor colorWithRed:32/255.0 green:172/255.0 blue:225/255.0 alpha:1.0];
    touchLabel.font = [UIFont systemFontOfSize:25];
    touchLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:touchLabel];
}
- (void)addTouchGestureRecognizer {
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
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
    CGPoint translation = [pan translationInView:self];
    NSString *str = [NSString stringWithFormat:@"%f,%f,%@", translation.x, translation.y, @"Move,"];
    [self sengGestureCmd:str];
}
- (void)tap:(UITapGestureRecognizer *)tap {
    NSString *str = @"0,0,Left,";
    [self sengGestureCmd:str];
}
- (void)twoTap:(UITapGestureRecognizer *)twoTap {
    NSString *str = @"0,0,Right,";
    [self sengGestureCmd:str];
}
- (void)pinch:(UIPinchGestureRecognizer *)pinch {
    if (pinch.state == UIGestureRecognizerStateEnded) {
        if (pinch.scale > 1) {
            NSString *str = @"0,0,Big,";
            [self sengGestureCmd:str];
        }else if(pinch.scale <1) {
            NSString *str = @"0,0,Small,";
            [self sengGestureCmd:str];
        }
    }
}
- (void)swipeDown:(UISwipeGestureRecognizer *)swipDown {
    NSString *str = @"0,0,WheelDown,";
    [self sengGestureCmd:str];
}
- (void)swipeUp:(UISwipeGestureRecognizer *)swipUp {
    NSString *str = @"0,0,WheelUp,";
    [self sengGestureCmd:str];
}
- (void)sengGestureCmd:(NSString *)str {
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"3", @"Typ", str, @"Msg", nil];
    NSString *json = [CodeJSON codeJson:dictionary];
    NSString *diskCmdJson = [NSString stringWithFormat:@"XiYou#%@",json];

    [_cmdAsyncSocketModel sendCmd:diskCmdJson];
}
@end
