//
//  HQAnimationState.m
//  HQAnimations
//
//  Created by qianhongqiang on 2017/5/12.
//  Copyright © 2017年 QianHongQiang. All rights reserved.
//

#import "HQAnimationState.h"
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface HQAnimationState ()

@property (nonatomic, assign) BOOL isStart;

@end

@implementation HQAnimationState

- (instancetype)init
{
    self = [super init];
    if (!self) return nil;
    
    _isStart = NO;
    _beginTime = 0;

    return self;
}

-(BOOL)isStart
{
    return _isStart;
}

- (void)startIfNeed
{
    if (_isStart) return;
    
    _isStart = YES;
    _beginTime = CACurrentMediaTime();
}


-(void)setFromValue:(id)fromValue
{
    _fromValue = fromValue;
    
}

-(void)setToValue:(id)toValue
{
    _toValue = toValue;
    
    const char *valueType = [toValue objCType];
    [self bindValueType:valueType];
}

-(void)bindValueType:(const char *)valueEncode
{
    if (strcmp(valueEncode, @encode(float)) == 0 ||
        strcmp(valueEncode, @encode(double)) == 0) {
        _valueType = HQAnimationValueTypeFloat;
        return;
    } else if (strcmp(valueEncode, @encode(CGPoint)) == 0) {
        _valueType = HQAnimationValueTypePoint;
        return;
    } else if (strcmp(valueEncode, @encode(CGSize)) == 0) {
        _valueType = HQAnimationValueTypeSize;
        return;
    } else if (strcmp(valueEncode, @encode(CGRect)) == 0) {
        _valueType = HQAnimationValueTypeRect;
        return;
    } else if (strcmp(valueEncode, @encode(UIEdgeInsets)) == 0) {
        _valueType = HQAnimationValueTypeEdgeInsets;
        return;
    } else if (strcmp(valueEncode, @encode(CGAffineTransform)) == 0) {
        _valueType = HQAnimationValueTypeAffineTransform;
        return;
    } else if (strcmp(valueEncode, @encode(CATransform3D)) == 0) {
        _valueType = HQAnimationValueTypeTransform;
        return;
    } else if (strcmp(valueEncode, @encode(CFRange)) == 0) {
        _valueType = HQAnimationValueTypeRange;
        return;
    } else if (strcmp(valueEncode, @encode(int)) == 0
               || strcmp(valueEncode, @encode(unsigned int)) == 0
               || strcmp(valueEncode, @encode(short)) == 0
               || strcmp(valueEncode, @encode(unsigned short)) == 0
               || strcmp(valueEncode, @encode(long)) == 0
               || strcmp(valueEncode, @encode(unsigned long)) == 0
               || strcmp(valueEncode, @encode(long long)) == 0
               || strcmp(valueEncode, @encode(unsigned long long)) == 0) {
        _valueType = HQAnimationValueTypeInteger;
        return;
    } else {
        _valueType = HQAnimationValueTypeUnkown;
        return;
    }
    
    
}

- (BOOL)applyAnimationTime:(id)obj time:(CFTimeInterval)time
{
    if (!self.fromValue || !self.toValue) return NO;
    
    if ([self isFinished:time]) return NO;
    
    float normalization = [self normalizeCurrentTime:time];
    
    float (^timeFunction)(float normal) = ^(float normal){
        return normal * normal * normal;
    };
    
    switch (self.valueType) {
        case HQAnimationValueTypeRect:
        {
            CGRect fromRect = [self.fromValue CGRectValue];
            CGRect toRect = [self.toValue CGRectValue];
            
            CGRect (^desRect)(CGRect from, CGRect to) = ^(CGRect from, CGRect to){
                return CGRectMake(from.origin.x + (to.origin.x - from.origin.x) * timeFunction(normalization),
                                  from.origin.y + (to.origin.y - from.origin.y) * timeFunction(normalization),
                                  from.size.width + (to.size.width - from.size.width) * timeFunction(normalization),
                                  from.size.height + (to.size.height - from.size.height) * timeFunction(normalization));
            };
            
            _currentValue = [NSValue valueWithCGRect:desRect(fromRect,toRect)];
        }
            break;
            
        default:
            break;
    }
    
    return NO;
}

- (BOOL)isFinished:(CFTimeInterval)time
{
    return time - self.beginTime > self.duration;
}

//归一化到0-1
- (float)normalizeCurrentTime:(CFTimeInterval)time
{
    return (time - self.beginTime) / self.duration;
}

@end
