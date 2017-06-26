//
//  RoundDotFromViewController.m
//  转场动画Demo
//
//  Created by SKOTC on 17/6/23.
//  Copyright © 2017年 CAOMEI. All rights reserved.
//

#import "RoundDotFromViewController.h"
#import "RoundDotToViewController.h"

@interface RoundDotFromViewController ()

@property(nonatomic,strong) UIButton * leftItem;

@end

@implementation RoundDotFromViewController

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


#pragma mark -   UI
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


-(UIButton *)presentNextController{
        
        if (!_presentNextController) {
                
                _presentNextController = [UIButton buttonWithType:UIButtonTypeCustom];
                _presentNextController.backgroundColor = [UIColor grayColor];
                _presentNextController.titleLabel.numberOfLines = 0;
                _presentNextController.titleLabel.textAlignment = 1;
                _presentNextController.layer.cornerRadius = 30;
                _presentNextController.layer.masksToBounds = YES;
                _presentNextController.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
                _presentNextController.titleLabel.font = [UIFont systemFontOfSize:13];

                _presentNextController.frame = CGRectMake(self.view.frame.size.width-60, self.view.frame.size.height-150, 60, 60);
                
                [_presentNextController setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [_presentNextController setTitle:@"点击\n拖动" forState:UIControlStateNormal];
                [_presentNextController addTarget:self action:@selector(presentNextControllerClicked) forControlEvents:UIControlEventTouchUpInside];
                
                UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(_presentNextControllerPan:)];
                [_presentNextController addGestureRecognizer:pan];
             
        }
        return _presentNextController;
}


-(void)_presentNextControllerPan:(UIPanGestureRecognizer *)recognizer{


        // Figure out where the user is trying to drag the view.
        // http://www.jianshu.com/p/be29e46fb2c4
        // 帮助区分 translationInView  locationInView   velocityInView 三个方法
        CGPoint translation = [recognizer translationInView:self.view];
        CGPoint newCenter   = CGPointMake(recognizer.view.center.x + translation.x,
                                          recognizer.view.center.y + translation.y);
        // 限制屏幕范围：
        newCenter.y = MAX(recognizer.view.frame.size.height/2, newCenter.y);
        newCenter.y = MIN(self.view.frame.size.height - recognizer.view.frame.size.height/2, newCenter.y);
        newCenter.x = MAX(recognizer.view.frame.size.width/2, newCenter.x);
        newCenter.x = MIN(self.view.frame.size.width - recognizer.view.frame.size.width/2,newCenter.x);
        recognizer.view.center = newCenter;
        [recognizer setTranslation:CGPointZero inView:self.view];

}


-(void)presentNextControllerClicked{
        
        RoundDotToViewController *  springToViewController =[[RoundDotToViewController alloc]init];
        [self presentViewController:springToViewController animated:YES completion:NULL];
}


-(void)backClicked{
        
        [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated
        
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
