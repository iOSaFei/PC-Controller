//
//  ControlCollectionView.h
//  西邮快传1.0
//
//  Created by iOS 阿飞 on 16/1/26.
//  Copyright © 2016年 iOS 阿飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CollectionViewDeleate <NSObject>
@required
- (void)passSection:(NSInteger)section withRow:(NSInteger)row;
@end

@interface ControlCollectionView : UICollectionView<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic, weak)id<CollectionViewDeleate>passDeleate;
@property(nonatomic ,strong) NSArray *array;
- (id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout withArray:(NSArray *)array;

@end
