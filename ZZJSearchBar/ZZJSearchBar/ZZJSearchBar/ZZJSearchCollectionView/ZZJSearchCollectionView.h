//
//  ZZJSearchCollectionView.h
//  UISearchControllerDemo
//
//  Created by JOE on 2017/6/19.
//  Copyright © 2017年 ZZJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZJSearchCollectionViewCell.h"
#import "ZZJSearchCollectionHeaderView.h"

@interface ZZJSearchCollectionView : UIView

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSArray *dataArray;//数据源

@end
