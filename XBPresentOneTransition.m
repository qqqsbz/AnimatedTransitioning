//
//  XBPresentOneTransition.m
//  TransitionDemo1
//
//  Created by coder on 16/5/17.
//  Copyright © 2016年 coder. All rights reserved.
//

#import "XBPresentOneTransition.h"
#import "XBMagicViewController.h"
#import "XBMagicPushViewController.h"
#import "XBMagicCell.h"
@interface XBPresentOneTransition()
@property (assign, nonatomic) XBPresentOneTransitionType  type;
@end
@implementation XBPresentOneTransition
+ (instancetype)transitionWithTransitionType:(XBPresentOneTransitionType)type
{
    return [[self alloc] initWithTransitionType:type];
}

- (instancetype)initWithTransitionType:(XBPresentOneTransitionType)type
{
    if (self = [super init]) {
        _type = type;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 1.f;
}


- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    switch (_type) {
        case XBPresentOneTransitionTypePush:
            [self pushAnimation:transitionContext];
            break;
        case XBPresentOneTransitionTypePop:
            [self popAnimation:transitionContext];
            break;
    }
}

- (void)pushAnimation:(id <UIViewControllerContextTransitioning>)transitionContext
{
    XBMagicViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    XBMagicPushViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    XBMagicCell *cell = (XBMagicCell *)[fromVC.collectionView cellForItemAtIndexPath:fromVC.currentIndexPath];
    UIView *containerView = [transitionContext containerView];
    UIView *tempView = [cell.imageView snapshotViewAfterScreenUpdates:NO];
    tempView.frame = [cell.imageView convertRect:cell.imageView.bounds toView:containerView];
    
    cell.imageView.hidden = YES;
    toVC.imageView.hidden = YES;
    toVC.view.alpha = 0.f;
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:tempView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.55f initialSpringVelocity:1.0/0.55f options:0 animations:^{
        tempView.frame = [toVC.imageView convertRect:toVC.imageView.bounds toView:containerView];
        toVC.view.alpha = 1.f;
    } completion:^(BOOL finished) {
        tempView.hidden = YES;
        toVC.imageView.hidden = NO;
        [transitionContext completeTransition:YES];
    }];
}

- (void)popAnimation:(id <UIViewControllerContextTransitioning>)transitionContext
{
    XBMagicPushViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    XBMagicViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    XBMagicCell *cell = (XBMagicCell *)[toVC.collectionView cellForItemAtIndexPath:toVC.currentIndexPath];
    UIView *containerView = [transitionContext containerView];
    UIView *tempView = containerView.subviews.lastObject;
    
    tempView.hidden = NO;
    fromVC.imageView.hidden = YES;
    [containerView insertSubview:toVC.view atIndex:0];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.65f initialSpringVelocity:1.0/0.65f options:0 animations:^{
        tempView.frame = [cell.imageView convertRect:cell.imageView.bounds toView:containerView];
        fromVC.view.alpha = 0.f;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        cell.imageView.hidden = NO;
        [tempView removeFromSuperview];
    }];
}



@end
