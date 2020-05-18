//
//  LJSecondView.m
//  MyMenu
//
//  Created by heishaLucky on 2020/4/18.
//  Copyright © 2020 YZ_Yang. All rights reserved.
//

#import "LJSecondView.h"
#import "LJSecondCell.h"

@interface LJSecondView()<UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation LJSecondView
{
    
    NSArray *colorArr;
}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(kWIDTH, self.bounds.size.height);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, self.bounds.size.height) collectionViewLayout:layout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerNib:[UINib nibWithNibName:@"LJSecondCell" bundle:nil] forCellWithReuseIdentifier:@"LJSecondCell"];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _collectionView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        CGFloat width = 120;
        CGFloat height = 20;
        CGFloat pointX = kWIDTH / 2;
        CGFloat pointY = self.bounds.size.height - height;
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(pointX, pointY, width, height)];
        _pageControl.numberOfPages = _imageArr.count;
        _pageControl.userInteractionEnabled = NO;
        _pageControl.pageIndicatorTintColor = [UIColor lightTextColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    }
    return _pageControl;
}

- (void)setImageArr:(NSArray *)imageArr
{
    _imageArr = imageArr;
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = imageArr.count;
    [self.collectionView reloadData];
    
//    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
//    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    [self setTimers];
}

- (void)setTimers {
    _timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    _timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:2];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    colorArr = @[[UIColor redColor], [UIColor greenColor], [UIColor blueColor], [UIColor yellowColor]];
    [self addSubview:self.collectionView];
    [self addSubview:self.pageControl];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imageArr.count + 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LJSecondCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LJSecondCell" forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:_imageArr[indexPath.row % _imageArr.count]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"row = %ld", indexPath.row);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger page = offsetX / kWIDTH;
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    
    if (page == itemCount - 1) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self scrollViewDidEndDecelerating:self.collectionView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    CGFloat offsetX = scrollView.contentOffset.x;
//    CGFloat page = offsetX / self.bounds.size.width;
//    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
//    if (page == 0) {
//
//        self.pageControl.currentPage = _imageArr.count - 1;
//    } else if (page == itemCount - 1) {
//
//        self.pageControl.currentPage = 0;
//    } else {
//
//        self.pageControl.currentPage = page - 1;
//    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_timer invalidate];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self setTimers];
}

- (void)timerAction:(NSTimer *)timer {
//    NSIndexPath *indexPath = [self.collectionView indexPathsForVisibleItems].lastObject;
//    NSIndexPath *nextPath = [NSIndexPath indexPathForItem:indexPath.row + 1 inSection:indexPath.section];
//    [self.collectionView scrollToItemAtIndexPath:nextPath atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
}
@end
