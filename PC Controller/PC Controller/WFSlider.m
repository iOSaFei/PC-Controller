//
//  WFSlider.m
//  WFSlider
//
//  Created by iOS-aFei on 16/10/5.
//  Copyright © 2016年 iOS-aFei. All rights reserved.
//

#import "WFSlider.h"
#import "WFPopView.h"
#define currentX self.value/self.maximumValue*CGRectGetWidth(self.frame)

#define popWidth 50
#define popHeight 50
#define popX  currentX-popWidth/2
#define popY 0


@interface WFSlider ()
{
    int _flag;
}

@property (nonatomic, strong) WFPopView *popView;

@end
@implementation WFSlider

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.minimumValue = 0;
        self.maximumValue = 100;
        self.value        = 50;
    }
    return self;
}
- (WFPopView *)popView {
    if (!_popView) {
        _popView = [[WFPopView alloc] initWithFrame:CGRectMake(popX, 5, popWidth, popHeight)];
        _popView.alpha = 0;
        [self addSubview:_popView];
    }
    return _popView;
}
#pragma mark-override 
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    _flag = 0;
    BOOL begin = [super beginTrackingWithTouch:touch withEvent:event];
    [self.popView showWithContent:[NSString stringWithFormat:@"%d", (int)self.value] duration:0.5];
    return begin;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    BOOL continueTrack = [super continueTrackingWithTouch:touch withEvent:event];
    _popView.frame = CGRectMake(popX, 0, popWidth, popHeight);
    NSString *value = [NSString stringWithFormat:@"%d", (int)self.value];
    [_popView contendChanged:value];
    _flag ++;
    if (_flag % 5 == 0) {
        _flag = 0;
        _progressChanged(value);
    }
    return continueTrack;
}
- (void)cancelTrackingWithEvent:(UIEvent *)event
{
    [super cancelTrackingWithEvent:event];
    [self.popView hideWithDuration:1.0];
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [super endTrackingWithTouch:touch withEvent:event];
    NSString *value = [NSString stringWithFormat:@"%d", (int)self.value];
    [_popView contendChanged:value];
    _progressChanged(value);
    [self.popView hideWithDuration:1.0];
}

@end
