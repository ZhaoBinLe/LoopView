//
//  AliPayLoading.m
//  ZBImageViewPlay
//
//  Created by qmap01 on 2018/7/25.
//  Copyright © 2018年 Zhaobin. All rights reserved.
//

#import "AliPayLoading.h"

@interface AliPayLoading()
{
    CADisplayLink *_link;
    CAShapeLayer *_aniLayer;
    
    CGFloat startAngle;
    CGFloat endAngle;
    CGFloat progress;
}
@end

@implementation AliPayLoading
+ (void)loadingShowIn:(UIView *)view {
    AliPayLoading *load = [[AliPayLoading alloc]initWithFrame:view.bounds];
    [load start];
    [view addSubview:load];
}
+ (void)loadingHideIn:(UIView *)view {
    AliPayLoading *load = nil;
    for (AliPayLoading *subView in view.subviews) {
        if ([subView isKindOfClass:[AliPayLoading class]]) {
            [subView hide];
            [subView removeFromSuperview];
            load = subView;
        }
    }
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}
- (void)initView {
    _aniLayer = [CAShapeLayer layer];
    _aniLayer.bounds = CGRectMake(0, 0, 60, 60);
    _aniLayer.position = CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height/2.0f);
    _aniLayer.fillColor = [UIColor clearColor].CGColor;
    _aniLayer.strokeColor = [UIColor colorWithRed:16/255.0 green:142/255.0 blue:233/255.0 alpha:1].CGColor;
    _aniLayer.lineWidth = 4.0f;
    _aniLayer.lineCap = kCALineCapRound;
    [self.layer addSublayer:_aniLayer];
    
    _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkAction)];
    [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    _link.paused = YES;
}
-(void)displayLinkAction{
    progress += [self speed];
    if (progress >= 1) {
        progress = 0;
    }
    [self updateAnimationLayer];
}
- (void)updateAnimationLayer {
    startAngle = -M_PI_2;
    endAngle = startAngle+progress*M_PI*2;
    if (endAngle>M_PI) {
        CGFloat progressNew = 1-(1-progress)/0.25;
        startAngle = -M_PI_2+progressNew*M_PI*2;
    }
    CGFloat radies = _aniLayer .bounds.size.width/2.0f - 2.0f;
    CGFloat centerX = _aniLayer.bounds.size.width/2.0f;
    CGFloat centerY = _aniLayer.bounds.size.height/2.0f;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:CGPointMake(centerX, centerY) radius:radies startAngle:startAngle endAngle:endAngle clockwise:YES];
    path.lineCapStyle = kCGLineCapRound;
    _aniLayer.path = path.CGPath;
}
- (CGFloat)speed {
    if (endAngle>M_PI) {
        return 0.3/60.0f;
    }
    return 2/60.0f;
}
- (void)start {
    _link.paused = NO;
}
- (void)hide {
    _link.paused = YES;
    progress = 0;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
