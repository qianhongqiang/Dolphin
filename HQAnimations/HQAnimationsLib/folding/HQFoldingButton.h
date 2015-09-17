/**
 * 杭州哇财网络科技有限公司 HQAnimations
 * @file    HQFoldingButton.h
 * @brief   <#请输入简要说明#>
 * @author  青金
 * @date    15/9/15
 */

#import <UIKit/UIKit.h>

@interface HQFoldingButton : UIButton

- (instancetype)initWithFrame:(CGRect)frame image:(NSString *)image;

- (void)folding;

- (void)reset;

@end
