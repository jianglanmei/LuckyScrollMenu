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
#define HEXCOLOR(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:1]

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
    
//    self.view.backgroundColor = [UIColor blueColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(50, 200, kWIDTH - 100, 40);
//    button.backgroundColor = [UIColor blackColor];
    [button setTitle:@"渐变按钮" forState:UIControlStateNormal];
    CAGradientLayer *gradientLayer = [self setGradualChangingColor:button fromColor:HEXCOLOR(0x3385FF) toColor:HEXCOLOR(0x71ADFF)];
    [button.layer addSublayer:gradientLayer];
    [self.view addSubview:button];
    
//    CGFloat height = kHEIGHT - CGRectGetMaxY(self.menuView.frame) - bottom;
//    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.menuView.frame), kWIDTH, height)];
//    self.scrollView.contentSize = CGSizeMake(kWIDTH * titleArr.count, height);
//    self.scrollView.pagingEnabled = YES;
//    self.scrollView.delegate = self;
//    [self.view addSubview:self.scrollView];
//
//    for (int i = 0; i < titleArr.count; i++) {
//        FirstViewController *vc = [[FirstViewController alloc] init];
//        [self addChildViewController:vc];
//        vc.menuType = i;
//        vc.height = height;
//        [self.scrollView addSubview:vc.view];
//        vc.view.backgroundColor = [UIColor redColor];
//        vc.view.frame = CGRectMake(i * kWIDTH, 0, kWIDTH, self.scrollView.contentSize.height);
//    }
}

//绘制渐变色颜色的方法
- (CAGradientLayer *)setGradualChangingColor:(UIView *)view fromColor:(UIColor *)fromHexColorStr toColor:(UIColor *)toHexColorStr{
    
    //    CAGradientLayer类对其绘制渐变背景颜色、填充层的形状(包括圆角)
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = view.bounds;
    
    //  创建渐变色数组，需要转换为CGColor颜色 （因为这个按钮有三段变色，所以有三个元素）
    gradientLayer.colors = @[(__bridge id)fromHexColorStr.CGColor,(__bridge id)toHexColorStr.CGColor,
                             (__bridge id)fromHexColorStr.CGColor];
    
    
    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    gradientLayer.startPoint = CGPointMake(0.5, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    
    //  设置颜色变化点，取值范围 0.0~1.0 （所以变化点有三个）
    gradientLayer.locations = @[@0,@0.5,@1];
    
    return gradientLayer;
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
