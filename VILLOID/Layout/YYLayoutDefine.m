//
//  YYLayoutDefine.m
//  VILLOID
//
//  Created by 董知樾 on 2017/3/10.
//  Copyright © 2017年 董知樾. All rights reserved.
//

#import "YYLayoutDefine.h"

@implementation YYLayoutDefine
NSArray * getLayoutDafines() {
    
    NSArray *array = @[@{
                           @"rowNumber":@(3),
                           @"arrangeNumber":@(3),
                           @"itemCoordinaties":@[@{@"x":@(0),@"y":@(0),@"w":@(1),@"h":@(1)},
                                                 @{@"x":@(0),@"y":@(1),@"w":@(1),@"h":@(1)},
                                                 @{@"x":@(0),@"y":@(2),@"w":@(1),@"h":@(1)},
                                                 @{@"x":@(1),@"y":@(0),@"w":@(1),@"h":@(1)},
                                                 @{@"x":@(1),@"y":@(1),@"w":@(1),@"h":@(1)},
                                                 @{@"x":@(1),@"y":@(2),@"w":@(1),@"h":@(1)},
                                                 @{@"x":@(2),@"y":@(0),@"w":@(1),@"h":@(1)},
                                                 @{@"x":@(2),@"y":@(1),@"w":@(1),@"h":@(1)},
                                                 @{@"x":@(2),@"y":@(2),@"w":@(1),@"h":@(1)},
                                                 ]
                           },
                       @{
                           @"rowNumber":@(3),
                           @"arrangeNumber":@(3),
                           @"itemCoordinaties":@[@{@"x":@(0),@"y":@(0),@"w":@(2),@"h":@(1)},
                                                 @{@"x":@(2),@"y":@(0),@"w":@(1),@"h":@(1)},
                                                 @{@"x":@(0),@"y":@(1),@"w":@(2),@"h":@(1)},
                                                 @{@"x":@(2),@"y":@(1),@"w":@(1),@"h":@(2)},
                                                 @{@"x":@(0),@"y":@(2),@"w":@(2),@"h":@(1)},
                                                 ],
                           },
                       @{
                           @"rowNumber":@(3),
                           @"arrangeNumber":@(3),
                           @"itemCoordinaties":@[@{@"x":@(0),@"y":@(0),@"w":@(1),@"h":@(3)},
                                                 @{@"x":@(1),@"y":@(0),@"w":@(2),@"h":@(2)},
                                                 @{@"x":@(1),@"y":@(2),@"w":@(2),@"h":@(1)},
                                                 ],
                           },
                       @{
                           @"rowNumber":@(3),
                           @"arrangeNumber":@(3),
                           @"itemCoordinaties":@[@{@"x":@(0),@"y":@(0),@"w":@(1),@"h":@(2)},
                                                 @{@"x":@(1),@"y":@(0),@"w":@(2),@"h":@(2)},
                                                 @{@"x":@(0),@"y":@(2),@"w":@(1),@"h":@(1)},
                                                 @{@"x":@(1),@"y":@(2),@"w":@(2),@"h":@(1)},
                                                 ]
                           },
                       @{
                           @"rowNumber":@(2),
                           @"arrangeNumber":@(2),
                           @"itemCoordinaties":@[@{@"x":@(0),@"y":@(0),@"w":@(1),@"h":@(1)},
                                                 @{@"x":@(0),@"y":@(1),@"w":@(1),@"h":@(1)},
                                                 @{@"x":@(1),@"y":@(0),@"w":@(1),@"h":@(1)},
                                                 @{@"x":@(1),@"y":@(1),@"w":@(1),@"h":@(1)},
                                                 ]
                           },
                       @{
                           @"rowNumber":@(2),
                           @"arrangeNumber":@(2),
                           @"itemCoordinaties":@[@{@"x":@(0),@"y":@(0),@"w":@(1),@"h":@(2)},
                                                 @{@"x":@(1),@"y":@(0),@"w":@(1),@"h":@(2)},
                                                 ]
                           },
                       @{
                           @"rowNumber":@(2),
                           @"arrangeNumber":@(2),
                           @"itemCoordinaties":@[@{@"x":@(0),@"y":@(0),@"w":@(1),@"h":@(2)},
                                                 @{@"x":@(1),@"y":@(0),@"w":@(1),@"h":@(1)},
                                                 @{@"x":@(1),@"y":@(1),@"w":@(1),@"h":@(1)},
                                                 ]
                           },
                       ];
    return array;
}

void createPlist() {
    NSArray *array = getLayoutDafines();
    [array writeToFile:@"/Users/dongzhiyue/Desktop/layout.plist" atomically:YES];
}

@end
