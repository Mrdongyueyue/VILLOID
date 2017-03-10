//
//  YYTemplateLayout.h
//  VILLOID
//
//  Created by 董知樾 on 2017/3/7.
//  Copyright © 2017年 董知樾. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YYItemCoordinate.h"

@interface YYTemplateLayout : NSObject

@property (strong, nonatomic) NSNumber *rowNumber;
@property (strong, nonatomic) NSNumber *arrangeNumber;

@property (strong, nonatomic) NSArray<__kindof YYItemCoordinate *> *itemCoordinaties;

+ (NSArray <__kindof YYTemplateLayout *> *)yy_itemTemplateLayout;

@end
