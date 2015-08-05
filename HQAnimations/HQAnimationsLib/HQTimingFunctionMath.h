//
//  HQTimingFunctionMath.h
//  HQAnimations
//
//  Created by qianhongqiang on 15/8/5.
//  Copyright (c) 2015年 QianHongQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HQTimingFunctionMath : NSObject

+(double)dampValueWithBasicValue:(double)value damping:(double)damping velocity:(double)velocity;

+(double)popValueWithBasicValue:(double)value velocity:(double)velocity;

@end
