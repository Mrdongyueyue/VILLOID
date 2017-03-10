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

@property (assign, nonatomic) UIEdgeInsets edgeInsets;

@property (strong, nonatomic) YYTemplateLayout *templateLayout;

@end
