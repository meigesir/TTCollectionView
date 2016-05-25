//
//  TTMInfiniteCarouselItem.h
//  TTCollectionView
//
//  Created by phenix on 5/25/16.
//  Copyright © 2016 phenix. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 无限轮播Item
 */
@interface TTMInfiniteCarouselItem : UICollectionViewCell

/**
 *  使用数据更新
 *
 *  @param dict 数据
 */
- (void)updateWithDict:(NSDictionary *)dict;

@end
