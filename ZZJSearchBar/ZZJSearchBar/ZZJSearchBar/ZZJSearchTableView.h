//
//  ZZJSearchTableView.h
//  UISearchControllerDemo
//
//  Created by JOE on 2017/6/19.
//  Copyright © 2017年 ZZJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZJSearchTableViewCell.h"

@interface ZZJSearchTableView : UIView

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *dataArray;//数据源

@end
