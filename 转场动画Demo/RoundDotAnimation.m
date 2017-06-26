//
//  RoundDotAnimation.m
//  转场动画Demo
//
//  Created by SKOTC on 17/6/23.
//  Copyright © 2017年 CAOMEI. All rights reserved.
//

#import "RoundDotAnimation.h"
#import "RoundDotFromViewController.h"

@implementation RoundDotAnimation

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{

      return 0.5;

}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{

        UIViewController * fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController * toViewController   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        BOOL isPresent = (toViewController.presentingViewController == fromViewController);
        
        
        if (isPresent) {
         
                [self presentViewController:transitionContext];
                _isPresentOrDismiss = YES;
        }else{
                
                [self dismissViewController:transitionContext];
                _isPresentOrDismiss = NO;
        }
}


-(void)presentViewController:(id <UIViewControllerContextTransitioning>)transitionContext{
        

        UIViewController * toViewController= [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        
        // 提一下这里获取UINavigationController的目的是为了能够获取到RoundDotFromViewController控制器
        UINavigationController *fromViewController = (UINavigationController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];

        RoundDotFromViewController * tempViewController = fromViewController.viewControllers.lastObject;
        UIView * containerView = [transitionContext containerView];
        [containerView addSubview:toViewController.view];
        
        // 画一个按钮圆
        UIBezierPath * startCycle =  [UIBezierPath bezierPathWithOvalInRect:tempViewController.presentNextController.frame];
        
        //  选择X或者Y的最大值，解释在博客里
        CGFloat x = MAX(tempViewController.presentNextController.frame.origin.x, containerView.frame.size.width - tempViewController.presentNextController.frame.origin.x);
        CGFloat y = MAX(tempViewController.presentNextController.frame.origin.y, containerView.frame.size.height - tempViewController.presentNextController.frame.origin.y);
        
        // sqrtf 求平方根函数  pow求次方函数，这里的意思是求X的2次方，要是pow(m,9)就是求m的9次方
        CGFloat radius = sqrtf(pow(x, 2) + pow(y, 2));
        
        // UIBezierPath画结束的圆
        UIBezierPath *endCycle = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
        
        //创建CAShapeLayer
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.path = endCycle.CGPath;
        
        //将maskLayer 赋给 toVC.View
        toViewController.view.layer.mask = maskLayer;
        //创建路径动画
        CABasicAnimation * maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
        maskLayerAnimation.delegate = self;
        //动画是加到layer上的，所以必须为CGPath，再将CGPath桥接为OC对象
        maskLayerAnimation.fromValue = (__bridge id)(startCycle.CGPath);
        maskLayerAnimation.toValue   = (__bridge id)((endCycle.CGPath));
        maskLayerAnimation.duration  = [self transitionDuration:transitionContext];
        
        //速度控制函数
        //不理解下面timingFunction函数的的可以看看这个http://www.jianshu.com/p/a4d774315613
        maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [maskLayerAnimation setValue:transitionContext forKey:@"transitionContext"];
        // 添加动画
        [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
        
}

-(void)dismissViewController:(id <UIViewControllerContextTransitioning>)transitionContext{
        
        // 要是理解了present的，dismiss的也就不难理解了
        UIViewController * fromViewController     = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        UINavigationController * toViewController = (UINavigationController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        
        RoundDotFromViewController * tempViewController = toViewController.viewControllers.lastObject;
        UIView *containerView = [transitionContext containerView];
        
        //画两个圆路径，这里的结束和开始时候的画的圆的道理和present的时候正好是相反的
        CGFloat radius = sqrtf(containerView.frame.size.height * containerView.frame.size.height + containerView.frame.size.width * containerView.frame.size.width) / 2;
        UIBezierPath * startCycle = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
        
        // 结束的就是tempViewController.presentNextController.frame的大小
        UIBezierPath *endCycle =  [UIBezierPath bezierPathWithOvalInRect:tempViewController.presentNextController.frame];
        
        //创建CAShapeLayer
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.fillColor = [UIColor greenColor].CGColor;
        maskLayer.path = endCycle.CGPath;
        fromViewController.view.layer.mask = maskLayer;
        
        
        //创建路径动画
        CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
        maskLayerAnimation.delegate  = self;
        maskLayerAnimation.fromValue = (__bridge id)(startCycle.CGPath);
        maskLayerAnimation.toValue   = (__bridge id)((endCycle.CGPath));
        maskLayerAnimation.duration  = [self transitionDuration:transitionContext];
        
        maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [maskLayerAnimation setValue:transitionContext forKey:@"transitionContext"];
        [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
        
}

#pragma mark -  CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{

        
        if (_isPresentOrDismiss) {
        
                // 标记转场结束
                id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
                [transitionContext completeTransition:YES];
                
        }else{
        
                //  
                id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
                [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                if ([transitionContext transitionWasCancelled]) {
                        
                     [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
                }
                
        }
}

@end
