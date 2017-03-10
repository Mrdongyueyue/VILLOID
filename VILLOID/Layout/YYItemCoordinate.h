//
//  YYItemCoordinate.h
//  VILLOID
//
//  Created by 董知樾 on 2017/3/7.
//  Copyright © 2017年 董知樾. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYItemCoordinate : NSObject

@property (assign, nonatomic) NSNumber *x;
@property (assign, nonatomic) NSNumber *y;
@property (assign, nonatomic) NSNumber *w;
@property (assign, nonatomic) NSNumber *h;

+ (instancetype)yy_itemCoordinateMakeWithX:(NSNumber *)x y:(NSNumber *)y w:(NSNumber *)w h:(NSNumber *)h ;

+ (instancetype)yy_itemCoordinateWithDict:(NSDictionary *)dict;

+ (NSArray <__kindof YYItemCoordinate *>*)yy_itemCoordinatesWithArray:(NSArray *)array;

@end
