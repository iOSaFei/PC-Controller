//
//  WFQuickStartView.m
//  PC Controller
//
//  Created by iOS-aFei on 16/10/5.
//  Copyright © 2016年 iOS-aFei. All rights reserved.
//

#import "WFQuickStartView.h"
#import "Masonry.h"

@interface WFQuickStartView ()

@property (nonatomic, strong) NSMutableArray *selectBtnArray;
@property (nonatomic, assign) CGPoint         fingerPoint;

@end

@implementation WFQuickStartView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kMainColor;
        [self setupViews];
    }
    return self;
}
- (void)setupViews {
    WS(ws);
    for (int i = 0; i < 9; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:@"normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"select"] forState:UIControlStateSelected];
        [button setTitle:[NSString stringWithFormat:@"%d",i+1] forState:UIControlStateNormal];
        button.userInteractionEnabled = NO;
        button.tag = i + 10;
        [self addSubview:button];
    }
    UIButton *button0 = (UIButton *)[self viewWithTag:10];
    UIButton *button1 = (UIButton *)[self viewWithTag:11];
    UIButton *button2 = (UIButton *)[self viewWithTag:12];
    UIButton *button3 = (UIButton *)[self viewWithTag:13];
    UIButton *button4 = (UIButton *)[self viewWithTag:14];
    UIButton *button5 = (UIButton *)[self viewWithTag:15];
    UIButton *button6 = (UIButton *)[self viewWithTag:16];
    UIButton *button7 = (UIButton *)[self viewWithTag:17];
    UIButton *button8 = (UIButton *)[self viewWithTag:18];
    
    [button6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.mas_bottom).with.offset(-120);
        make.left.equalTo(ws.mas_left).with.offset(60);
        make.width.equalTo(button7.mas_width);
        make.height.equalTo(button6.mas_width);
        
    }];
    [button7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.mas_bottom).with.offset(-120);
        make.left.equalTo(button6.mas_right).with.offset(30);
        make.width.equalTo(button6.mas_width);
        make.height.equalTo(button7.mas_width);
    }];
    [button8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.mas_bottom).with.offset(-120);
        make.left.equalTo(button7.mas_right).with.offset(30);
        make.right.equalTo(ws.mas_right).with.offset(-60);
        make.width.equalTo(button7.mas_width);
        make.height.equalTo(button8.mas_width);
    }];
    [button3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(button6.mas_top).with.offset(-30);
        make.left.equalTo(ws.mas_left).with.offset(60);
        make.width.equalTo(button6.mas_width);
        make.height.equalTo(button6.mas_width);
    }];
    [button4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(button7.mas_top).with.offset(-30);
        make.left.equalTo(button3.mas_right).with.offset(30);
        make.width.equalTo(button6.mas_width);
        make.height.equalTo(button6.mas_width);
    }];
    [button5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(button8.mas_top).with.offset(-30);
        make.left.equalTo(button4.mas_right).with.offset(30);
        make.right.equalTo(ws.mas_right).with.offset(-60);
        make.width.equalTo(button6.mas_width);
        make.height.equalTo(button6.mas_width);
    }];
    [button0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(button3.mas_top).with.offset(-30);
        make.left.equalTo(ws.mas_left).with.offset(60);
        make.width.equalTo(button6.mas_width);
        make.height.equalTo(button6.mas_width);
    }];
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(button4.mas_top).with.offset(-30);
        make.left.equalTo(button0.mas_right).with.offset(30);
        make.width.equalTo(button6.mas_width);
        make.height.equalTo(button6.mas_width);
    }];
    [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(button5.mas_top).with.offset(-30);
        make.left.equalTo(button1.mas_right).with.offset(30);
        make.right.equalTo(ws.mas_right).with.offset(-60);
        make.width.equalTo(button6.mas_width);
        make.height.equalTo(button6.mas_width);
    }];
    
}
-(NSMutableArray *)selectBtnArray{
    if (!_selectBtnArray) {
        _selectBtnArray = [NSMutableArray array];
    }
    return _selectBtnArray;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self changeButtonSelectedStateWith:touches];
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self changeButtonSelectedStateWith:touches];
    self.fingerPoint = [self getCurrentTouchPoint:touches];
    [self setNeedsDisplay];
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSString *string = @"";
    for (UIButton *button in self.selectBtnArray) {
        button.selected = NO;
        string = [string stringByAppendingString:button.titleLabel.text];
    }
    self.touchEnded(string);
    [self.selectBtnArray removeAllObjects];
    [self setNeedsDisplay];
}
-(void)changeButtonSelectedStateWith:(NSSet <UITouch *> *)touches{
    CGPoint point = [self getCurrentTouchPoint:touches];
    UIButton *button = [self getCurrentButton:point];
    if (button&&button.selected == NO) {
        button.selected = YES;
        [self.selectBtnArray addObject:button];
    }
}
-(CGPoint)getCurrentTouchPoint:(NSSet <UITouch *> *)touches{
    UITouch *touch = touches.anyObject;
    return [touch locationInView:self];
}
-(UIButton *)getCurrentButton:(CGPoint)point{
    for (UIButton *button in self.subviews) {
        if (CGRectContainsPoint(button.frame, point)) {
            return button;
        }
    }
    return nil;
}
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (self.selectBtnArray.count) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        for (int i = 0; i < self.selectBtnArray.count; i ++) {
            UIButton *button = self.selectBtnArray[i];
            if (i == 0) {
                [path moveToPoint:button.center];
            }else{
                [path addLineToPoint:button.center];
            }
        }
        [path addLineToPoint:self.fingerPoint];
        path.lineWidth = 6;
        [[UIColor whiteColor] set];
        path.lineJoinStyle = kCGLineCapRound;
        [path stroke];
    }
}


@end
