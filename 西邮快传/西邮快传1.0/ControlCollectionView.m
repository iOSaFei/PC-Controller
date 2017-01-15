//
//  ControlCollectionView.m
//  西邮快传1.0
//
//  Created by iOS 阿飞 on 16/1/26.
//  Copyright © 2016年 iOS 阿飞. All rights reserved.
//

#import "ControlCollectionView.h"

@implementation ControlCollectionView

- (id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout withArray:(NSArray *)array {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor whiteColor];
        self.array = array;
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"myCollectionViewCell"];
        [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *a = [_array objectAtIndex:section];
    return a.count;
};
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _array.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat cellWidth = (kWindowWidth - 50)/4;
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myCollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:32/255.0 green:172/255.0 blue:225/255.0 alpha:0.6];
    cell.layer.cornerRadius = (kWindowWidth - 50)/16;
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (cellWidth - 30)/2, cellWidth, 30)];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.tag = 100;
    textLabel.textColor = [UIColor whiteColor];
    [cell.contentView addSubview:textLabel];
    
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:100] ;
    label.text = _array[indexPath.section][indexPath.row];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((kWindowWidth - 50)/4, (kWindowWidth - 50)/4);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"forIndexPath:indexPath];
    UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kWindowWidth, 30)];
    headLabel.tag = 101;
    headLabel.font = [UIFont systemFontOfSize:20];
    [headView addSubview:headLabel];
    UILabel *label = (UILabel *)[headView viewWithTag:101];
    label.textColor = [UIColor colorWithRed:32/255.0 green:172/255.0 blue:225/255.0 alpha:1.0];
    switch (indexPath.section) {
        case 0:
            label.text = @"电源控制";
            break;
        case 1:
            label.text = @"屏幕控制";
            break;
        case 2:
            label.text = @"音量控制";
            break;
        default:
            label.text = @"遥控ppt";
            break;
    }
    return headView;
}
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.passDeleate passSection:(NSInteger)indexPath.section withRow:(NSInteger)indexPath.row];
}

@end
