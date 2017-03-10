//
//  YYTemplateView.h
//  VILLOID
//
//  Created by 董知樾 on 2017/3/10.
//  Copyright © 2017年 董知樾. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYTemplateLayout;

@interface YYTemplateView : UIView

///defalut 3
@property (assign, nonatomic) NSUInteger rowNumber;

///defalut 3
@property (assign, nonatomic) NSUInteger arrangeNumber;

///defalut zero
@property (assign, nonatomic) UIEdgeInsets edgeInsets;

///defalut 10
@property (assign, nonatomic) CGFloat verticalMargin;

///defalut 10
@property (assign, nonatomic) CGFloat horizontalMargin;

@property (strong, nonatomic) YYTemplateLayout *templateLayout;

@end
