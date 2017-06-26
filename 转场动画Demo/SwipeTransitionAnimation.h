//
//  SwipeTransitionAnimation.h
//  转场动画Demo
//
//  Created by SKOTC on 17/6/15.
//  Copyright © 2017年 CAOMEI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SwipeTransitionAnimation : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, readwrite) UIRectEdge targetEdge;

- (instancetype)initWithTargetEdge:(UIRectEdge)targetEdge;

@end
