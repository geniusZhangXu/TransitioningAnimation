//
//  CollectionViewCell.m
//  转场动画Demo
//
//  Created by SKOTC on 17/6/14.
//  Copyright © 2017年 CAOMEI. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
        self = [super initWithFrame:frame];
        if (self) {
                
                [self.contentView addSubview:self.titleLabel];
        }
        return self;
}

-(UILabel *)titleLabel{

        if (!_titleLabel) {
                
                _titleLabel =[[UILabel alloc]initWithFrame:CGRectMake(0,30, 80, 20)];
                _titleLabel.textColor =[UIColor blackColor];
                _titleLabel.font =[UIFont systemFontOfSize:16];
                _titleLabel.textAlignment = 1;
        }
        return _titleLabel;
}

@end
