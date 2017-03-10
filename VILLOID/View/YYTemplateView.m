//
//  YYTemplateView.m
//  VILLOID
//
//  Created by 董知樾 on 2017/3/10.
//  Copyright © 2017年 董知樾. All rights reserved.
//

#import "YYTemplateView.h"
#import "YYTemplateLayout.h"

@interface YYTemplateView ()

@property (strong, nonatomic) NSMutableArray<__kindof UIView *> *items;

@property (strong, nonatomic) NSMutableArray<__kindof UIImage *> *images;

@property (strong, nonatomic) UIView *moveView;

@property (assign, nonatomic) NSInteger beginIndex;

@property (assign, nonatomic) CGRect beginFrame;

@end

@implementation YYTemplateView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initConfig];
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
        longPress.minimumPressDuration = 1;
        [self addGestureRecognizer:longPress];
    }
    return self;
}

- (void)initConfig {
    _items = [NSMutableArray array];
    _edgeInsets = UIEdgeInsetsZero;
    _rowNumber = 3;
    _arrangeNumber = 3;
    _images = [NSMutableArray array];
    for (int i = 0; i < 9; i ++) {
        [_images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"IU%d",i]]];
    }
    _moveView = [[UIView alloc]init];
    _moveView.clipsToBounds = YES;
    _moveView.layer.contentsGravity = kCAGravityResizeAspectFill;
    [self addSubview:_moveView];
    _moveView.hidden = YES;
}

- (void)setTemplateLayout:(YYTemplateLayout *)templateLayout {
    _templateLayout = templateLayout;
    [self createSubviews];
}


- (void)createSubviews {
    NSInteger difference = _templateLayout.itemCoordinaties.count - _items.count;
    if (difference > 0) {
        for (NSInteger i = 0; i < difference; i ++) {
            UIView *itemView = [[UIView alloc] init];
            itemView.backgroundColor = [UIColor redColor];
            [self insertSubview:itemView belowSubview:_moveView];
            
            itemView.layer.contentsGravity = kCAGravityResizeAspectFill;
            itemView.clipsToBounds = YES;
            [_items addObject:itemView];
        }
    }
    
    for (NSInteger i = 0; i < _items.count; i ++) {
        _items[i].hidden = i >= _templateLayout.itemCoordinaties.count;
    }
    
    
    
    CGFloat verticalMargin = 10;
    CGFloat horizontalMargin = 10;
    CGFloat selfW = self.frame.size.width;
    CGFloat selfH = self.frame.size.height;
    
    CGFloat itemUnitW = (selfW - _edgeInsets.left - _edgeInsets.right - verticalMargin * (_arrangeNumber - 1)) / _arrangeNumber;
    CGFloat itemUnitH = (selfH - _edgeInsets.top - -_edgeInsets.bottom - horizontalMargin * (_rowNumber - 1)) / _rowNumber;
    
    for (NSInteger i = 0; i < _templateLayout.itemCoordinaties.count; i ++) {
        CGFloat x = _templateLayout.itemCoordinaties[i].x.floatValue;
        CGFloat y = _templateLayout.itemCoordinaties[i].y.floatValue;
        CGFloat w = _templateLayout.itemCoordinaties[i].w.floatValue;
        CGFloat h = _templateLayout.itemCoordinaties[i].h.floatValue;
        
        _items[i].frame = CGRectMake(x * (itemUnitW + verticalMargin) + _edgeInsets.left, y * (itemUnitH + horizontalMargin) + _edgeInsets.top, w * itemUnitW + (w - 1) * verticalMargin, h * itemUnitH + (h - 1) * horizontalMargin);
        
    }
    
    [self testConfigContent];
}

- (void)testConfigContent {
    for (NSInteger i = 0; i < _templateLayout.itemCoordinaties.count; i ++) {
        _items[i].layer.contents = (__bridge id _Nullable)(_images[i].CGImage);
    }
}

- (void)longPress:(UILongPressGestureRecognizer *)press {
    switch (press.state) {
        case UIGestureRecognizerStateBegan:{
            //判断手势落点位置是否在路径上
            CGPoint beginPoint = [press locationInView:self];
            BOOL isContain = NO;
            UIView *pointView = nil;
            for (NSInteger i = 0; i < _items.count; i ++) {
                if (_items[i].hidden) {
                    break;
                }
                isContain = CGRectIntersectsRect(_items[i].frame, (CGRect){beginPoint,{1,1}});
                if (isContain) {
                    pointView = _items[i];
                    _beginIndex = i;
                    break;
                }
            }
            if (!isContain) {
                break;
            }
            _moveView.hidden = NO;
            _moveView.frame = pointView.frame;
            _moveView.layer.contents = pointView.layer.contents;
            _beginFrame = _moveView.frame;
        }
        case UIGestureRecognizerStateChanged: {
            
            CGPoint movePoint = [press locationInView:self];
            _moveView.center = movePoint;
            
            BOOL isContain = NO;
            
            for (NSInteger i = 0; i < _items.count; i ++) {
                if (_items[i].hidden) {
                    break;
                }
                isContain = CGRectIntersectsRect(_items[i].frame, (CGRect){movePoint,{1,1}});
                if (isContain && _beginIndex != i) {
                    _moveView.frame = _items[i].frame;
                    break;
                }
            }
            
            break;
        }
            
        case UIGestureRecognizerStateEnded: {
            
            CGPoint endPoint = [press locationInView:self];
            _moveView.center = endPoint;
            
            BOOL isContain = NO;
            NSInteger endIndex = -1;
            
            for (NSInteger i = 0; i < _items.count; i ++) {
                if (_items[i].hidden) {
                    break;
                }
                isContain = CGRectIntersectsRect(_items[i].frame, (CGRect){endPoint,{1,1}});
                if (isContain) {
                    _moveView.frame = _items[i].frame;
                    endIndex = i;
                    break;
                }
            }
            
            if (!isContain) {
                [self moveGoBackOrigin];
            } else {
                if (_beginIndex != endIndex) {
                    [_images exchangeObjectAtIndex:_beginIndex withObjectAtIndex:endIndex];
                    [self testConfigContent];
                } else {
                    [self moveGoBackOrigin];
                }
            }
            
            
            break;
        }
        default:
            
            break;
    }
}

- (void)moveGoBackOrigin {
    [UIView animateWithDuration:0.5 animations:^{
        _moveView.frame = _beginFrame;
        _moveView.alpha = 0.5;
    } completion:^(BOOL finished) {
        _moveView.hidden = YES;
    }];
}


@end
