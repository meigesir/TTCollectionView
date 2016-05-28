//
//  InfiniteCarouselDemoVC.m
//  TTCollectionView
//
//  Created by phenix on 5/28/16.
//  Copyright © 2016 phenix. All rights reserved.
//

#import "InfiniteCarouselDemoVC.h"
#import "TTMInfiniteCarouselView.h"

@interface InfiniteCarouselDemoVC ()

@property (nonatomic, strong) TTMInfiniteCarouselView *infiniteCarouselView;

@end

@implementation InfiniteCarouselDemoVC

- (void)awakeFromNib
{
    [self.view addSubview:self.infiniteCarouselView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    
    [self.infiniteCarouselView updateWithDataArray:@[@{@"img": @"1_750x300.jpg"}, @{@"img": @"2_750x300.jpg"}, @{@"img": @"3_750x300.jpg"}, @{@"img": @"4_750x300.jpg"}, @{@"img": @"5_750x300.jpg"}]];
    
    [self.infiniteCarouselView reloadData];
    
    [self.infiniteCarouselView startTimer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (TTMInfiniteCarouselView *)infiniteCarouselView {
    if(_infiniteCarouselView == nil) {
        _infiniteCarouselView = [[TTMInfiniteCarouselView alloc] initWithFrame:(CGRect){CGPointZero, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width / 2}];
        _infiniteCarouselView.pageControlAlignment = TTMInfiniteCarouselViewPageControlAlignmentCenter;
        _infiniteCarouselView.currentPageIndicatorTintColor = [UIColor purpleColor];
    }
    return _infiniteCarouselView;
}

@end
