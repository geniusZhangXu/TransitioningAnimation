//
//  SwipeToViewController.m
//  转场动画Demo
//
//  Created by SKOTC on 17/6/14.
//  Copyright © 2017年 CAOMEI. All rights reserved.
//

#import "SwipeToViewController.h"
#import "SwipeTransitionDelegate.h"

@interface SwipeToViewController ()

@property(nonatomic,strong) UIButton * presentNextController;

@end

@implementation SwipeToViewController

- (void)viewDidLoad {
        [super viewDidLoad];
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor =[UIColor yellowColor];
        [self.view addSubview:self.presentNextController];

        UIScreenEdgePanGestureRecognizer *interactiveTransitionRecognizer;
        interactiveTransitionRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(interactiveTransitionRecognizerAction:)];
        interactiveTransitionRecognizer.edges = UIRectEdgeLeft;
        [self.view addGestureRecognizer:interactiveTransitionRecognizer];
        
}


-(void)interactiveTransitionRecognizerAction:(UIScreenEdgePanGestureRecognizer *)sender{
        
        if(sender.state == UIGestureRecognizerStateBegan){
              
                if ([self.transitioningDelegate isKindOfClass:SwipeTransitionDelegate.class])
                {
                        SwipeTransitionDelegate *transitionDelegate = self.transitioningDelegate;
                        
                        if ([sender isKindOfClass:UIGestureRecognizer.class])
                                
                        transitionDelegate.gestureRecognizer = sender;
                        
                        transitionDelegate.targetEdge = UIRectEdgeLeft;
                        
                        [self dismissViewControllerAnimated:YES completion:nil];

                }
        }
}


-(UIButton *)presentNextController{
        
        if (!_presentNextController) {
                
                _presentNextController = [UIButton buttonWithType:UIButtonTypeCustom];
                _presentNextController.frame = CGRectMake(138,323,100, 20);
                [_presentNextController setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [_presentNextController setTitle:@"完成" forState:UIControlStateNormal];
                [_presentNextController addTarget:self action:@selector(presentNextControllerClicked) forControlEvents:UIControlEventTouchUpInside];
        }
        return _presentNextController;
}


-(void)presentNextControllerClicked{
        
        SwipeTransitionDelegate *transitionDelegate = self.transitioningDelegate;
        transitionDelegate.gestureRecognizer = nil;
        transitionDelegate.targetEdge = UIRectEdgeLeft;
        [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
