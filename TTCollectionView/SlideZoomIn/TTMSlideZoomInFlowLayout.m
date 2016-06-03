//
//  TTMSlideZoomInFlowLayout.m
//  TTCollectionView
//
//  Created by phenix on 6/3/16.
//  Copyright © 2016 phenix. All rights reserved.
//

#import "TTMSlideZoomInFlowLayout.h"

@implementation TTMSlideZoomInFlowLayout

- (void)prepareLayout
{
    [super prepareLayout];
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *attrsArray = [super layoutAttributesForElementsInRect:rect];
    
    // collectionView屏幕中心点x值
    CGFloat centerX = self.collectionView.frame.size.width / 2 + self.collectionView.contentOffset.x;
    
    for (UICollectionViewLayoutAttributes *attrs in attrsArray) {
        // cell中心点x和collectionView屏幕中心点的x值的间距
        CGFloat space = ABS(attrs.center.x - centerX);
        CGFloat scale = 1 - space / self.collectionView.frame.size.width;
        attrs.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return attrsArray;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    // 计算出最终显示的矩形框
    CGRect rect;
    rect.origin.y = 0;
    rect.origin.x = proposedContentOffset.x;
    rect.size = self.collectionView.frame.size;
    
    // 获得rect中的layout属性集
    NSArray *attrsArray = [super layoutAttributesForElementsInRect:rect];
    
    // collectionView屏幕中心点x值
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width / 2;
    
    CGFloat minSpace = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attrs in attrsArray) {
        
        if (ABS(minSpace) > ABS(attrs.center.x - centerX)) {
            minSpace = attrs.center.x - centerX;
        }
        
    }
    
    // 修改原有的偏移量
    proposedContentOffset.x += minSpace;
    return proposedContentOffset;
    
}

@end
