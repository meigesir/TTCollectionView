//
//  WaterFallCollectionViewCell.m
//  TTCollectionView
//
//  Created by phenix on 5/29/16.
//  Copyright © 2016 phenix. All rights reserved.
//

#import "WaterFallCollectionViewCell.h"

@implementation WaterFallCollectionViewCell

- (void)awakeFromNib
{
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;
}

@end
