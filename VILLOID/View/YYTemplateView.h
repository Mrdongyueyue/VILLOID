//
//  YYTemplateView.h
//  VILLOID
//
//  Created by 董知樾 on 2017/3/10.
//  Copyright © 2017年 董知樾. All rights reserved.
//
#import <UIKit/UIKit.h>

@class YYTemplateView,YYTemplateLayout;

@protocol YYTemplateViewDelegate <NSObject>

@optional
- (UIView *)templateView:(YYTemplateView *)templateView itemAtIndex:(NSInteger)index;
- (void)templateView:(YYTemplateView *)templateView willDisplayItem:(UIView *)item forItemAtIndex:(NSInteger)index;
- (void)templateView:(YYTemplateView *)templateView exchangeItemAtIndex:(NSInteger)index1 withIndex:(NSInteger)index2;


@end

@interface YYTemplateView : UIView

@property (assign, nonatomic, readonly) NSUInteger rowNumber;

@property (assign, nonatomic, readonly) NSUInteger arrangeNumber;

///defalut zero
@property (assign, nonatomic) UIEdgeInsets edgeInsets;

///defalut 10
@property (assign, nonatomic) CGFloat verticalMargin;

///defalut 10
@property (assign, nonatomic) CGFloat horizontalMargin;

@property (strong, nonatomic) YYTemplateLayout *templateLayout;

@property (weak, nonatomic) id<YYTemplateViewDelegate> delegate;

- (void)reloadData;
- (void)reloadWithIndexSet:(NSIndexSet *)indexSet;

@end
