//
//  ZZJSearchCollectionHeaderView.m
//  ZZJSearchBar
//
//  Created by JOE on 2017/6/19.
//  Copyright © 2017年 ZZJ. All rights reserved.
//

#import "ZZJSearchCollectionHeaderView.h"

@implementation ZZJSearchCollectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.frame = frame;
        [self createHeaderView];
    }
    return self;
}

- (void)createHeaderView {
    self.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:self.frame];
    titleLabel.text = @"历史记录";
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:30];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:titleLabel];
}

@end
