//
//  ZZJSearchTableView.m
//  UISearchControllerDemo
//
//  Created by JOE on 2017/6/19.
//  Copyright © 2017年 ZZJ. All rights reserved.
//

#import "ZZJSearchTableView.h"

@interface ZZJSearchTableView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ZZJSearchTableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.frame = frame;
    }
    return self;
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZZJSearchTableViewCell *cell = [[ZZJSearchTableViewCell alloc] init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell configCellWith:self.dataArray[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ZZJSearchTableViewCell heightForCell];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了第%ld行",indexPath.row);
}

#pragma mark - lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        [self addSubview:_tableView];
    }
    return _tableView;
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSArray alloc] init];
    }
    return _dataArray;
}

@end
