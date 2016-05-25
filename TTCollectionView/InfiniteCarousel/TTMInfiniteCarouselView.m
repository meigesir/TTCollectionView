//
//  TTMInfiniteCarouselView.m
//  TTCollectionView
//
//  Created by phenix on 5/25/16.
//  Copyright © 2016 phenix. All rights reserved.
//

#import "TTMInfiniteCarouselView.h"
#import "TTMInfiniteCarouselItem.h"

#define PAGE_CONTROL_RIGHT_SPACE    8
#define PAGE_CONTROL_BOTTOM_SPACE   8
#define PAGE_CONTROL_HEIGHT         5

#define kCarouselWidth CGRectGetWidth(self.frame)
#define kCarouselHeight CGRectGetHeight(self.frame)

@interface TTMInfiniteCarouselView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSArray *handledArray;// 为了无限轮播，处理之后的数据

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) NSTimer *repeatTimer;

@property (nonatomic, assign) NSInteger currentPage; // 对应handledArray索引

@end

@implementation TTMInfiniteCarouselView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self p_loadSubViews];
        [self configure];
    }
    return self;
}

#pragma mark - Method

- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor
{
    self.pageControl.pageIndicatorTintColor = pageIndicatorTintColor;
}

- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor
{
    self.pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
}

- (void)updateWithDataArray:(NSArray *)array
{
    NSInteger count = array.count;
    
    if (count == 0) {
        return;
    }
    
    self.dataArray = array;
    
    self.pageControl.numberOfPages = count;
    
    [self p_updatePageControlFrame];
    
    if (count > 1) {
        self.pageControl.hidden = NO;
        /** 做无限滚动效果处理:第一个前面放数组里面最后一个数据，最后一个后面放数组里面第一个数据，切换之后，迅速设置setContentOffset，从而无限滚动 **/
        NSMutableArray *mutArray = [array mutableCopy];
        [mutArray insertObject:[array lastObject] atIndex:0];
        [mutArray addObject:[array firstObject]];
        self.handledArray = [mutArray copy];
        [self.collectionView setContentOffset:CGPointMake(kCarouselWidth, 0) animated:NO];
        self.currentPage = 1;
    } else {
        self.pageControl.hidden = YES;
        [self.collectionView setContentOffset:CGPointZero animated:NO];
        self.handledArray = [array copy];
    }
}

- (void)reloadData
{
    if (self.dataArray.count == 0) {
        return;
    }
    
    [self.collectionView reloadData];
}

#pragma mark - Timer

- (void)startTimer
{
    [self stopTimer];
    self.repeatTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(handleTimer) userInfo:nil repeats:YES];
}

- (void)stopTimer
{
    if (self.repeatTimer) {
        [self.repeatTimer invalidate];
        self.repeatTimer = nil;
    }
}

- (void)handleTimer
{
    if (self.handledArray.count > 1) {
        if (self.pageControl.currentPage == self.pageControl.numberOfPages - 1) {
            self.pageControl.currentPage = 0;
        } else {
            self.pageControl.currentPage++;
        }
        
        if (self.currentPage >= self.handledArray.count - 2) {
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:++self.currentPage inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
            self.currentPage = 1;
        } else {
            if (self.currentPage == 1) {
                [self.collectionView setContentOffset:CGPointMake(kCarouselWidth, 0) animated:NO];
            }
            
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:++self.currentPage inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
        }
    } else {
        [self stopTimer];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.handledArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TTMInfiniteCarouselItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TTMInfiniteCarouselItem class]) forIndexPath:indexPath];
    
    [self configureCell:cell forItemAtIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(TTMInfiniteCarouselItem *)cell
   forItemAtIndexPath:(NSIndexPath *)indexPath
{
    [cell updateWithDict:self.handledArray[indexPath.row]];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kCarouselWidth, kCarouselHeight);
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    /*计算应该显示第几个点(vasualPage):先计算出实际上是第几页:realPage*/
    CGFloat pageWidth = kCarouselWidth;
    NSInteger realPage = floor((scrollView.contentOffset.x) / pageWidth + 0.5);
    
    if (self.dataArray.count > 1) {
        if (realPage == 0) {
            // 第一个，其实显示的是原有数组最后一个元素，然后设置currentPage和默默地跳转到实际的位置
            self.pageControl.currentPage = self.dataArray.count - 1;
            [self.collectionView setContentOffset:CGPointMake(self.dataArray.count * pageWidth, 0) animated:NO];
            self.currentPage = self.dataArray.count;
        } else if (realPage == self.handledArray.count - 1) {
            // 最后一个，其实显示的是原有数组的第一个元素，然后设置currentPage和默默地跳转到实际的位置
            self.pageControl.currentPage = 0;
            [scrollView setContentOffset:CGPointMake(pageWidth, 0) animated:NO];
            self.currentPage = 1;
        } else {
            self.pageControl.currentPage = realPage - 1;
            self.currentPage = realPage;
        }
    } else {
        self.pageControl.currentPage = realPage;
        self.currentPage = realPage;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}

#pragma mark - Private

- (void)configure
{
    self.collectionView.backgroundColor = [UIColor whiteColor];
}

- (void)p_loadSubViews
{
    [self addSubview:self.collectionView];
    [self addSubview:self.pageControl];
}

- (void)p_updatePageControlFrame
{
    CGSize size = [self.pageControl sizeForNumberOfPages:self.pageControl.numberOfPages];
    
    CGFloat bottomMargin = self.bottomMarginOfPageControl?:PAGE_CONTROL_BOTTOM_SPACE;
    CGFloat height = self.heightOfPageControl?:PAGE_CONTROL_HEIGHT;
    
    switch (self.pageControlAlignment) {
        case TTMInfiniteCarouselViewPageControlAlignmentLeft:
            self.pageControl.frame = (CGRect){self.leftMarginOfPageControl?:PAGE_CONTROL_RIGHT_SPACE, kCarouselHeight - height - bottomMargin, size.width, height};
            break;
        case TTMInfiniteCarouselViewPageControlAlignmentCenter:
            self.pageControl.frame = (CGRect){(kCarouselWidth - size.width)/2, kCarouselHeight - height - bottomMargin, size.width, height};
            break;
        case TTMInfiniteCarouselViewPageControlAlignmentRight:
            self.pageControl.frame = (CGRect){kCarouselWidth - size.width - (self.rightMarginOfPageControl?:PAGE_CONTROL_RIGHT_SPACE), kCarouselHeight - height - bottomMargin, size.width, height};
        default:
            break;
    }
    
    [self bringSubviewToFront:self.pageControl];
}

#pragma mark - Accessors

- (UICollectionView *)collectionView {
    if(_collectionView == nil) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:self.flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.scrollsToTop = NO;
        
        self.flowLayout.minimumLineSpacing = 0;
        
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([TTMInfiniteCarouselItem class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([TTMInfiniteCarouselItem class])];
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout {
	if(_flowLayout == nil) {
		_flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
	}
	return _flowLayout;
}

- (UIPageControl *)pageControl {
	if(_pageControl == nil) {
		_pageControl = [[UIPageControl alloc] init];
        _pageControl.enabled = NO;
        _pageControl.currentPage = 0;
        _pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:0.95 alpha:0.95];
        _pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:0.94 green:0.44 blue:0.48 alpha:1];
        
	}
	return _pageControl;
}

@end
