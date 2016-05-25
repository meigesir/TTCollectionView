//
//  TTMInfiniteCarouselItem.m
//  TTCollectionView
//
//  Created by phenix on 5/25/16.
//  Copyright © 2016 phenix. All rights reserved.
//

#import "TTMInfiniteCarouselItem.h"

@interface TTMInfiniteCarouselItem ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation TTMInfiniteCarouselItem

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)updateWithDict:(NSDictionary *)dict
{
    self.imageView.image = [UIImage imageNamed:dict[@"img"]];
}

@end
