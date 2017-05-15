//
//  DPHAnimationState.m
//  Pods
//
//  Created by qianhongqiang on 2017/5/15.
//
//

#import "DPHAnimationState.h"
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface DPHAnimationState ()

@property (nonatomic, assign) BOOL isStart;

@end

@implementation DPHAnimationState

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
        _valueType = DPHAnimationValueTypeFloat;
        return;
    } else if (strcmp(valueEncode, @encode(CGPoint)) == 0) {
        _valueType = DPHAnimationValueTypePoint;
        return;
    } else if (strcmp(valueEncode, @encode(CGSize)) == 0) {
        _valueType = DPHAnimationValueTypeSize;
        return;
    } else if (strcmp(valueEncode, @encode(CGRect)) == 0) {
        _valueType = DPHAnimationValueTypeRect;
        return;
    } else if (strcmp(valueEncode, @encode(UIEdgeInsets)) == 0) {
        _valueType = DPHAnimationValueTypeEdgeInsets;
        return;
    } else if (strcmp(valueEncode, @encode(CGAffineTransform)) == 0) {
        _valueType = DPHAnimationValueTypeAffineTransform;
        return;
    } else if (strcmp(valueEncode, @encode(CATransform3D)) == 0) {
        _valueType = DPHAnimationValueTypeTransform;
        return;
    } else if (strcmp(valueEncode, @encode(CFRange)) == 0) {
        _valueType = DPHAnimationValueTypeRange;
        return;
    } else if (strcmp(valueEncode, @encode(int)) == 0
               || strcmp(valueEncode, @encode(unsigned int)) == 0
               || strcmp(valueEncode, @encode(short)) == 0
               || strcmp(valueEncode, @encode(unsigned short)) == 0
               || strcmp(valueEncode, @encode(long)) == 0
               || strcmp(valueEncode, @encode(unsigned long)) == 0
               || strcmp(valueEncode, @encode(long long)) == 0
               || strcmp(valueEncode, @encode(unsigned long long)) == 0) {
        _valueType = DPHAnimationValueTypeInteger;
        return;
    } else {
        _valueType = DPHAnimationValueTypeUnkown;
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
        case DPHAnimationValueTypeRect:
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
