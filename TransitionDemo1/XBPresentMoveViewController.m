//
//  XBPresentMoveViewController.m
//  TransitionDemo1
//
//  Created by coder on 16/5/18.
//  Copyright © 2016年 coder. All rights reserved.
//

#import "XBPresentMoveViewController.h"
#import "XBPresentMoveCell.h"
#import "XBPresentTransition.h"
#import "XBPresentViewController.h"
@interface XBPresentMoveViewController () <UIViewControllerTransitioningDelegate>

@end

@implementation XBPresentMoveViewController

static NSString * const reuseIdentifier = @"XBPresentMoveCell";

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
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([XBPresentMoveCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:reuseIdentifier];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 30;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XBPresentMoveCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.currentIndexPath = indexPath;
    XBPresentViewController *vc = [[XBPresentViewController alloc] init];
    vc.transitioningDelegate = self;
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}


- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
   return [XBPresentTransition transitionWithTransitionType:XBPresentTransitionTypePresent];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [XBPresentTransition transitionWithTransitionType:XBPresentTransitionTypeDismiss];
}
@end
