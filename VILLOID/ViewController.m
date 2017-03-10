//
//  ViewController.m
//  VILLOID
//
//  Created by 董知樾 on 2017/3/7.
//  Copyright © 2017年 董知樾. All rights reserved.
//


#import "ViewController.h"
#import "YYTemplateLayout.h"
#import "YYCollectionViewCell.h"
#import "YYLayoutDefine.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) NSArray<__kindof YYTemplateLayout *> *templateLayouts;

@property (strong, nonatomic) UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _templateLayouts = [YYTemplateLayout yy_itemTemplateLayout];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(365, 365);
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 40, 375, 370) collectionViewLayout:layout];
    [self.view addSubview:_collectionView];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [_collectionView registerClass:[YYCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    _collectionView.pagingEnabled = YES;
    _collectionView.backgroundColor = [UIColor whiteColor];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _templateLayouts.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(YYCollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    cell.templateLayout = _templateLayouts[indexPath.item];
}


@end
