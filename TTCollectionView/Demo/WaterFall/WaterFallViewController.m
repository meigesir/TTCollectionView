//
//  WaterFallViewController.m
//  TTCollectionView
//
//  Created by phenix on 5/29/16.
//  Copyright © 2016 phenix. All rights reserved.
//

#import "WaterFallViewController.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "WaterFallCollectionViewCell.h"

@interface WaterFallViewController () <UICollectionViewDataSource, UICollectionViewDelegate, CHTCollectionViewDelegateWaterfallLayout>

@property (nonatomic, strong) NSArray *cellSizes;
@property (nonatomic, strong) NSArray *cellImages;

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet CHTCollectionViewWaterfallLayout *waterFallLayout;

@end

@implementation WaterFallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.waterFallLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.waterFallLayout.minimumInteritemSpacing = 10;
    self.waterFallLayout.minimumColumnSpacing = 10;
    
    [self.collectionView reloadData];
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
    WaterFallCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([WaterFallCollectionViewCell class]) forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:self.cellImages[indexPath.item]];
    return cell;
}

#pragma mark - CHTCollectionViewDelegateWaterfallLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.cellSizes[indexPath.item] CGSizeValue];
}

#pragma mark - Accessors

- (NSArray *)cellSizes {
    if (!_cellSizes) {
        _cellSizes = @[
                       [NSValue valueWithCGSize:CGSizeMake(300, 768)],
                       [NSValue valueWithCGSize:CGSizeMake(380, 475)],
                       
                       [NSValue valueWithCGSize:CGSizeMake(400, 575)],
                       [NSValue valueWithCGSize:CGSizeMake(474, 663)],
                       [NSValue valueWithCGSize:CGSizeMake(474, 711)],
                       
                       [NSValue valueWithCGSize:CGSizeMake(425, 638)],
                       [NSValue valueWithCGSize:CGSizeMake(446, 666)],
                       [NSValue valueWithCGSize:CGSizeMake(474, 474)],
                       
                       [NSValue valueWithCGSize:CGSizeMake(474, 1510)],
                       [NSValue valueWithCGSize:CGSizeMake(474, 754)],
                       [NSValue valueWithCGSize:CGSizeMake(474, 713)],
                       
                       [NSValue valueWithCGSize:CGSizeMake(457, 500)],
                       [NSValue valueWithCGSize:CGSizeMake(474, 701)],
                       [NSValue valueWithCGSize:CGSizeMake(460, 460)],
                       
                       [NSValue valueWithCGSize:CGSizeMake(474, 474)],
                       [NSValue valueWithCGSize:CGSizeMake(474, 639)],
                       [NSValue valueWithCGSize:CGSizeMake(474, 474)],
                       
                       [NSValue valueWithCGSize:CGSizeMake(474, 710)],
                       [NSValue valueWithCGSize:CGSizeMake(474, 711)],
                       [NSValue valueWithCGSize:CGSizeMake(474, 779)]
                       ];
    }
    return _cellSizes;
}

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

@end
