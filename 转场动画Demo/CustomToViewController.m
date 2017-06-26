//
//  CustomToViewController.m
//  转场动画Demo
//
//  Created by SKOTC on 17/6/16.
//  Copyright © 2017年 CAOMEI. All rights reserved.
//

#import "CustomToViewController.h"

@interface CustomToViewController ()

@property(nonatomic,strong) UIButton * presentNextController;
@property(nonatomic,strong) UISlider * slider;

@end

@implementation CustomToViewController

- (void)viewDidLoad {
        
        [super viewDidLoad];
        // Do any additional setup after loading the view.
        self.view.backgroundColor =[UIColor yellowColor];
        [self.view addSubview:_slider];

        self.preferredContentSize = CGSizeMake(self.view.bounds.size.width, self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact ? 270 : 420);
}


-(void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
        
        [super willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];
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
