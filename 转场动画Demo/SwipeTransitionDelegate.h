//
//  SwipeTransitionDelegate.h
//  转场动画Demo
//
//  Created by SKOTC on 17/6/15.
//  Copyright © 2017年 CAOMEI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//UIViewControllerTransitioningDelegate 转场代理
@interface SwipeTransitionDelegate : NSObject<UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer * gestureRecognizer;
@property (nonatomic, readwrite) UIRectEdge targetEdge;

@end
