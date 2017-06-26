//
//  ViewController.m
//  转场动画Demo
//
//  Created by SKOTC on 17/6/14.
//  Copyright © 2017年 CAOMEI. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewFlowLayout.h"
#import "CollectionViewCell.h"
#import "ForithmFromViewController.h"
#import "SwipeFromViewController.h"
#import "CustomFromViewController.h"
#import "SpringFromViewController.h"
#import "RoundDotFromViewController.h"


static NSString * const Identifier  = @"collectionView";
 
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong) UICollectionView * collectionView;
@property(nonatomic,strong) NSArray * collectionViewTitleArray;

@end

@implementation ViewController

-(void)viewDidLoad{
    
        [super viewDidLoad];
        [self.view addSubview:self.collectionView];
        [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:Identifier];
        
        _collectionViewTitleArray = @[@"逐渐出现",@"右滑拉动",@"底部卡片",@"弹性POP",@"圆点扩散",@"翻页效果"];
}


- (void)didReceiveMemoryWarning {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
        
        return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
        
        return 6;
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
        
        CollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:Identifier forIndexPath:indexPath];
        cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0];
        cell.layer.masksToBounds = YES;
        cell.layer.cornerRadius = 40;
        cell.titleLabel.text = self.collectionViewTitleArray[indexPath.row];
        return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

        switch (indexPath.row) {
                case 0:{
                        
                        // 逐渐显示自定义转场
                        ForithmFromViewController * controlller =  [[ForithmFromViewController alloc]init];
                        UINavigationController * naController = [[UINavigationController alloc]initWithRootViewController:controlller];
                        [self presentViewController:naController animated:YES completion:nil];
                       }
                        break;
                        
                case 1:{
                        
                        // 逐渐显示自定义转场
                        SwipeFromViewController * controlller =  [[SwipeFromViewController alloc]init];
                        UINavigationController * naController = [[UINavigationController alloc]initWithRootViewController:controlller];
                        [self presentViewController:naController animated:YES completion:nil];
                       }
                        break;
        
                case 2:{
                        
                        // 底部卡片自定义转场
                        CustomFromViewController * controlller =  [[CustomFromViewController alloc]init];
                        UINavigationController * naController = [[UINavigationController alloc]initWithRootViewController:controlller];
                        [self presentViewController:naController animated:YES completion:nil];
                        }
                        break;
                case 3:{
                        
                        //弹性POP
                        SpringFromViewController * controlller =  [[SpringFromViewController alloc]init];
                        UINavigationController * naController = [[UINavigationController alloc]initWithRootViewController:controlller];
                        [self presentViewController:naController animated:YES completion:nil];
                }
                        break;
                case 4:{
                        
                        //圆点扩散
                        RoundDotFromViewController * controlller =  [[RoundDotFromViewController alloc]init];
                        UINavigationController * naController = [[UINavigationController alloc]initWithRootViewController:controlller];
                        [self presentViewController:naController animated:YES completion:nil];
                }
                        break;
                default:
                        break;
        }

}



-(UICollectionView *)collectionView{

        if (!_collectionView) {
            
                CollectionViewFlowLayout * layout = [[CollectionViewFlowLayout alloc]init];
                _collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
                _collectionView.delegate = self;
                _collectionView.dataSource = self;
                _collectionView.backgroundColor =[UIColor whiteColor];
        }
        return _collectionView;
}


@end
