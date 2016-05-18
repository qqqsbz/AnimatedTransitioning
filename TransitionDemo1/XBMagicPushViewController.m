//
//  XBMagicPushViewController.m
//  TransitionDemo1
//
//  Created by coder on 16/5/17.
//  Copyright © 2016年 coder. All rights reserved.
//

#import "XBMagicPushViewController.h"
#import "XBPresentOneTransition.h"
@interface XBMagicPushViewController ()

@end

@implementation XBMagicPushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"神奇移动";
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cover.jpg"]];
    self.imageView = imageView;
    [self.view addSubview:imageView];
    imageView.center = CGPointMake(self.view.center.x, self.view.center.y - CGRectGetHeight(self.view.frame) / 2 + 210);
    imageView.bounds = CGRectMake(0, 0, 280, 280);
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    return [XBPresentOneTransition transitionWithTransitionType:operation == UINavigationControllerOperationPush ? XBPresentOneTransitionTypePush : XBPresentOneTransitionTypePop];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
