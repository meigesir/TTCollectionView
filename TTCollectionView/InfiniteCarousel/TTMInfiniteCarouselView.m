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

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UIPageControl *pageControl;

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
    self.dataArray = array;
    
    self.pageControl.numberOfPages = self.dataArray.count;
    
    [self p_updatePageControlFrame];
}

- (void)reloadData
{
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
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
    [cell updateWithDict:self.dataArray[indexPath.row]];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kCarouselWidth, kCarouselHeight);
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int numberOfPages = (int)self.pageControl.numberOfPages;
    
    if (numberOfPages == 0) {
        return;
    }
    
    int page = (int)(scrollView.contentOffset.x / kCarouselWidth + 0.5) % numberOfPages;
    self.pageControl.currentPage = page;
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
