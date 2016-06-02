//
//  TTMStretchyHeaderCollectionViewLayout.m
//  TTCollectionView
//
//  Created by phenix on 6/2/16.
//  Copyright © 2016 phenix. All rights reserved.
//

#import "TTMStretchyHeaderCollectionViewLayout.h"

@implementation TTMStretchyHeaderCollectionViewLayout

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (UICollectionViewScrollDirection)scrollDirection
{
    return UICollectionViewScrollDirectionVertical;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    UICollectionView *collectionView = [self collectionView];
    UIEdgeInsets insets = [collectionView contentInset];
    CGPoint offset = [collectionView contentOffset];
    CGFloat minY = - insets.top;
    
    // First get the superclass attributes.
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    
    // Check if we've pulled below past the lowest position
    if (offset.y < minY) {
        
        CGSize headerSize = [self headerReferenceSize];
        // Figure out how much we've pulled down
        CGFloat deltaY = fabs((double)(offset.y - minY));
        
        for (UICollectionViewLayoutAttributes *attrs in attributes) {
            
            if ([attrs representedElementKind] == UICollectionElementKindSectionHeader) {
                
                // Adjust the header's height and y based on how much the user
                // has pulled down.
                CGRect headerRect = [attrs frame];
                headerRect.size.height = MAX(minY, headerSize.height + deltaY);
                headerRect.origin.y = headerRect.origin.y - deltaY;
                [attrs setFrame:headerRect];
                break;
                
            }
            
        }
    }
    
    return attributes;
}

@end
