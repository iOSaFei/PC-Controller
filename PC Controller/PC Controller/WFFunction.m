//
//  WFFunction.m
//  PC Controller
//
//  Created by iOS-aFei on 16/9/1.
//  Copyright © 2016年 iOS-aFei. All rights reserved.
//

#import "WFFunction.h"

@interface WFFunction ()

@property (nonatomic, strong) NSArray *textArray;

@end

@implementation WFFunction

- (id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.delegate        = self;
        self.dataSource      = self;
        self.backgroundColor = [UIColor whiteColor];
        self.showsVerticalScrollIndicator = NO;
        self.scrollEnabled   = YES;
        _textArray           = @[ @"语音", @"快速启动", @"PPT", @"截屏", @"远程桌面", @"亮度&音量", @"电源", @"聊天"];
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _textArray.count;
};

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    UIImageView *myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 30)];
    myImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    [cell.contentView addSubview:myImageView];
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 30)];
    textLabel.text   = _textArray[indexPath.row];
    textLabel.center = myImageView.center;
    textLabel.font   = [UIFont systemFontOfSize:14];
    textLabel.textColor     = [UIColor whiteColor];
    textLabel.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:textLabel];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(95, 50);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [_functionEventDelegate voiceFunction];
            break;
        case 1:
            [_functionEventDelegate quickStart];
            break;
        case 2:
            [_functionEventDelegate PPTFunction];
            break;
        case 3:
            [_functionEventDelegate shotScreen];
            break;
        case 4:
            [_functionEventDelegate distanceDestop];
            break;
        case 5:
            [_functionEventDelegate lightnessAndVolume];
            break;
        case 6:
            [_functionEventDelegate powerFunction];
            break;
        case 7:
            [_functionEventDelegate chatFunction];
            break;
        default:
            break;
    }
}
@end
