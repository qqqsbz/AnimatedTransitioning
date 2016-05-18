//
//  XBPresentOneTransition.h
//  TransitionDemo1
//
//  Created by coder on 16/5/17.
//  Copyright © 2016年 coder. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,XBPresentOneTransitionType) {
    XBPresentOneTransitionTypePush = 0,
    XBPresentOneTransitionTypePop
};
@interface XBPresentOneTransition : NSObject <UIViewControllerAnimatedTransitioning>

+ (instancetype)transitionWithTransitionType:(XBPresentOneTransitionType)type;
- (instancetype)initWithTransitionType:(XBPresentOneTransitionType)type;

@end
