//
//  TTMInfiniteCarouselView.h
//  TTCollectionView
//
//  Created by phenix on 5/25/16.
//  Copyright © 2016 phenix. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  PageControl位置
 */
typedef NS_ENUM(NSInteger, TTMInfiniteCarouselViewPageControlAlignment) {
    /**
     *  居左
     */
    TTMInfiniteCarouselViewPageControlAlignmentLeft,
    /**
     *  居中
     */
    TTMInfiniteCarouselViewPageControlAlignmentCenter,
    /**
     *  居右
     */
    TTMInfiniteCarouselViewPageControlAlignmentRight
};

/**
 无限轮播View
 */
@interface TTMInfiniteCarouselView : UIView

@property (nonatomic, assign) TTMInfiniteCarouselViewPageControlAlignment pageControlAlignment;

/* custom pageControl*/
@property (nonatomic,strong) UIColor *pageIndicatorTintColor;
@property (nonatomic,strong) UIColor *currentPageIndicatorTintColor;

@property (nonatomic, assign) CGFloat leftMarginOfPageControl;// pageControlAlignment为TTMInfiniteCarouselViewPageControlAlignmentLeft时有效
@property (nonatomic, assign) CGFloat rightMarginOfPageControl;// pageControlAlignment为TTMInfiniteCarouselViewPageControlAlignmentRight时有效
@property (nonatomic, assign) CGFloat bottomMarginOfPageControl;

@property (nonatomic, assign) CGFloat heightOfPageControl;

/**
 *  使用数据更新
 *
 *  @param array array数据
 */
- (void)updateWithDataArray:(NSArray *)array;

- (void)reloadData;

@end
