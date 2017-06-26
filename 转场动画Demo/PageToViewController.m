//
//  PageToViewController.m
//  转场动画Demo
//
//  Created by SKOTC on 17/6/23.
//  Copyright © 2017年 CAOMEI. All rights reserved.
//

#import "PageToViewController.h"

@interface PageToViewController ()

@property(nonatomic,strong) UIButton * leftItem;
@property(nonatomic,strong) UIButton * presentNextController;

@end

@implementation PageToViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
        
        self.view.backgroundColor =[UIColor whiteColor];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"123.jpg"]];
        imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        imageView.layer.cornerRadius = 10;
        imageView.layer.masksToBounds = YES;
        [self.view addSubview:imageView];
        
        [self.view addSubview:self.presentNextController];
        
}


#pragma mark - UI 
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
