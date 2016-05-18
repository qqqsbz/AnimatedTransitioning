//
//  XBPresentTransition.m
//  TransitionDemo1
//
//  Created by coder on 16/5/18.
//  Copyright © 2016年 coder. All rights reserved.
//

#import "XBPresentTransition.h"
#import "XBPresentMoveCell.h"
#import "XBPresentViewController.h"
#import "XBPresentMoveViewController.h"
@interface XBPresentTransition()
@property (assign, nonatomic) XBPresentTransitionType  type;
@end
@implementation XBPresentTransition

+ (instancetype)transitionWithTransitionType:(XBPresentTransitionType)type
{
    return [[self alloc] initWithTransitionType:type];
}

- (instancetype)initWithTransitionType:(XBPresentTransitionType)type
{
    if (self = [super init]) {
        _type = type;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return .5f;
}


- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    switch (_type) {
        case XBPresentTransitionTypePresent:
            [self presentAnimation:transitionContext];
            break;
        case XBPresentTransitionTypeDismiss:
            [self dismissAnimation:transitionContext];
            break;
    }
}

- (void)presentAnimation:(id <UIViewControllerContextTransitioning>)transitionContext
{
    XBPresentMoveViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    XBPresentViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    XBPresentMoveCell *cell = (XBPresentMoveCell *)[fromVC.collectionView cellForItemAtIndexPath:fromVC.currentIndexPath];
    UIView *containerView = [transitionContext containerView];
    UIView *tempView = [cell.imageView snapshotViewAfterScreenUpdates:NO];
    //先把预览图片的位置设置成cell对应的位置
    tempView.frame = [cell.imageView convertRect:cell.imageView.bounds toView:containerView];
    //隐藏目标控制器要显示的图片
    toVC.imageView.image = cell.imageView.image;
    toVC.imageView.hidden = YES;
    //设置源控制器的alpha
    fromVC.view.alpha = 0;
    [containerView addSubview:toVC.view];
    //将tempView加入到最后 方便dismiss的时候获取
    [containerView addSubview:tempView];
    
    [UIView animateWithDuration:0.35f animations:^{
        //将cell的frame设置成目标控制器图片的frame
        tempView.frame = [toVC.imageView convertRect:toVC.imageView.bounds toView:containerView];
        toVC.view.alpha = 1.f;
    } completion:^(BOOL finished) {
        tempView.hidden = YES;
        toVC.imageView.hidden = NO;
        [transitionContext completeTransition:YES];
        [toVC startAnimation];
    }];

}


- (void)dismissAnimation:(id <UIViewControllerContextTransitioning>)transitionContext
{
    XBPresentViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    XBPresentMoveViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    XBPresentMoveCell *cell = (XBPresentMoveCell *)[toVC.collectionView cellForItemAtIndexPath:toVC.currentIndexPath];
    UIView *containerView = [transitionContext containerView];
    UIView *tempView = containerView.subviews.lastObject;
    
    fromVC.imageView.hidden = YES;
    cell.imageView.hidden = YES;
    tempView.hidden = NO;
    toVC.view.alpha = 1.f;
    [containerView insertSubview:toVC.view atIndex:0];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        tempView.frame = [cell.imageView convertRect:cell.imageView.bounds toView:containerView];
        fromVC.view.alpha = 0.f;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        cell.imageView.hidden = NO;
        [tempView removeFromSuperview];
    }];
    
}

@end
