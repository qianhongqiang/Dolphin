/**
 * 杭州哇财网络科技有限公司 HQAnimations
 * @file    HQSpringTransformAnimation.h
 * @brief   <#请输入简要说明#>
 * @author  青金
 * @date    15/9/11
 */

#import <QuartzCore/QuartzCore.h>

@interface HQSpringTransformAnimation : CAKeyframeAnimation

+(instancetype)springTransformFromValue:(NSValue *)fromValue toValue:(NSValue *)toValue;

@end
