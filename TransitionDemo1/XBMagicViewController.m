//
//  XBMagicViewController.m
//  TransitionDemo1
//
//  Created by coder on 16/5/17.
//  Copyright © 2016年 coder. All rights reserved.
//

#import "XBMagicViewController.h"
#import "XBMagicCell.h"
#import "XBMagicPushViewController.h"
#import "XBPresentOneTransition.h"
@interface XBMagicViewController ()

@end

@implementation XBMagicViewController

static NSString * const reuseIdentifier = @"XBMagicCell";

- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(150, 180);
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    self = [super initWithCollectionViewLayout:layout];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([XBMagicCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:reuseIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XBMagicCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.currentIndexPath = indexPath;
    XBMagicPushViewController *vc = [[XBMagicPushViewController alloc] init];
    self.navigationController.delegate = vc;
    [self.navigationController pushViewController:vc animated:YES];

}


@end
