
#import "HQFoldingButton.h"

@interface HQFoldingButton ()

@property (nonatomic, strong) UIImage *backgroundImage;

@property (nonatomic, strong) UIImageView *topImagevImageView;

@end

@implementation HQFoldingButton

- (instancetype)initWithFrame:(CGRect)frame image:(NSString *)image {
    self = [super initWithFrame:frame];
    if (self) {
        _backgroundImage = [UIImage imageNamed:image];
    }
    return self;
}

- (void)folding {
    
}

- (void)reset {
    
}

-(UIImageView *)topImagevImageView {
    if (nil == _topImagevImageView) {
        _topImagevImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f,
                                                                     0.f,
                                                                     CGRectGetWidth(self.bounds),
                                                                     CGRectGetMidY(self.bounds))];
    }
    return _topImagevImageView;
}

@end
