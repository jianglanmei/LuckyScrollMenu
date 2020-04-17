//
//  MyMenuView.m
//  MyMenu
//
//  Created by heishaLucky on 2020/4/10.
//  Copyright © 2020 YZ_Yang. All rights reserved.
//

#import "MyMenuView.h"

const float interval = 20;
const float content_interval = 5;

@interface MyMenuView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, weak) id<MyMenuViewDelegate>delegate;
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) UIButton *last_button;
@property (nonatomic, strong) UIView *last_lineView;

@end

@implementation MyMenuView

- (instancetype)initWithFrame:(CGRect)frame titleArr:(NSArray<NSString *> *)titleArr delegate:(nonnull id<MyMenuViewDelegate>)delegate
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.scrollView];
        self.titleArr = titleArr;
        self.delegate = delegate;
    }
    return self;
}
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _scrollView.scrollEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (void)setTitleArr:(NSArray *)titleArr {
    _titleArr = titleArr;
    float totalWidth = 0;
    for (int i = 0; i < titleArr.count; i++) {
        NSString *title = titleArr[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:title forState:UIControlStateNormal];
        btn.tag = 100 + i;
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.scrollView addSubview:btn];
        CGSize size = [self getCenterStringHeight:title maxWidth:200 font:16];
        btn.frame = CGRectMake(totalWidth, 0, size.width, self.frame.size.height);
        totalWidth = totalWidth + size.width + interval;
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(btn.frame) + 5, CGRectGetHeight(btn.frame) - content_interval - 1, size.width, 3)];
        view.tag = 1000 + i;
        view.hidden = YES;
        view.backgroundColor = [UIColor whiteColor];
        [self.scrollView addSubview:view];
        if (i == 0) {
            view.hidden = NO;
            btn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
            self.last_button = btn;
            self.last_lineView = view;
        }
    }
    self.scrollView.contentSize = CGSizeMake(totalWidth, self.frame.size.height);
}

- (void)resetFontNormal:(UIButton *)button viewHidden:(UIView *)view
{
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    view.hidden = YES;
}

- (void)resetFontSelect:(UIButton *)button viewHidden:(UIView *)view
{
    button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    view.hidden = NO;
}

- (void)btnClick:(UIButton *)button
{
    NSInteger tag = button.tag - 100;
    UIView *lineView = [self.scrollView viewWithTag:1000 + tag];
    if (tag + 100 == self.last_button.tag) {
        return;
    }
    [self resetFontNormal:self.last_button viewHidden:self.last_lineView];
    [self resetFontSelect:button viewHidden:lineView];
    self.last_button = button;
    self.last_lineView = lineView;
    
    CGFloat x = CGRectGetMinX(button.frame);
    if (self.scrollView.contentSize.width - x >= self.frame.size.width - interval) {
        if (self.scrollView.contentSize.width - x < self.frame.size.width) {
            [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentSize.width - self.frame.size.width, 0) animated:YES];
        } else{
            [self.scrollView setContentOffset:CGPointMake(x, 0) animated:YES];
        }
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectItem:)]) {
        [self.delegate selectItem:tag];
    }
}

#pragma mark - 获取文本的大小
- (CGSize)getCenterStringHeight:(NSString *)strText maxWidth:(CGFloat)maxWidth font:(CGFloat)font
{
    return [strText boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT)
                                 options:NSStringDrawingUsesLineFragmentOrigin
                              attributes:@{NSFontAttributeName : [UIFont               systemFontOfSize:font]}
                                 context:nil].size;
}

#pragma mark - 自动滑动菜单
- (void)shouldScrollMenuView:(NSInteger)index
{
    UIButton *btn = [self.scrollView viewWithTag:index + 100];
    [self btnClick:btn];
}

@end
