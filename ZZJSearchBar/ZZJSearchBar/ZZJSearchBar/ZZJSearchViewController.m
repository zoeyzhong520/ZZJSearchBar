//
//  ZZJSearchViewController.m
//  ZZJSearchBar
//
//  Created by JOE on 2017/6/19.
//  Copyright © 2017年 ZZJ. All rights reserved.
//

#import "ZZJSearchViewController.h"
#import "ZZJSearchCollectionView.h"
#import "ZZJSearchTableView.h"

@interface ZZJSearchViewController ()<UISearchBarDelegate>

@property (nonatomic,strong) NSArray *dataArray;//存放搜索结果
@property (nonatomic,strong) NSArray *historyArray;//存放搜索记录
@property (nonatomic,strong) UISearchBar *searchBar;

@property (nonatomic,strong) ZZJSearchCollectionView *searchCollectionView;
@property (nonatomic,strong) ZZJSearchTableView *searchTableView;
@property (nonatomic,copy) NSString *inputText;//输入的文字

@end

@implementation ZZJSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createPage];
    [self handleClosure];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.searchTableView.hidden = YES;
    self.searchCollectionView.hidden = NO;
    [self.searchBar becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createPage {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.searchBar.placeholder = @"搜索书籍／绘本／古诗";
    self.searchBar.keyboardType = UIKeyboardTypeDefault;
    self.searchBar.delegate = self;//设置代理
}

- (void)handleClosure {
    //处理闭包
    __weak typeof(self) WeakSelf = self;
    self.searchTableView.JumpClosure = ^(NSString *searchText) {
        [WeakSelf saveSearchTextWith:searchText];
        NSLog(@"%@",searchText);
    };
}

#pragma mark - Handle Data
- (void)getData {
    self.searchTableView.dataArray = @[@"sfase",@"ada",@"s",@"sfds",@"rgrg",@"vfbf",@"afraef"];
    [self.searchTableView.tableView reloadData];
}

- (void)reloadHistoryData {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *array = [NSMutableArray arrayWithArray:[userDefaults  objectForKey:@"myHistoryArray"]];
    self.historyArray = [[array reverseObjectEnumerator] allObjects];
    
    self.searchCollectionView.dataArray = self.historyArray;
    [self.searchCollectionView.collectionView reloadData];
    NSLog(@"%@",self.searchCollectionView.dataArray);
}

#pragma mark - UISearchBarDelegate
// 当开始编辑,即使是空,也触发
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    self.searchBar.showsCancelButton = YES;
    self.searchTableView.hidden = YES;
    self.searchCollectionView.hidden = YES;
}

// 当搜索框的内容改变,即使是空
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    self.inputText = self.searchBar.text;
    self.searchTableView.hidden = NO;
    self.searchCollectionView.hidden = YES;
    //进行数据请求
    NSLog(@"input: %@",self.inputText);
    [self getData];
}

// 点击键盘的search按钮,再请求一遍数据
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [self saveSearchTextWith:searchBar.text];
    
    //请求数据
    [self getData];
    [self.searchBar resignFirstResponder];
}

// 取消按钮触发方法
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    self.searchBar.text = nil;
    self.searchTableView.hidden = YES;
    self.searchCollectionView.hidden = NO;
    [self reloadHistoryData];
    
    //回收键盘
    [self.searchBar resignFirstResponder];
}

#pragma mark - 搜索历史
- (void)saveSearchTextWith:(NSString *)searchText {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    NSArray *myHistoryArray = [[NSArray alloc] initWithArray:[userDefaults objectForKey:@"myHistoryArray"]];
    
    // NSArray --> NSMutableArray
    NSMutableArray *searchTextArray = [NSMutableArray array];
    searchTextArray = [myHistoryArray mutableCopy];
    
    BOOL isEqualTo1 = NO;
    BOOL isEqualTo2 = NO;
    
    if (searchTextArray.count > 0) {
        isEqualTo2 = YES;
        //判断搜索内容是否存在，存在的话放到数组最后一位，不存在的话添加
        for (NSString *str in myHistoryArray) {
            if ([searchText isEqualToString:str]) {
                //获取指定对象的索引
                NSUInteger index = [myHistoryArray indexOfObject:searchText];
                [searchTextArray removeObjectAtIndex:index];
                [searchTextArray addObject:searchText];
                isEqualTo1 = YES;
                break;
            }
        }
    }
    
    if (!isEqualTo1 || !isEqualTo2) {
        [searchTextArray addObject:searchText];
    }
    
//    if (searchTextArray.count > 6) {
//        [searchTextArray removeObjectAtIndex:0];
//    }
    
    //将上述数据全部存储到NSUserDefaults中
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:searchTextArray forKey:@"myHistoryArray"];
}

#pragma mark - 清空搜索历史
- (void)clearHistory:(UIButton *)button {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *myHistoryArray = [userDefaults arrayForKey:@"myHistoryArray"];
    NSMutableArray *searchTextArray = [myHistoryArray mutableCopy];
    [searchTextArray removeAllObjects];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:searchTextArray forKey:@"myHistoryArray"];
    
    
    
    NSLog(@"清除历史记录");
}

#pragma mark - lazy
- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSArray alloc] init];
    }
    return _dataArray;
}

- (NSArray *)historyArray {
    if (!_historyArray) {
        _historyArray = [[NSArray alloc] init];
    }
    return _historyArray;
}

- (ZZJSearchCollectionView *)searchCollectionView {
    if (!_searchCollectionView) {
        _searchCollectionView = [[ZZJSearchCollectionView alloc] initWithFrame:CGRectMake(0, 120, screenWidth, screenHeight-120)];
        [self.view addSubview:_searchCollectionView];
    }
    return _searchCollectionView;
}

- (ZZJSearchTableView *)searchTableView {
    if (!_searchTableView) {
        _searchTableView = [[ZZJSearchTableView alloc] initWithFrame:CGRectMake(0, 120, screenWidth, screenHeight-120)];
        [self.view addSubview:_searchTableView];
    }
    return _searchTableView;
}

- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 70, screenWidth, 35)];
        [self.view addSubview:_searchBar];
    }
    return _searchBar;
}

- (NSString *)inputText {
    if (!_inputText) {
        _inputText = [[NSString alloc] init];
    }
    return _inputText;
}

@end
