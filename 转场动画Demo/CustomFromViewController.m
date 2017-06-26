//
//  CustomFromViewController.m
//  转场动画Demo
//
//  Created by SKOTC on 17/6/16.
//  Copyright © 2017年 CAOMEI. All rights reserved.
//

#import "CustomFromViewController.h"
#import "CustomToViewController.h"
#import "CustomPresentationController.h"


@interface CustomFromViewController ()

@property(nonatomic,strong) UIButton * leftItem;
@property(nonatomic,strong) UIButton * presentNextController;

@end

@implementation CustomFromViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
        
        
        self.view.backgroundColor =[UIColor whiteColor];
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftItem];
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


-(void)presentNextControllerClicked{
        
        
        CustomToViewController * customToViewController =[[CustomToViewController alloc]init];
        
        // CustomPresentationController 这个是继承自UIPresentationController
        // 遵守了UIViewControllerTransitioningDelegate协议
        // 遵守了UIViewControllerAnimatedTransitioning协议
        
        CustomPresentationController * customPresentationController;
        customPresentationController = [[CustomPresentationController alloc]initWithPresentedViewController:customToViewController presentingViewController:self];
        
        customToViewController.transitioningDelegate = customPresentationController;
        
        [self presentViewController:customToViewController animated:YES completion:nil];
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
