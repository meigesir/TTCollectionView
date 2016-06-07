//
//  ReorderCellViewController.m
//  TTCollectionView
//
//  Created by phenix on 6/7/16.
//  Copyright © 2016 phenix. All rights reserved.
//

#import "ReorderCellViewController.h"
#import "LXReorderableCollectionViewFlowLayout.h"
#import "SlideZoomInCollectionViewCell.h"

@interface ReorderCellViewController () <LXReorderableCollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet LXReorderableCollectionViewFlowLayout *reorderLayout;

@property (nonatomic, strong) NSMutableArray *cellImages;

@end

@implementation ReorderCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGFloat margin = 10;
    int columnCount = 2;
    self.reorderLayout.sectionInset = UIEdgeInsetsMake(margin, margin, margin, margin);
    
    CGFloat itemWidth = ([UIScreen mainScreen].bounds.size.width - margin * 2 - 10 * (columnCount - 1) ) / columnCount;
    self.reorderLayout.itemSize = CGSizeMake(itemWidth, itemWidth);
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SlideZoomInCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([SlideZoomInCollectionViewCell class])];
    
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
    SlideZoomInCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SlideZoomInCollectionViewCell class]) forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:self.cellImages[indexPath.item]];
    return cell;
}

#pragma mark - LXReorderableCollectionViewDataSource

- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath willMoveToIndexPath:(NSIndexPath *)toIndexPath
{
    id object = [self.cellImages objectAtIndex:fromIndexPath.item];
    [self.cellImages removeObjectAtIndex:fromIndexPath.item];
    [self.cellImages insertObject:object atIndex:toIndexPath.item];
    
    
}

#pragma mark - Accessors

- (NSMutableArray *)cellImages {
    if (!_cellImages) {
        _cellImages = [@[
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
                        ] mutableCopy];
    }
    return _cellImages;
}

@end
