//
//  SwipeTransitionDelegate.m
//  转场动画Demo
//
//  Created by SKOTC on 17/6/15.
//  Copyright © 2017年 CAOMEI. All rights reserved.
//

#import "SwipeTransitionDelegate.h"
#import "SwipeTransitionAnimation.h"
#import "SwipTransitionInteractionController.h"

@implementation SwipeTransitionDelegate

//下面这两个方法和刚开始讲逐渐出现动画时候的理解是一样的
/*
   不管是 present 还是dismiss 
   要是调用interactionControllerForPresentation 或者是 interactionControllerForDismissal
   返回值是nil,就会走下面两个方法
 
   要是不是nil,就不会走下面这两个方法了， 在我们这里也就是用手势的时候是不会走的，点击present 还是dismiss 会走
 
 */
-(nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{

        return [[SwipeTransitionAnimation alloc]initWithTargetEdge:self.targetEdge];
}

-(nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{

        return [[SwipeTransitionAnimation alloc]initWithTargetEdge:self.targetEdge];

}


// UIKit还会调用代理的interactionControllerForPresentation:方法来获取交互式控制器，如果得到了nil则执行非交互式动画
// 如果获取到了不是nil的对象，那么UIKit不会调用animator的animateTransition方法，而是调用交互式控制器的startInteractiveTransition:方法。

// interaction 交互
- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator
{
     
        // 说说这里的SwipTransitionInteractionController 控制器，
        // 它是继承 UIPercentDrivenInteractiveTransition 的，而这个UIPercentDrivenInteractiveTransition是遵守了
        // UIViewControllerInteractiveTransitioning 协议的，所以这里初始化返回这个是没有问题的
        
        // 是手势操作，就返回这个交互式控制器
        if (self.gestureRecognizer)
                
                return [[SwipTransitionInteractionController alloc] initWithGestureRecognizer:self.gestureRecognizer edgeForDragging:self.targetEdge];
        else
                return nil;
}

// 这个方法是在dismiss的时候
- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator
{
        
        if (self.gestureRecognizer)
                
                return [[SwipTransitionInteractionController alloc] initWithGestureRecognizer:self.gestureRecognizer edgeForDragging:self.targetEdge];
        else
                return nil;
}


@end
