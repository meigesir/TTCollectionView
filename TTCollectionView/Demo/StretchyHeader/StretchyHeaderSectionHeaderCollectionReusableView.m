//
//  StretchyHeaderSectionHeaderCollectionReusableView.m
//  TTCollectionView
//
//  Created by phenix on 6/2/16.
//  Copyright © 2016 phenix. All rights reserved.
//

#import "StretchyHeaderSectionHeaderCollectionReusableView.h"

@implementation StretchyHeaderSectionHeaderCollectionReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.imageView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
}

@end
