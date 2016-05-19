//
//  XBAnimationEndViewController.m
//  TransitionDemo1
//
//  Created by coder on 16/5/19.
//  Copyright © 2016年 coder. All rights reserved.
//

#import "XBAnimationEndViewController.h"

@interface XBAnimationEndViewController ()
@property (strong, nonatomic) UIImageView  *imageView;
@end

@implementation XBAnimationEndViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.imageView.image = [UIImage imageNamed:@"duorou.jpg"];
    [self.view addSubview:self.imageView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    self.touchPoint = [touch locationInView:self.view];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
