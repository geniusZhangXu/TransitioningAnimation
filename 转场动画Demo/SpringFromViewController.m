//
//  SpringFromViewController.m
//  转场动画Demo
//
//  Created by SKOTC on 17/6/22.
//  Copyright © 2017年 CAOMEI. All rights reserved.
//

#import "SpringFromViewController.h"
#import "SpringToViewController.h"
#import "SpringTrasitionAnimation.h"

@interface SpringFromViewController ()

@property(nonatomic,strong) UIButton * leftItem;
@property(nonatomic,strong) UIButton * presentNextController;

@end

@implementation SpringFromViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        // Do any additional setup after loading the view.
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftItem];

        self.view.backgroundColor =[UIColor whiteColor];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sccnn.jpg"]];
        imageView.frame = CGRectMake((self.view.frame.size.width-250)/2, 74, 250, 250);
        imageView.layer.cornerRadius = 10;
        imageView.layer.masksToBounds = YES;
        [self.view addSubview:imageView];
        
        [self.view addSubview:self.presentNextController];
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


#pragma mark -
-(UIButton *)presentNextController{
        
        if (!_presentNextController) {
                
                _presentNextController = [UIButton buttonWithType:UIButtonTypeCustom];
                _presentNextController.frame = CGRectMake(138,423,100, 20);
                [_presentNextController setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [_presentNextController setTitle:@"弹性POP" forState:UIControlStateNormal];
                [_presentNextController addTarget:self action:@selector(presentNextControllerClicked) forControlEvents:UIControlEventTouchUpInside];
        }
        return _presentNextController;
}


-(void)presentNextControllerClicked{
        
        SpringToViewController *  springToViewController =[[SpringToViewController alloc]init];
        [self presentViewController:springToViewController animated:YES completion:NULL];
}



-(void)backClicked{
        
        [self dismissViewControllerAnimated:YES completion:nil];
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
