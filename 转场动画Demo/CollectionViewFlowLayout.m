//
//  CollectionViewFlowLayout.m
//  转场动画Demo
//
//  Created by SKOTC on 17/6/14.
//  Copyright © 2017年 CAOMEI. All rights reserved.
//

#import "CollectionViewFlowLayout.h"

@implementation CollectionViewFlowLayout


-(void)prepareLayout{
        
        [super prepareLayout];
        // 计算第一组item的个数
        NSInteger countSum =  [self.collectionView numberOfItemsInSection:0];
        _attributeAttay =[NSMutableArray array];
        // 先设置半径
        CGFloat radius = MIN([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width/2);
        CGPoint center = CGPointMake(self.collectionView.frame.size.width/2, self.collectionView.frame.size.height/2);
        
        // 设置每一个Item的属性
        for (int i =0;i<countSum; i++) {
                
                UICollectionViewLayoutAttributes *  attributes =[UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
                
                attributes.size = CGSizeMake(80, 80);
                
                // 设置每一个Item的位置,根据大圆的位置设置小圆的位置
                CGFloat x =  center.x + ((radius - 40) * sin(2*M_PI/countSum * i));
                CGFloat y =  center.y + ((radius - 40) * cos(2*M_PI/countSum * i));

                attributes.center = CGPointMake(x, y);
                
                [_attributeAttay addObject:attributes];
        }
}

// 返回属性
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
   
        return _attributeAttay;
}

//设置内容区域的大小
-(CGSize)collectionViewContentSize{
        
        return self.collectionView.frame.size;
}

@end
