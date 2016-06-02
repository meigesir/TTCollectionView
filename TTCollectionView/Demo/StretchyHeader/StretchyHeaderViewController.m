//
//  StretchyHeaderViewController.m
//  TTCollectionView
//
//  Created by phenix on 6/2/16.
//  Copyright © 2016 phenix. All rights reserved.
//

#import "StretchyHeaderViewController.h"
#import "TTMStretchyHeaderCollectionViewLayout.h"
#import "StretchyHeaderSectionHeaderCollectionReusableView.h"

static NSString *const kHeaderIdent = @"headerIdent";
static NSString *const kCellIdent = @"cellIdent";

@interface StretchyHeaderViewController () <UICollectionViewDataSource, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet TTMStretchyHeaderCollectionViewLayout *flowLayout;

@end

@implementation StretchyHeaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // set the default size for our header (for when it's not stretched)
    [self.flowLayout setHeaderReferenceSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 160)];
    
    [self.flowLayout setItemSize:CGSizeMake([UIScreen mainScreen].bounds.size.width , 100)];
    
    // tell our collection view to always bounce.
    [self.collectionView setAlwaysBounceVertical:YES];
    
    // Then register a class to use for the header.
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([StretchyHeaderSectionHeaderCollectionReusableView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderIdent];
    
    [self.collectionView registerClass:[UICollectionViewCell class]
       forCellWithReuseIdentifier:kCellIdent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdent forIndexPath:indexPath];
    

    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    StretchyHeaderSectionHeaderCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderIdent forIndexPath:indexPath];
    
    header.imageView.image = [UIImage imageNamed:@"car.jpg"];
    
    return header;
}

@end
