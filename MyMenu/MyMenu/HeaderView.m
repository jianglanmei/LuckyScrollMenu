//
//  HeaderView.m
//  MyMenu
//
//  Created by heishaLucky on 2020/4/17.
//  Copyright © 2020 YZ_Yang. All rights reserved.
//

#import "HeaderView.h"
#import "LJSecondView.h"

const int pageCount = 10;

@interface HeaderView()


@property (nonatomic, strong) NSArray<NSString *> *titleArr;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) LJSecondView *secondView;

@end

@implementation HeaderView

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.frame.size.height / 2, kWIDTH, self.frame.size.height / 2)];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.contentSize = CGSizeMake(kWIDTH * 2, self.frame.size.height / 2);
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (LJSecondView *)secondView {
    if (!_secondView) {
        _secondView = [[LJSecondView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height / 2)];
        NSMutableArray *images = [[NSMutableArray alloc]init];
        for (NSInteger i = 1; i <= 6; ++i) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"cycle_image%ld",(long)i]];
            [images addObject:image];
        }
        _secondView.imageArr = images;
    }
    return _secondView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    [self addSubview:self.secondView];
    [self addSubview:self.scrollView];

    self.titleArr = @[@"拼多多赚", @"京东赚", @"淘宝赚", @"唯品会赚", @"发朋友圈", @"天猫超市", @"天猫国际", @"抢免单", @"云发单", @"邀请粉丝", @"充值特权", @"饿了么", @"猫超包邮", @"限时抢购", @"排行榜单", @"推广群发"];
    CGFloat width = kWIDTH / 5;
    CGFloat height = self.frame.size.height / 2 / 2;
    for (int i = 0; i < self.titleArr.count; i++) {
        NSInteger currentPage = i / 10;
        NSInteger index = i / 5;
        NSInteger page = i % 5;
        UIView *bgView = [[UIView alloc] init];
        if (i < 10) {
            bgView.frame = CGRectMake(page * width, index * height, width, height);
        } else {
            index = (i - 10 * currentPage) / 5;
            bgView.frame = CGRectMake(kWIDTH + page * width, index * height, width, height);
        }
        [self.scrollView addSubview:bgView];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((CGRectGetWidth(bgView.frame) - 40) / 2, 10, 40, 40)];
        imageView.image = [UIImage imageNamed:@"chat_card"];
        [bgView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxX(imageView.frame), CGRectGetWidth(bgView.frame), 12)];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:12];
        label.text = self.titleArr[i];
        label.textAlignment = NSTextAlignmentCenter;
        [bgView addSubview:label];
    }
    
}

@end

