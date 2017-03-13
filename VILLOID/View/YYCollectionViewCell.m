//
//  YYCollectionViewCell.m
//  VILLOID
//
//  Created by 董知樾 on 2017/3/10.
//  Copyright © 2017年 董知樾. All rights reserved.
//

#import "YYCollectionViewCell.h"

#import "YYTemplateView.h"

@interface YYCollectionViewCell()<YYTemplateViewDelegate>

@property (strong, nonatomic) YYTemplateView *templateView;

@property (strong, nonatomic) NSMutableArray<__kindof UIImage *> *images;


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
    _templateView.delegate = self;
    _images = [NSMutableArray array];
    for (int i = 0; i < 9; i ++) {
        [_images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"IU%d",i]]];
    }
}

- (void)setTemplateLayout:(YYTemplateLayout *)templateLayout {
    _templateLayout = templateLayout;
    _templateView.templateLayout = templateLayout;
}

- (UIView *)templateView:(YYTemplateView *)templateView itemAtIndex:(NSInteger)index {
    UIView *itemView = [[UIView alloc]init];
    itemView.layer.contentsGravity = kCAGravityResizeAspectFill;
    itemView.clipsToBounds = YES;
    return itemView;
}

- (void)templateView:(YYTemplateView *)templateView willDisplayItem:(UIView *)item forItemAtIndex:(NSInteger)index {
    item.layer.contents = (__bridge id _Nullable)(_images[index].CGImage);
}

- (void)templateView:(YYTemplateView *)templateView exchangeItemAtIndex:(NSInteger)index1 withIndex:(NSInteger)index2 {
    [_images exchangeObjectAtIndex:index1 withObjectAtIndex:index2];
    NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc]init];
    [indexSet addIndex:index1];
    [indexSet addIndex:index2];
    [templateView reloadWithIndexSet:indexSet];
}

@end
