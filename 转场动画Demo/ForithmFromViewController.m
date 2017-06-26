//
//  ForithmFromViewController.m
//  转场动画Demo
//
//  Created by SKOTC on 17/6/14.
//  Copyright © 2017年 CAOMEI. All rights reserved.
//

#import "ForithmFromViewController.h"
#import "ForithmToViewController.h"
#import "ForithmAnimation.h"

@interface ForithmFromViewController ()<UIViewControllerTransitioningDelegate>

@property(nonatomic,strong) UIButton * leftItem;
@property(nonatomic,strong) UIButton * presentNextController;

@end

@implementation ForithmFromViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
        self.view.backgroundColor =[UIColor whiteColor];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftItem];
        //
        [self.view addSubview:self.presentNextController];
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

        // 跳转到这个控制器ForithmToViewController，当然是继承与UIViewController
        ForithmToViewController * toViewController =[[ForithmToViewController alloc]init];
        toViewController.modalPresentationStyle  = UIModalPresentationFullScreen;
        
        // NOTE:转场的关键就是这个代理 transitioningDelegate
        // 指定了这个代理就需要遵守UIViewControllerTransitioningDelegate这个协议
        // 协议里面的东西点进去可以仔细看看，我们指定toViewController的transitioningDelegate是我们的ForithmFromViewController，也就是
        // fromViewController，这样我们的fromViewController就要遵守这个协议
        toViewController.transitioningDelegate = self;
        [self presentViewController:toViewController animated:YES completion:nil];
}


#pragma mark - UIViewControllerTransitioningDelegate

/*
 不管是 present 还是dismiss
 要是调用interactionControllerForPresentation 或者是 interactionControllerForDismissal
 返回值是nil,就会走下面animationControllerForPresentedController和animationControllerForDismissedController方法
 要是不是nil,就不会走下面这两个方法了， 在我们这里也就是用手势测试的时候是不会走的，点击present或者是dismiss会走
 */
// 这个方法返回一个遵守 <UIViewControllerAnimatedTransitioning> 协议的对象
// 其实返回的就是PresentedController控制器的动画
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{

        return [ForithmAnimation new];
}

// 这个方法和上面的解释是类似的，只不过这里的控制器就是DismissedController
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{

        //ForithmAnimation 遵守 UIViewControllerAnimatedTransitioning 协议
        return [ForithmAnimation new];
}


/*
// UIKit还会调用代理的interactionControllerForPresentation:方法来获取交互式控制器，如果得到了nil则执行非交互式动画
// 如果获取到了不是nil的对象，那么UIKit不会调用animator的animateTransition方法，而是调用交互式控制器的startInteractiveTransition:方法。
- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator{};

// 这个方法是在dismiss的时候的时候调用，也是交互转场执行的时候
- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator{};

// 这个方法的返回值是UIPresentationController
// UIPresentationController提供了四个函数来定义present和dismiss动画开始前后的操作,这个我们再下面再具体的详细说
- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source NS_AVAILABLE_IOS(8_0){};
*/

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
