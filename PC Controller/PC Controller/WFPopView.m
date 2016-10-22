//
//  WFPopView.m
//  WFSlider
//
//  Created by iOS-aFei on 16/10/5.
//  Copyright © 2016年 iOS-aFei. All rights reserved.
//

#import "WFPopView.h"

@interface WFPopView ()

@property (nonatomic, strong) UILabel *label;

@end
@implementation WFPopView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.image           = [UIImage imageNamed:@"PopBg"];
        [self addLabel];
    }
    return self;
}
- (void)addLabel {
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.textColor     = [UIColor orangeColor];
    [self addSubview:_label];
}
- (void)contendChanged:(NSString *)string {
    _label.text = string;
}
- (void)showWithContent:(NSString *)string duration:(NSTimeInterval)duration {
    _label.text = string;
    [UIView animateWithDuration:duration animations:^() {
        self.alpha = 1.0;
    }];
}
- (void)hideWithDuration:(NSTimeInterval) duration {
    [UIView animateWithDuration:duration animations:^() {
        self.alpha = 0.0;
    }];
}

@end
