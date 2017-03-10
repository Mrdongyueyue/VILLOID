//
//  YYItemCoordinate.m
//  VILLOID
//
//  Created by 董知樾 on 2017/3/7.
//  Copyright © 2017年 董知樾. All rights reserved.
//

#import "YYItemCoordinate.h"

@implementation YYItemCoordinate

+ (instancetype)yy_itemCoordinateMakeWithX:(NSNumber *)x y:(NSNumber *)y w:(NSNumber *)w h:(NSNumber *)h {
    YYItemCoordinate *item = [[YYItemCoordinate alloc] init];
    item.x = x;
    item.x = y;
    item.x = w;
    item.x = h;
    return item;
}

+ (instancetype)yy_itemCoordinateWithDict:(NSDictionary *)dict {
    YYItemCoordinate *item = [[YYItemCoordinate alloc] init];
    item.x = dict[@"x"];
    item.y = dict[@"y"];
    item.w = dict[@"w"];
    item.h = dict[@"h"];
    return item;
}

+ (NSArray <__kindof YYItemCoordinate *>*)yy_itemCoordinatesWithArray:(NSArray *)array {
    NSMutableArray *arr = [NSMutableArray array];
    
    for (NSDictionary *dict in array) {
        [arr addObject:[YYItemCoordinate yy_itemCoordinateWithDict:dict]];
    }
    
    return arr;
}


@end
