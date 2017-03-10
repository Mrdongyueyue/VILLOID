//
//  YYCollectionViewCell.m
//  VILLOID
//
//  Created by 董知樾 on 2017/3/10.
//  Copyright © 2017年 董知樾. All rights reserved.
//

#import "YYCollectionViewCell.h"

#import "YYTemplateView.h"

@interface YYCollectionViewCell()

@property (strong, nonatomic) YYTemplateView *templateView;

@end

@implementation YYCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubviews];
        self.contentView.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}

- (void)createSubviews {
    _templateView = [[YYTemplateView alloc]initWithFrame:CGRectMake(0, 0, 365, 365)];
    [self.contentView addSubview:_templateView];
}

- (void)setTemplateLayout:(YYTemplateLayout *)templateLayout {
    _templateLayout = templateLayout;
    _templateView.templateLayout = templateLayout;
}

@end
