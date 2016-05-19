//
//  XBAnimationTransition.m
//  TransitionDemo1
//
//  Created by coder on 16/5/19.
//  Copyright © 2016年 coder. All rights reserved.
//

#import "XBAnimationTransition.h"
#import "XBAnimationEndViewController.h"
#import "XBAnimationStartViewController.h"
@interface XBAnimationTransition()
@property (assign, nonatomic) XBAnimationType   type;
@property (assign, nonatomic) CGFloat           startRadius;
@end

@implementation XBAnimationTransition

+ (instancetype)transitionWithAnimationType:(XBAnimationType)type
{
    return [[self alloc] initWithAnimationType:type];
}

- (instancetype)initWithAnimationType:(XBAnimationType)type
{
    if (self = [super init]) {
        _type = type;
        _startRadius = 25.f;
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
        case XBAnimationTypeStart:
            [self startAnimation:transitionContext];
            break;
        case XBAnimationTypeEnd:
            [self endAnimation:transitionContext];
            break;
    }
}

- (void)startAnimation:(id <UIViewControllerContextTransitioning>)transitionContext
{
    XBAnimationStartViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    XBAnimationEndViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    
    //绘制小圆的路径
    CGPoint touchPoint = fromVC.touchPoint;
    UIBezierPath *startPath = [UIBezierPath bezierPathWithArcCenter:fromVC.touchPoint radius:self.startRadius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    //计算点击点到边缘的最大值 利用勾股定理求最长边
    CGFloat x = MAX(touchPoint.x, CGRectGetWidth(containerView.frame) - touchPoint.x + self.startRadius);
    CGFloat y = MAX(touchPoint.y, CGRectGetHeight(containerView.frame) - touchPoint.y + self.startRadius);
    CGFloat endRadius = sqrtf(pow(x, 2.f) + pow(y, 2.f));
    //绘制大圆的路径
    UIBezierPath *endPath = [UIBezierPath bezierPathWithArcCenter:touchPoint radius:endRadius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    //创建CAShapeLayer进行遮盖
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endPath.CGPath;
    maskLayer.fillColor = [UIColor orangeColor].CGColor;
    toVC.view.layer.mask = maskLayer;
    
    //执行动画
    CABasicAnimation *startAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    startAnimation.fromValue = (__bridge id)(startPath.CGPath);
    startAnimation.toValue   = (__bridge id)(endPath.CGPath);
    startAnimation.duration  = [self transitionDuration:transitionContext];
    startAnimation.delegate  = self;
    startAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [startAnimation setValue:transitionContext forKey:@"transitionContext"];
    [maskLayer addAnimation:startAnimation forKey:@"path"];
    
}

- (void)endAnimation:(id <UIViewControllerContextTransitioning>)transitionContext
{
    XBAnimationEndViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    XBAnimationStartViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    [containerView insertSubview:toVC.view atIndex:0];
    
    //    CGPoint center = toVC.touchPoint;
    CGPoint center = fromVC.touchPoint;
    CGFloat startRadius = sqrtf(pow(CGRectGetWidth(containerView.frame), 2.f) + powf(CGRectGetHeight(containerView.frame), 2.f)) / 2.f;
    UIBezierPath *startPath = [UIBezierPath bezierPathWithArcCenter:center radius:startRadius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    UIBezierPath *endPath = [UIBezierPath bezierPathWithArcCenter:center radius:self.startRadius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endPath.CGPath;
    maskLayer.fillColor = [UIColor purpleColor].CGColor;
    fromVC.view.layer.mask = maskLayer;
    
    
    CABasicAnimation *endAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    endAnimation.fromValue = (__bridge id)(startPath.CGPath);
    endAnimation.toValue   = (__bridge id)(endPath.CGPath);
    endAnimation.duration  = [self transitionDuration:transitionContext];
    endAnimation.delegate  = self;
    endAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [endAnimation setValue:transitionContext forKey:@"transitionContext"];
    [maskLayer addAnimation:endAnimation forKey:@"path"];
}

#pragma mark -- CABasicAnimation delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    //通知系统已完成动画
    id <UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
    [transitionContext completeTransition:YES];
}


@end
