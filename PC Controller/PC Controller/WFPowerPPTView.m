//
//  WFPowerPPTView.m
//  PC Controller
//
//  Created by iOS-aFei on 16/9/15.
//  Copyright © 2016年 iOS-aFei. All rights reserved.
//

#import "WFPowerPPTView.h"

@interface WFPowerPPTView () <UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSArray *_tittleArray;
    CGRect  _frame;
}

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation WFPowerPPTView 

- (instancetype)initWithFrame:(CGRect)frame tittle:(NSArray<NSString *> *)tittleArray {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kMainColor;
        _tittleArray         = tittleArray;
        _frame               = frame;
        [self addSubViewsWithFrame:frame tittle:tittleArray];
    }
    return self;
}
- (void)addSubViewsWithFrame:(CGRect)frame tittle:(NSArray<NSString *> *)tittleArray {
    UIButton *removeButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    [removeButton setImage:[UIImage imageNamed:@"remove"]
                   forState:UIControlStateNormal];
    removeButton.frame = CGRectMake(CGRectGetWidth(_frame) - 40, 0, 40, 40);
    [removeButton addTarget:self action:@selector(disapperAnimation) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:removeButton];
    
    UICollectionViewFlowLayout *flowLayout =\
    [[UICollectionViewFlowLayout alloc] init];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, CGRectGetWidth(frame), CGRectGetHeight(frame) - 40)
                                         collectionViewLayout:flowLayout];
    _collectionView.scrollEnabled   = NO;
    _collectionView.delegate        = self;
    _collectionView.dataSource      = self;
    _collectionView.backgroundColor = kMainColor;
    _collectionView.showsVerticalScrollIndicator = NO;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"PowerCollectionViewCell"];

    [self addSubview:_collectionView];
}
- (void)apperAnimation {
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(101, 0, CGRectGetWidth(_frame), CGRectGetHeight(_frame));
    }];
}
- (void)disapperAnimation {
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = _frame;
    }];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _tittleArray.count;
};

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (CGRectGetWidth(_frame) - 40) / 4;

    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PowerCollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = kMainColor;

    UIImageView *myImageView = [[UIImageView alloc] initWithFrame:CGRectMake((width - 40)/2, 0, 40, 40)];
    myImageView.image = [UIImage imageNamed:_tittleArray[indexPath.row]];
    [cell.contentView addSubview:myImageView];
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, width, 30)];
    textLabel.text   = _tittleArray[indexPath.row];
    textLabel.font   = [UIFont systemFontOfSize:14];
    textLabel.textColor     = [UIColor blackColor];
    textLabel.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:textLabel];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (CGRectGetWidth(_frame) - 40) / 4;
    return CGSizeMake(width, 80);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld", (long)indexPath.row);
}

@end
