//
//  WFLightnessAndVolume.m
//  PC Controller
//
//  Created by iOS-aFei on 16/10/5.
//  Copyright © 2016年 iOS-aFei. All rights reserved.
//

#import "WFLightnessAndVolume.h"
#import "WFSlider.h"

@interface WFLightnessAndVolume ()

@property (nonatomic, strong) WFSlider *lSlider;
@property (nonatomic, strong) WFSlider *vSlider;

@end

@implementation WFLightnessAndVolume

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kMainColor;
        [self addSubViews];
    }
    return self;
}
- (void)addSubViews {
    __weak WFLightnessAndVolume *weakSelf = self;
    _lSlider = [[WFSlider alloc] initWithFrame:CGRectMake(40, 20, CGRectGetWidth(self.frame) - 60, 140)];
    _lSlider.progressChanged = ^(NSString *value) {
        weakSelf.lProgressChanged(value);
    };
    [self addSubview:_lSlider];
    _vSlider = [[WFSlider alloc] initWithFrame:CGRectMake(40, 100, CGRectGetWidth(self.frame) - 60, 140)];
    _vSlider.progressChanged = ^(NSString *value) {
        weakSelf.vProgressChanged(value);
    };
    [self addSubview:_vSlider];
    
    UIImageView *lightness = [[UIImageView alloc] initWithFrame:CGRectMake(5, 70, 30, 30)];
    lightness.image = [UIImage imageNamed:@"Lightness"];
    [self addSubview:lightness];
    
    UIImageView *volume = [[UIImageView alloc] initWithFrame:CGRectMake(5, 150, 30, 30)];
    volume.image = [UIImage imageNamed:@"Volume"];
    [self addSubview:volume];
    
    UIButton *removeButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    [removeButton setImage:[UIImage imageNamed:@"remove"]
                  forState:UIControlStateNormal];
    removeButton.frame = CGRectMake(CGRectGetWidth(self.frame) - 40, 0, 40, 40);
    [removeButton addTarget:self action:@selector(disapper) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:removeButton];
}
- (void)showWithDuration:(NSTimeInterval)duration {
    [UIView animateWithDuration:duration animations:^{
        self.frame = CGRectMake(101, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    }];
}
- (void)disapper {
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(kWindowWidth, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    }];
}
@end
