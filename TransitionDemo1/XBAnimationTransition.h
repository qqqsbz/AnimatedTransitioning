//
//  XBAnimationTransition.h
//  TransitionDemo1
//
//  Created by coder on 16/5/19.
//  Copyright © 2016年 coder. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,XBAnimationType) {
    XBAnimationTypeStart = 0,
    XBAnimationTypeEnd
};
@interface XBAnimationTransition : NSObject <UIViewControllerAnimatedTransitioning>

+ (instancetype)transitionWithAnimationType:(XBAnimationType)type;

- (instancetype)initWithAnimationType:(XBAnimationType)type;

@end
