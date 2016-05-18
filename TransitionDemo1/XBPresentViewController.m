//
//  XBPresentViewController.m
//  TransitionDemo1
//
//  Created by coder on 16/5/18.
//  Copyright © 2016年 coder. All rights reserved.
//

#import "XBPresentViewController.h"
#import "XBPresentTransition.h"
@interface XBPresentViewController ()

@end

@implementation XBPresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissAction:)]];
    [self.view addSubview:self.imageView];
}

- (void)dismissAction:(UITapGestureRecognizer *)gesture
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)startAnimation
{
    NSLog(@"startAnimation...........");
}

@end
