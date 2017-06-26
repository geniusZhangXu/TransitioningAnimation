//
//  PageFromViewController.m
//  转场动画Demo
//
//  Created by SKOTC on 17/6/23.
//  Copyright © 2017年 CAOMEI. All rights reserved.
//

#import "PageFromViewController.h"
#import "PageToViewController.h"


@interface PageFromViewController ()

@property(nonatomic,strong) UIButton * leftItem;
@property(nonatomic,strong) UIButton * presentNextController;


@end

@implementation PageFromViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftItem];
        
        self.view.backgroundColor =[UIColor whiteColor];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sccnn.jpg"]];
        imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        imageView.layer.cornerRadius = 10;
        imageView.layer.masksToBounds = YES;
        [self.view addSubview:imageView];
        
        [self.view addSubview:self.presentNextController];
        
}


-(void)presentNextControllerClicked{
        
        PageToViewController *  springToViewController =[[PageToViewController alloc]init];
        [self presentViewController:springToViewController animated:YES completion:NULL];
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
