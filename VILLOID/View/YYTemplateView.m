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
    }
    return self;
}

- (void)initConfig {
    _items = [NSMutableArray array];
    _edgeInsets = UIEdgeInsetsZero;
    _images = [NSMutableArray array];
    
    _verticalMargin = 10;
    _horizontalMargin = 10;
    
    for (int i = 0; i < 9; i ++) {
        [_images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"IU%d",i]]];
    }
    
    _moveView = [[UIView alloc]init];
    _moveView.clipsToBounds = YES;
    _moveView.layer.contentsGravity = kCAGravityResizeAspectFill;
    [self addSubview:_moveView];
    _moveView.hidden = YES;
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    longPress.minimumPressDuration = 1;
    [self addGestureRecognizer:longPress];
}

- (void)setTemplateLayout:(YYTemplateLayout *)templateLayout {
    _templateLayout = templateLayout;
    _rowNumber = templateLayout.rowNumber.integerValue;
    _arrangeNumber = templateLayout.arrangeNumber.integerValue;
    [self createSubviews];
}


- (void)createSubviews {
    if (_rowNumber <= 0 || _arrangeNumber <= 0) return;
    
    NSInteger difference = _templateLayout.itemCoordinaties.count - _items.count;
    if (difference > 0) {
        if (_delegate && [_delegate respondsToSelector:@selector(templateView:itemAtIndex:)]) {
            for (NSInteger i = 0; i < difference; i ++) {
                UIView *itemView = [_delegate templateView:self itemAtIndex:i];
                [self insertSubview:itemView belowSubview:_moveView];
                
                [_items addObject:itemView];
            }
        } else {
            for (NSInteger i = 0; i < difference; i ++) {
                UIView *itemView = [[UIView alloc] init];
                itemView.backgroundColor = [UIColor redColor];
                [self insertSubview:itemView belowSubview:_moveView];
                
                itemView.layer.contentsGravity = kCAGravityResizeAspectFill;
                itemView.clipsToBounds = YES;
                [_items addObject:itemView];
            }
        }
    }
    
    for (NSInteger i = 0; i < _items.count; i ++) {
        _items[i].hidden = i >= _templateLayout.itemCoordinaties.count;
    }
    
    
    
    CGFloat selfW = self.frame.size.width;
    CGFloat selfH = self.frame.size.height;
    
    CGFloat itemUnitW = (selfW - _edgeInsets.left - _edgeInsets.right - _verticalMargin * (_arrangeNumber - 1)) / _arrangeNumber;
    CGFloat itemUnitH = (selfH - _edgeInsets.top - -_edgeInsets.bottom - _horizontalMargin * (_rowNumber - 1)) / _rowNumber;
    
    for (NSInteger i = 0; i < _templateLayout.itemCoordinaties.count; i ++) {
        CGFloat x = _templateLayout.itemCoordinaties[i].x.floatValue;
        CGFloat y = _templateLayout.itemCoordinaties[i].y.floatValue;
        CGFloat w = _templateLayout.itemCoordinaties[i].w.floatValue;
        CGFloat h = _templateLayout.itemCoordinaties[i].h.floatValue;
        
        _items[i].frame = CGRectMake(x * (itemUnitW + _verticalMargin) + _edgeInsets.left, y * (itemUnitH + _horizontalMargin) + _edgeInsets.top, w * itemUnitW + (w - 1) * _verticalMargin, h * itemUnitH + (h - 1) * _horizontalMargin);
        
    }
    
    [self testConfigContent];
}

- (void)testConfigContent {
    if (_delegate && [_delegate respondsToSelector:@selector(templateView:willDisplayItem:forItemAtIndex:)]) {
        for (NSInteger i = 0; i < _templateLayout.itemCoordinaties.count; i ++) {
            [_delegate templateView:self willDisplayItem:_items[i] forItemAtIndex:i];
        }
    } else {
        for (NSInteger i = 0; i < _templateLayout.itemCoordinaties.count; i ++) {
            _items[i].layer.contents = (__bridge id _Nullable)(_images[i].CGImage);
        }
    }
}

- (void)longPress:(UILongPressGestureRecognizer *)press {
    CGFloat scale = 1.0;
    switch (press.state) {
        case UIGestureRecognizerStateBegan:{
            //判断手势落点位置是否在某个item上
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
            _moveView.alpha = 1;
            _moveView.center = pointView.center;
            _moveView.bounds = CGRectMake(0, 0, pointView.bounds.size.width * scale, pointView.bounds.size.height * scale);
            if (_delegate && [_delegate respondsToSelector:@selector(templateView:itemAtIndex:)]) {
                _moveView.layer.contents = (__bridge id _Nullable)([self imageFromView:pointView].CGImage);
            } else {
                _moveView.layer.contents = pointView.layer.contents;
            }
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
                if (isContain) {
                    _moveView.bounds = CGRectMake(0, 0, _items[i].bounds.size.width * scale, _items[i].bounds.size.height * scale);
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
                    endIndex = i;
                    break;
                }
            }
            
            if (!isContain) {
                [self moveGoBackOrigin];
            } else {
                if (_beginIndex != endIndex) {
                    
                    [UIView animateWithDuration:0.5 animations:^{
                        _moveView.frame = _items[endIndex].frame;
                    } completion:^(BOOL finished) {
                        _moveView.hidden = YES;
                        if (_delegate && [_delegate respondsToSelector:@selector(templateView:exchangeItemAtIndex:withIndex:)]) {
                            [_delegate templateView:self exchangeItemAtIndex:_beginIndex withIndex:endIndex];
                        } else {
                            [_images exchangeObjectAtIndex:_beginIndex withObjectAtIndex:endIndex];
                            [self testConfigContent];
                        }
                    }];
                } else {
                    [self moveGoBackOrigin];
                }
            }
            //ssh key test
            
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

- (UIImage *)imageFromView:(UIView *)view {
    
    UIGraphicsBeginImageContext(view.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)reloadData {
    [self createSubviews];
}

- (void)reloadWithIndexSet:(NSIndexSet *)indexSet {
    [indexSet enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        if (_delegate && [_delegate respondsToSelector:@selector(templateView:willDisplayItem:forItemAtIndex:)]) {
            [_delegate templateView:self willDisplayItem:_items[idx] forItemAtIndex:idx];
        } else {
            _items[idx].layer.contents = (__bridge id _Nullable)(_images[idx].CGImage);
        }
    }];
}

@end
