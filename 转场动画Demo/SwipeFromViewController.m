//
//  SwipeFromViewController.m
//  转场动画Demo
//
//  Created by SKOTC on 17/6/14.
//  Copyright © 2017年 CAOMEI. All rights reserved.
//

#import "SwipeFromViewController.h"
#import "SwipeToViewController.h"
#import "SwipeTransitionDelegate.h"


@interface SwipeFromViewController ()

@property(nonatomic,strong) UIButton * leftItem;
@property(nonatomic,strong) UIButton * presentNextController;
@property(nonatomic,strong) SwipeTransitionDelegate * delegate;

@end

@implementation SwipeFromViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
        self.view.backgroundColor =[UIColor whiteColor];
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftItem];
        [self.view addSubview:self.presentNextController];
        
        //UIScreenEdgePanGestureRecognizer:UIPanGestureRecognizer
        //添加屏幕边缘滑动手势
        UIScreenEdgePanGestureRecognizer * interactiveTransitionRecognizer;
        interactiveTransitionRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(interactiveTransitionRecognizerAction:)];
        // 响应右边的滑动事件
        interactiveTransitionRecognizer.edges = UIRectEdgeRight;
        [self.view addGestureRecognizer:interactiveTransitionRecognizer];
        
}

#pragma mark  - UIScreenEdgePanGestureRecognizer
- (void)interactiveTransitionRecognizerAction:(UIScreenEdgePanGestureRecognizer *)sender
{
        if (sender.state == UIGestureRecognizerStateBegan){
                
                SwipeToViewController *  ToViewController =[[SwipeToViewController alloc]init];
                SwipeTransitionDelegate * transitionDelegate = self.delegate;
                
                if ([sender isKindOfClass:UIGestureRecognizer.class])
                        
                        transitionDelegate.gestureRecognizer = sender;
                
                transitionDelegate.targetEdge = UIRectEdgeRight;
                ToViewController.transitioningDelegate = transitionDelegate;
                ToViewController.modalPresentationStyle = UIModalPresentationFullScreen;
                
                [self presentViewController:ToViewController animated:YES completion:nil];
                
        }
}


#pragma mark -
-(UIButton *)presentNextController{
        
        if (!_presentNextController) {
                
                _presentNextController = [UIButton buttonWithType:UIButtonTypeCustom];
                _presentNextController.frame = CGRectMake(138,323,100, 20);
                [_presentNextController setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [_presentNextController setTitle:@"点击跳转->" forState:UIControlStateNormal];
                [_presentNextController addTarget:self action:@selector(presentNextControllerClicked) forControlEvents:UIControlEventTouchUpInside];
        }
        return _presentNextController;
}


-(void)presentNextControllerClicked{
        
        SwipeToViewController   *  ToViewController  = [[SwipeToViewController alloc]init];
        
        SwipeTransitionDelegate * transitionDelegate = self.delegate;
        transitionDelegate.targetEdge = UIRectEdgeRight;
        transitionDelegate.gestureRecognizer = nil;
        
        ToViewController.transitioningDelegate  = transitionDelegate;
        ToViewController.modalPresentationStyle = UIModalPresentationFullScreen;
        
        [self presentViewController:ToViewController animated:YES completion:nil];
}


-(SwipeTransitionDelegate *)delegate{

        if (!_delegate) {
                
            _delegate =[[SwipeTransitionDelegate alloc]init];
                
        }
        return _delegate;
}

#pragma mark -
-(UIButton *)leftItem{
        
        if (!_leftItem) {
                
                _leftItem = [UIButton buttonWithType:UIButtonTypeCustom];
                _leftItem.frame = CGRectMake(0, 0,50, 20);
                [_leftItem setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [_leftItem setTitle:@"Back" forState:UIControlStateNormal];
                [_leftItem addTarget:self action:@selector(backClicked) forControlEvents:UIControlEventTouchUpInside];
        }
        return _leftItem;
}

-(void)backClicked{
        
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
