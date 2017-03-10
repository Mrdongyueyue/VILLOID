//
//  YYTemplateLayout.m
//  VILLOID
//
//  Created by 董知樾 on 2017/3/7.
//  Copyright © 2017年 董知樾. All rights reserved.
//

#import "YYTemplateLayout.h"

@implementation YYTemplateLayout

+ (NSArray <__kindof YYTemplateLayout *> *)yy_itemTemplateLayout {
    NSMutableArray *array = [NSMutableArray array];
    
    NSArray *layouts = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"layout" ofType:@"plist"]];
    for (NSDictionary *layout in layouts) {
        YYTemplateLayout *template = [[YYTemplateLayout alloc]init];
        template.itemCoordinaties = [YYItemCoordinate yy_itemCoordinatesWithArray:layout[@"itemCoordinaties"]];
        template.rowNumber = layout[@"rowNumber"];
        template.arrangeNumber = layout[@"arrangeNumber"];
        [array addObject:template];
    }
    return array;
}

@end
