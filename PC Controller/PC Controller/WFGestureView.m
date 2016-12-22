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

@end

@implementation WFGestureView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.95
                                               green:0.95
                                                blue:0.95
                                               alpha:1.0];
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

//  添加手势
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

//  滑动手势处理
- (void)handlePan:(UIPanGestureRecognizer *)pan {
    
    CGPoint location = [pan locationInView:self];
    CALayer *layer   = [self waveLayerWithLocation:location];
    [self.layer addSublayer:layer];
    
    CGPoint translation = [pan translationInView:self];
    NSString *str = [NSString stringWithFormat:@"1:%f:%f", translation.x/10, translation.y/10];
    [self setupDictionary:str];
    
    [self setAnimation:layer];
}

//  单指手势处理
- (void)tap:(UITapGestureRecognizer *)tap {
    
    CGPoint location = [tap locationInView:self];
    CALayer *layer   = [self waveLayerWithLocation:location];
    [self.layer addSublayer:layer];
    
    NSString *str = @"6";
    [self setupDictionary:str];
    
    [self setAnimation:layer];

}

//  双指手势处理
- (void)twoTap:(UITapGestureRecognizer *)twoTap {
    
    CGPoint location1 = [twoTap locationOfTouch:0 inView:self];
    CALayer *layer1   = [self waveLayerWithLocation:location1];
    [self.layer addSublayer:layer1];
    

    CGPoint location2 = [twoTap locationOfTouch:1 inView:self];
    CALayer *layer2   = [self waveLayerWithLocation:location2];
    [self.layer addSublayer:layer2];

    NSString *str = @"5";
    [self setupDictionary:str];
    
    [self setAnimation:layer1];
    [self setAnimation:layer2];
}

//  放大缩小处理
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

//  双指下滑处理
- (void)swipeDown:(UISwipeGestureRecognizer *)swipDown {
    
    CGPoint location1 = [swipDown locationOfTouch:0 inView:self];
    CALayer *layer1   = [self waveLayerWithLocation:location1];
    [self.layer addSublayer:layer1];
    
    
    CGPoint location2 = [swipDown locationOfTouch:1 inView:self];
    CALayer *layer2   = [self waveLayerWithLocation:location2];
    [self.layer addSublayer:layer2];

    
    NSString *str = @"9";
    [self setupDictionary:str];
    
    [self setAnimation:layer1];
    [self setAnimation:layer2];
}

//  双指上滑处理
- (void)swipeUp:(UISwipeGestureRecognizer *)swipUp {
    
    CGPoint location1 = [swipUp locationOfTouch:0 inView:self];
    CALayer *layer1   = [self waveLayerWithLocation:location1];
    [self.layer addSublayer:layer1];
    
    CGPoint location2 = [swipUp locationOfTouch:1 inView:self];
    CALayer *layer2   = [self waveLayerWithLocation:location2];
    [self.layer addSublayer:layer2];
    
    NSString *str = @"8";
    [self setupDictionary:str];
    
    [self setAnimation:layer1];
    [self setAnimation:layer2];
}

//  layer工厂
- (CALayer *)waveLayerWithLocation:(CGPoint)location {
    
    CALayer *waveLayer = [CALayer layer];
    waveLayer.frame = CGRectMake(location.x - 1, location.y - 1,10,10);
    waveLayer.backgroundColor = kMainColor.CGColor;
    waveLayer.cornerRadius = 5;
    return waveLayer;
}

//  处理手势
- (void)setupDictionary: (NSString *)string {
    NSDictionary *dictionary = [NSDictionary cmdDictionaryWithValue:string
                                                                key:@"mouse"];
    self.handelGesture(dictionary);
}

//  设置手势动画
- (void)setAnimation:(CALayer *)layer {
    const int max = 8;
    if (layer.transform.m11 < max)
    {
        [layer setTransform:CATransform3DScale(layer.transform, 1.1, 1.1, 1.0)];
        //_cmd 获取当前方法的名字
        [self performSelector:_cmd withObject:layer afterDelay:0.02];
    } else {
        [layer removeFromSuperlayer];
    }
}
@end
