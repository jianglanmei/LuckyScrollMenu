//
//  MenuBaseViewController.m
//  MyMenu
//
//  Created by heishaLucky on 2020/4/10.
//  Copyright © 2020 YZ_Yang. All rights reserved.
//

#import "MenuBaseViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

@interface MenuBaseViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation MenuBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.scrollView];
    for (int i = 0; i < self.count; i++) {
        if (i % 2 == 0) {
            FirstViewController *vc = [[FirstViewController alloc] init];
            [self.scrollView addSubview:vc.view];
            [self addChildViewController:vc];
        } else {
            SecondViewController *vc = [[SecondViewController alloc] init];
            [self.scrollView addSubview:vc.view];
            [self addChildViewController:vc];
        }
        
//        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i * self.view.frame.size.width, 10, self.view.frame.size.width, self.viewHeight)];
//        view.tag = 100 + i;
//        [self.scrollView addSubview:view];
//
//
//
//        UIViewController *vc = [[UIViewController alloc] init];
//        [view addSubview:vc.view];
//        [self addChildViewController:vc];
//
//        if (i % 2 == 0) {
//            vc.view.backgroundColor = [UIColor grayColor];
//        } else {
//            vc.view.backgroundColor = [UIColor blueColor];
//        }
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
//        [view addGestureRecognizer:tap];
    }
}

- (void)tapClick:(UITapGestureRecognizer *)tap
{
    NSLog(@"-----  %ld  -----", tap.view.tag);
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _scrollView.contentSize = CGSizeMake(self.view.frame.size.width * self.count, self.view.frame.size.height);
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"---%f---", scrollView.contentOffset.x);
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSLog(@"---%f---", scrollView.contentOffset.x);
}

@end
