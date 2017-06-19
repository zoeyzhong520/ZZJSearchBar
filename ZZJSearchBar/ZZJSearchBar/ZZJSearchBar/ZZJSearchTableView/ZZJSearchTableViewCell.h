//
//  ZZJSearchTableViewCell.h
//  UISearchControllerDemo
//
//  Created by JOE on 2017/6/15.
//  Copyright © 2017年 ZZJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Macro.h"

@interface ZZJSearchTableViewCell : UITableViewCell


- (void)configCellWith:(NSString *)text;

+ (CGFloat)heightForCell;

@end
