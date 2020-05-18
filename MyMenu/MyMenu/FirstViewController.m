//
//  FirstViewController.m
//  MyMenu
//
//  Created by heishaLucky on 2020/4/10.
//  Copyright © 2020 YZ_Yang. All rights reserved.
//

#import "FirstViewController.h"
#import "HeaderView.h"
@interface FirstViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) HeaderView *headerView;
@end

@implementation FirstViewController

+ (FirstViewController *)shareInstance
{
    static FirstViewController *vc = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        vc = [[FirstViewController alloc] init];
    });
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"index = %ld", self.menuType);
    
    self.view.backgroundColor = [UIColor greenColor];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
//    [self.view addGestureRecognizer:tap];
    
    [self.view addSubview:self.tableView];
}

- (HeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, 320)];
    }
    return _headerView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, self.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        if (self.menuType == MenuTypeAll) {
            _tableView.tableHeaderView = self.headerView;
        }
    }
    return _tableView;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"这是第 %ld 个界面", self.menuType];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tapClick {
    NSLog(@"点击了第一个控制器");
}


@end

