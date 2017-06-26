//
//  SpringToViewController.m
//  转场动画Demo
//
//  Created by SKOTC on 17/6/22.
//  Copyright © 2017年 CAOMEI. All rights reserved.
//

#import "SpringToViewController.h"
#import "SpringTrasitionAnimation.h"

@interface SpringToViewController ()<UIViewControllerTransitioningDelegate>

@property(nonatomic,strong) UIButton * presentNextController;

@end

@implementation SpringToViewController

- (instancetype)init
{
        self = [super init];
        if (self) {
                
                self.transitioningDelegate = self;
                self.modalPresentationStyle = UIModalPresentationCustom;
                // 没有设置的话确实会造成presentVC被移除，需要dimiss时再添加（即使不添加也没问题只是会有一个淡出的动画），但是我测试的时候如果设置了的话，dismiss结束后presentVC也消失了
        }
        return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
        self.view.backgroundColor =[UIColor yellowColor];
        
        [self.view addSubview:self.presentNextController];

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
        
        [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
        
        return [[SpringTrasitionAnimation alloc]init];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
        
        return [[SpringTrasitionAnimation alloc]init];
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
