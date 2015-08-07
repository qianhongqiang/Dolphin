//
//  HQStrokeButton.m
//  HQAnimations
//
//  Created by qianhongqiang on 15/8/7.
//  Copyright (c) 2015年 QianHongQiang. All rights reserved.
//

#import "HQStrokeButton.h"
#import "HQTimingFunctionMath.h"

@interface HQStrokeButton()

@property (nonatomic, strong) CAGradientLayer *leftLayer;
@property (nonatomic, strong) CAGradientLayer *rightLayer;

@property (nonatomic, strong) CAShapeLayer *traceLayer;

@end

@implementation HQStrokeButton

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.layer addSublayer:self.leftLayer];
        [self.layer addSublayer:self.rightLayer];
        [self.layer addSublayer:self.traceLayer];
        [self.layer setMask:self.traceLayer];
        self.traceLayer.strokeEnd = .8;
    }
    return self;
}

#pragma maek - private
-(void)springSetSroke:(CGFloat)strokend {
    
    NSMutableArray *values = [NSMutableArray new];
    
    for (double i = 1; i < 100 + 1; ++i) {
        double x = i / 100;
        double value = [HQTimingFunctionMath shakeValueWithBasicValue:x tension:1 velocity:1] + strokend;
        NSLog(@"%f",value);
        [values addObject:@(value)];
    }
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = .5;
    animation.values = values;
    
    [self.traceLayer addAnimation:animation forKey:@"strokeEnd"];
}

#pragma mark - getter
-(CAGradientLayer *)leftLayer {
    if (_leftLayer == nil) {
        _leftLayer = [CAGradientLayer layer];
        _leftLayer.frame = CGRectMake(0, 0, self.frame.size.width/2, self.frame.size.height);
        [_leftLayer setColors:[NSArray arrayWithObjects:(id)[[UIColor redColor] CGColor],(id)[[UIColor yellowColor] CGColor], nil]];
        [_leftLayer setLocations:@[@0.5,@0.9,@1 ]];
        [_leftLayer setStartPoint:CGPointMake(0.5, 1)];
        [_leftLayer setEndPoint:CGPointMake(0.5, 0)];
    }
    return _leftLayer;
}

-(CAGradientLayer *)rightLayer {
    if (_rightLayer == nil) {
        _rightLayer = [CAGradientLayer layer];
        _rightLayer.frame = CGRectMake(self.frame.size.width/2, 0, self.frame.size.width/2, self.frame.size.height);
        [_rightLayer setColors:[NSArray arrayWithObjects:(id)[[UIColor yellowColor] CGColor],(id)[[UIColor redColor] CGColor], nil]];
        [_rightLayer setLocations:@[@0.5,@0.9,@1]];
        [_rightLayer setStartPoint:CGPointMake(0.5, 0)];
        [_rightLayer setEndPoint:CGPointMake(0.5, 1)];
    }
    return _rightLayer;
}

-(CAShapeLayer *)traceLayer {
    if (_traceLayer == nil) {
        _traceLayer = [CAShapeLayer layer];
        _traceLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        _traceLayer.fillColor = [[UIColor clearColor] CGColor];
        _traceLayer.strokeColor = [[UIColor greenColor] CGColor];
        _traceLayer.opacity = 0.25;
        _traceLayer.lineCap = kCALineCapRound;
        _traceLayer.lineWidth = 5;
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2) radius:(self.frame.size.width-5)/2 startAngle:0 endAngle:M_PI *2 clockwise:YES];
        _traceLayer.path =[path CGPath];
        
    }
    return  _traceLayer;
}

@end
