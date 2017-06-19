//
//  ZZJSearchCollectionView.m
//  UISearchControllerDemo
//
//  Created by JOE on 2017/6/19.
//  Copyright © 2017年 ZZJ. All rights reserved.
//

#import "ZZJSearchCollectionView.h"

@interface ZZJSearchCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation ZZJSearchCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.frame = frame;
    }
    return self;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"searchCollectionViewCell";
    ZZJSearchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    //防止复用
    for (UIView *view in cell.subviews) {
        [view removeFromSuperview];
    }
    [cell configCellWith:[self.dataArray objectAtIndex:indexPath.row]];
    [cell sizeToFit];
    if (!cell) {
        NSLog(@"无法创建cell！");
    }
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(SW(304), SW(386));
}

//定义header的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击第%ld行",indexPath.row);
}

// 设置headerView和footerView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableView = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        header.backgroundColor = [UIColor clearColor];
        for (UIView *view in header.subviews) {
            [view removeFromSuperview];//防止复用分区头
        }
        reusableView = header;
    }
    
    if (kind == UICollectionElementKindSectionFooter) {
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        reusableView = footer;
    }
    return reusableView;
}

#pragma mark - lazy
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.minimumInteritemSpacing = SW(40);
        flowLayout.minimumLineSpacing = SW(94);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        //注册cell
        [_collectionView registerClass:[ZZJSearchCollectionViewCell class] forCellWithReuseIdentifier:@"searchCollectionViewCell"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView"];
        
        [self addSubview:_collectionView];
    }
    return _collectionView;
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

@end
