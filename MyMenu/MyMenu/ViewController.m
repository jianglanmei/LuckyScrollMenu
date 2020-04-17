//
//  ViewController.m
//  MyMenu
//
//  Created by heishaLucky on 2020/4/10.
//  Copyright © 2020 YZ_Yang. All rights reserved.
//

#import "ViewController.h"
#import "MyMenuView.h"
#import "FirstViewController.h"

@interface ViewController ()<MyMenuViewDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) MyMenuView *menuView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *arr = UIApplication.sharedApplication.windows;
    UIWindow *window = arr[0];
    CGFloat top = window.safeAreaInsets.top;
    CGFloat bottom = window.safeAreaInsets.bottom;
    NSLog(@"%f", top);
    NSArray *titleArr = @[@"全部", @"女装", @"男装", @"内衣", @"母婴", @"美妆", @"居家", @"鞋包配饰", @"食品", @"数码", @"户外"];
    self.menuView = [[MyMenuView alloc] initWithFrame:CGRectMake(0, top, self.view.frame.size.width, 40) titleArr:titleArr delegate:self];
    self.menuView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.menuView];
    
    CGFloat height = kHEIGHT - CGRectGetMaxY(self.menuView.frame) - bottom;
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.menuView.frame), kWIDTH, height)];
    self.scrollView.contentSize = CGSizeMake(kWIDTH * titleArr.count, height);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    
    for (int i = 0; i < titleArr.count; i++) {
        FirstViewController *vc = [[FirstViewController alloc] init];
        [self addChildViewController:vc];
        vc.menuType = i;
        vc.height = height;
        [self.scrollView addSubview:vc.view];
        vc.view.backgroundColor = [UIColor redColor];
        vc.view.frame = CGRectMake(i * kWIDTH, 0, kWIDTH, self.scrollView.contentSize.height);
    }
}

#pragma mark - MyMenuViewDelegate
- (void)selectItem:(NSInteger)index
{
    NSLog(@"点击了：%ld", index);
    [self.scrollView setContentOffset:CGPointMake(kWIDTH * index, 0) animated:NO];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / kWIDTH;
    [self.menuView shouldScrollMenuView:index];
}




@end
