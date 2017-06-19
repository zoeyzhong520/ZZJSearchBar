//
//  ZZJSearchCollectionViewCell.m
//  UISearchControllerDemo
//
//  Created by JOE on 2017/6/19.
//  Copyright © 2017年 ZZJ. All rights reserved.
//

#import "ZZJSearchCollectionViewCell.h"

@implementation ZZJSearchCollectionViewCell

- (void)configCellWith:(NSString *)pictureUrl {
    
    self.backgroundColor = [UIColor clearColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.backgroundColor = [UIColor yellowColor];
    [self addSubview:imageView];
}

@end
