//
//  ViewController.m
//  TTCollectionView
//
//  Created by phenix on 5/25/16.
//  Copyright © 2016 phenix. All rights reserved.
//

#import "ViewController.h"
#import "TTMInfiniteCarouselView.h"

@interface ViewController ()

@property (nonatomic, strong) TTMInfiniteCarouselView *infiniteCarouselView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.infiniteCarouselView];
    
    [self.infiniteCarouselView updateWithDataArray:@[@{@"img": @"1_750x300.jpg"}, @{@"img": @"2_750x300.jpg"}, @{@"img": @"3_750x300.jpg"}, @{@"img": @"4_750x300.jpg"}, @{@"img": @"5_750x300.jpg"}]];
    
    [self.infiniteCarouselView startTimer];
    
    [self.infiniteCarouselView reloadData];
    
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
