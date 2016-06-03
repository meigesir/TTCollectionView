//
//  SlideZoomInViewController.m
//  TTCollectionView
//
//  Created by phenix on 6/3/16.
//  Copyright © 2016 phenix. All rights reserved.
//

#import "SlideZoomInViewController.h"
#import "TTMSlideZoomInFlowLayout.h"
#import "SlideZoomInCollectionViewCell.h"

@interface SlideZoomInViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray *cellImages;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) TTMSlideZoomInFlowLayout *zoomInLayout;

@end

@implementation SlideZoomInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // sectionInset
    CGFloat inset = (self.collectionView.frame.size.width - self.zoomInLayout.itemSize.width) * 0.5;
    self.zoomInLayout.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
    
    [self.view addSubview:self.collectionView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.cellImages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SlideZoomInCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SlideZoomInCollectionViewCell class]) forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:self.cellImages[indexPath.item]];
    return cell;
}

#pragma mark - Accessors

- (NSArray *)cellImages {
    if (!_cellImages) {
        _cellImages = @[
                        @"300X768.jpg",
                        @"380X475.jpg",
                        
                        @"400*575.jpg",
                        @"474X663.jpg",
                        @"474X711-2.jpg",
                        
                        @"425X638.jpg",
                        @"446X666.jpg",
                        @"474X474-2.jpg",
                        
                        @"474X1510.jpg",
                        @"474X754.jpg",
                        @"474X713.jpg",
                        
                        @"457X500.jpg",
                        @"474X701.jpg",
                        @"460X460.jpg",
                        
                        @"474X474-3.jpg",
                        @"474X639.jpg",
                        @"474X474.jpg",
                        
                        @"474X710.jpg",
                        @"474X711.jpg",
                        @"474X779.jpg"
                        ];
    }
    return _cellImages;
}

- (UICollectionView *)collectionView {
	if(_collectionView == nil) {
        _collectionView = [[UICollectionView alloc] initWithFrame:(CGRect){0, 64, [UIScreen mainScreen].bounds.size.width, 200} collectionViewLayout:self.zoomInLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SlideZoomInCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([SlideZoomInCollectionViewCell class])];
        
	}
	return _collectionView;
}

- (TTMSlideZoomInFlowLayout *)zoomInLayout {
	if(_zoomInLayout == nil) {
		_zoomInLayout = [[TTMSlideZoomInFlowLayout alloc] init];
        _zoomInLayout.itemSize = CGSizeMake(200, 200);
	}
	return _zoomInLayout;
}

@end
