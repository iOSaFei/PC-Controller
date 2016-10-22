//
//  WFTextfield.m
//  PC Controller
//
//  Created by iOS-aFei on 16/9/13.
//  Copyright © 2016年 iOS-aFei. All rights reserved.
//

#import "WFTextfield.h"

@interface WFTextfield () <UITextFieldDelegate>

@property (nonatomic, strong) UIView      *backView;
@property (nonatomic, strong) UIButton    *removeButton;
@property (nonatomic, strong) UITextField *textField;

@end

@implementation WFTextfield

#pragma mark - override
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addTapGesture];
        [self addSubviews];
    }
    return self;
}

#pragma mark - view
- (void)addSubviews {
    _backView = [[UIView alloc] initWithFrame:CGRectMake(10, kWindowHeight/5, kWindowWidth - 20, 120)];
    _backView.backgroundColor    = kMainColor;
    _backView.layer.cornerRadius = 10;
    [self addSubview:_backView];
    
    _removeButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    [_removeButton setImage:[UIImage imageNamed:@"remove"]
                   forState:UIControlStateNormal];
    _removeButton.frame = CGRectMake(kWindowWidth - 50, kWindowHeight/5, 40, 40);
    [_removeButton addTarget:self action:@selector(removeSelf) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_removeButton];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(20, kWindowHeight/5 + 40, kWindowWidth - 40, 40)];
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.keyboardType    = UIKeyboardTypeNumbersAndPunctuation;
    _textField.delegate        = self;
    _textField.placeholder     = @"请输入电脑端显示的IP";
    _textField.returnKeyType   = UIReturnKeyJoin;
    _textField.rightViewMode   = UITextFieldViewModeAlways;
    [self addSubview:_textField];
    [_textField becomeFirstResponder];
}
- (void)addTapGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeSelf)];
    [self addGestureRecognizer:tap];
}

#pragma mark - buttonEvent
- (void)removeSelf {
    [_textField resignFirstResponder];
    self.frame = CGRectMake(0, -kWindowHeight, kWindowWidth, kWindowHeight);
}
#pragma mark - delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    self.inputFinished(textField.text);
    return YES;
}
@end
