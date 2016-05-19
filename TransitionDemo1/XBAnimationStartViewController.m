//
//  XBAnimationStartViewController.m
//  TransitionDemo1
//
//  Created by coder on 16/5/19.
//  Copyright © 2016年 coder. All rights reserved.
//

#import "XBAnimationStartViewController.h"
#import "XBAnimationTransition.h"
#import "XBAnimationEndViewController.h"
@interface XBAnimationStartViewController () <UIViewControllerTransitioningDelegate>

@end

@implementation XBAnimationStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    self.touchPoint = [touch locationInView:self.view];
    
    XBAnimationEndViewController *vc = [[XBAnimationEndViewController alloc] init];
    vc.transitioningDelegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [XBAnimationTransition transitionWithAnimationType:XBAnimationTypeStart];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [XBAnimationTransition transitionWithAnimationType:XBAnimationTypeEnd];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
