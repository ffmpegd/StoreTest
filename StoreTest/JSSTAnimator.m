//
//  JSSTAnimator.m
//  SuperbTest
//
//  Created by Jake Spencer on 6/7/14.
//  Copyright (c) 2014 Uncarbonated Software LLC. All rights reserved.
//

#import "JSSTAnimator.h"

@implementation JSSTAnimator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.25;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    [[transitionContext containerView] addSubview:toViewController.view];
    
    if ([fromViewController isKindOfClass:[JSSTDetailViewController class]])
    {
        toViewController.view.alpha = 0;
        toViewController.view.transform = CGAffineTransformMakeScale(0.1, 0.1);
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            toViewController.view.transform = CGAffineTransformMakeScale(1.0, 1.0);
            toViewController.view.alpha = 1;
        } completion:^(BOOL finished) {
            fromViewController.view.transform = CGAffineTransformIdentity;
            toViewController.view.transform = CGAffineTransformIdentity;
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            
        }];

    }
    else
    {
//        fromViewController.view.alpha = 0;
        toViewController.view.alpha = 0;
        fromViewController.view.alpha = 1;
        fromViewController.view.transform = CGAffineTransformMakeScale(1.0, 1.0);
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            fromViewController.view.transform = CGAffineTransformMakeScale(0.1, 0.1);
            toViewController.view.alpha = 1;
            fromViewController.view.alpha = 0;
        } completion:^(BOOL finished) {
            //fromViewController.view.transform = CGAffineTransformIdentity;
            toViewController.view.transform = CGAffineTransformIdentity;
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            
        }];
        
    }
    
}

@end
