//
//  SwipeTransitionAnimation.m
//  转场动画Demo
//
//  Created by SKOTC on 17/6/15.
//  Copyright © 2017年 CAOMEI. All rights reserved.
//

#import "SwipeTransitionAnimation.h"

@implementation SwipeTransitionAnimation

- (instancetype)initWithTargetEdge:(UIRectEdge)targetEdge{
        
        self = [self init];
        if (self) {
                
                _targetEdge = targetEdge;
        }
        return self;
}



-(NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
  
        return 0.35;

}



-(void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{


        // 前面字儿写获取这些变量的方法和上面的一样
        UIViewController * fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        
        UIViewController * toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        
        UIView * fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        UIView * toView   = [transitionContext viewForKey:UITransitionContextToViewKey];
        
        CGRect fromFrame  = [transitionContext initialFrameForViewController:fromViewController];
        CGRect toFrame    = [transitionContext finalFrameForViewController:toViewController];
        
        // 判断是不是fromViewController present 过来的
        /*
           说一下这里的isPresenting判断的逻辑，我们把SwipeFromViewController比喻成A SwipeToViewController为B
         
           当从A present 到B的时候   上面的fromViewController就是A ， toViewController就是B
           这个时候 A就是B的 presentingViewController  B就是A的presentedViewController
           这个是不会受到present还是dismiss影响的
         
           再当从B dismiss到A的时候    上面的fromViewController就是B ， toViewController就是A
           这个时候 toViewController.presentingViewController 也就是A的presentingViewController 就不是B（fromViewController）了，
           是更前面的，要理解的了的话你就知道因该是ViewController
           
           所以这个时候 isPresenting 就是NO 
           这就是这个isPresenting判断的逻辑，其实说白了这样可以判断是A到B的present 还是B到A的dismiss
         
         */
        BOOL isPresenting = (toViewController.presentingViewController == fromViewController);
        
        // 你可以打开这个输出自己理解一下
        // NSLog(@"isPresenting  == %d",isPresenting);
        
        /*
            下面代理解释，下面代码是根据手势的滑动方向来定义二维矢量offset，用来计算在滑动的时候的toFrme
         */
        
        __block CGVector offset;
        if (self.targetEdge == UIRectEdgeTop)
                
                offset = CGVectorMake(0.f, 1.f);
        else if (self.targetEdge == UIRectEdgeBottom)
                
                offset = CGVectorMake(0.f, -1.f);
        else if (self.targetEdge == UIRectEdgeLeft)
                
                offset = CGVectorMake(1.f, 0.f);
        else if (self.targetEdge == UIRectEdgeRight)
                
                offset = CGVectorMake(-1.f, 0.f);
        else
                //否则跑出断言
                NSAssert(NO, @"targetEdge must be one of UIRectEdgeTop, UIRectEdgeBottom, UIRectEdgeLeft, or UIRectEdgeRight.");
        
        // 如果是 present的时候
        if (isPresenting) {
                
                // CGRectOffset该函数表示：rect 按照dx dy平移
                // 这里乘以 -1 是为了设置正确平移方向
                // 举例子说明： 要是self.targetEdge == UIRectEdgeRight 这个时候说明你是从右边开始滑动的(为什么是右边看前面解释，设置这个UIRectEdgeRight表示响应右边滑动事件)
                // 这个时候我们设置的offset = CGVectorMake(-1.f, 0.f);这个矢量的方向就是-1 到 0 ，你画一个矢量箭头就知道它是向右的，我们的要求确实是要向左边滑动，这个你就理解为什么要 * -1了
                // 当然你也可以在上面offset设置的时候设置反方向，理解就行
                
                fromView.frame = fromFrame;
                toView.frame   = CGRectOffset(toFrame, toFrame.size.width * offset.dx * -1,
                                            toFrame.size.height * offset.dy * -1);
        }else{
        
                fromView.frame = fromFrame;
                toView.frame   = toFrame;
        }
        
        UIView * contentView = transitionContext.containerView;
        if (isPresenting)
                
                [contentView addSubview:toView];
        else
                
                // 在contentView  把toView插入到fromView的下面去
                [contentView insertSubview:toView belowSubview:fromView];
        
        /**
         
           理解一下这个动画是怎么产生的，你看了我下面 A present B  的输出打印日志你就理解了
         (lldb) po toView.frame
         (origin = (x = 0, y = 0), size = (width = 375, height = 667))
         
         (lldb) po toFrame.size.width * offset.dx * -1
         375
         
         (lldb) po toView.frame
         (origin = (x = 375, y = 0), size = (width = 375, height = 667))
         
         (lldb) po toFrame
         (origin = (x = 0, y = 0), size = (width = 375, height = 667))
        
        */
        
        NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];

        [UIView animateWithDuration:transitionDuration animations:^{
           
                if (isPresenting) {
                        
                        toView.frame = toFrame;
                        
                } else {

                        fromView.frame = CGRectOffset(fromFrame, fromFrame.size.width * offset.dx,
                                                      fromFrame.size.height * offset.dy);
                }
                
        } completion:^(BOOL finished) {
              
                // 转场取消了，删除toView
                BOOL wasCancelled = [transitionContext transitionWasCancelled];
                if (wasCancelled) {
                        
                     [toView removeFromSuperview];
                }
                
                [transitionContext completeTransition:!wasCancelled];
        }];
}

@end
