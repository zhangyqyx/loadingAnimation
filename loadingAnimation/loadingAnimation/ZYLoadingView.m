//
//  ZYLoadingView.m
//  loadingAnimation
//
//  Created by 张永强 on 16/10/14.
//  Copyright © 2016年 张永强. All rights reserved.
//

#import "ZYLoadingView.h"

static ZYLoadingView *loadView;
//枚举的两种定义方法
//typedef enum:NSUInteger {
//    LoadingViewCircle,
//    LoadingViewDot,
//    LoadingViewLine,
//    LoadingViewCircleJoin,
//}LoadingViewType;

typedef NS_ENUM(NSUInteger , LoadingViewType){
    LoadingViewCircle,
    LoadingViewDot,
    LoadingViewLine,
    LoadingViewCircleJoin,
};

@implementation ZYLoadingView
- (instancetype)initWithFrame:(CGRect)frame type:(LoadingViewType )type {
    if (self = [super initWithFrame:frame]) {
        switch (type) {
            case LoadingViewCircle:
                //加载圆形动画
                [self creatCircleAnimation];
                break;
            case LoadingViewDot:
                //加载原点动画
                [self creatDotAnimation];
                
                break;
            case LoadingViewLine:
                //加载直线类型动画
                [self creatLineAnimation];
                
                break;
            case LoadingViewCircleJoin:
                //加载圆圈动画
                [self creatCircleJoinAnimation];
                break;
            default:
                break;
        }
        
    }
    return self;
}
+ (void)showCircleView:(UIView *)view {
   [[self alloc] loadViewWith:view withType:LoadingViewCircle];
    
}
+ (void)showLineView:(UIView *)view {
    [[self alloc] loadViewWith:view withType:LoadingViewLine];
}
+ (void)showDotView:(UIView *)view {
    [[self alloc] loadViewWith:view withType:LoadingViewDot];
}
+ (void)showCircleJoinView:(UIView *)view {
   [[self alloc] loadViewWith:view withType:LoadingViewCircleJoin];
}
+ (void)showTwinkleView:(UIView *)view withTime:(float)time{
    loadView = [[ZYLoadingView alloc] initWithFrame:CGRectMake(0, 0, view.bounds.size.width, view.bounds.size.height)];
    loadView.backgroundColor = [UIColor blackColor];
    loadView.center = view.center;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = @1;
    animation.toValue = @0;
    animation.autoreverses = YES;
    animation.duration = time;
    animation.repeatCount = MAXFLOAT;
    animation.fillMode = kCAFillModeForwards;
    //定义动画的样式 渐入式   timingFunction 控制动画运行的节奏
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    imageView.image = [UIImage imageNamed:@"亮"];
    imageView.layer.position = CGPointMake(0, 0);
    imageView.center = loadView.center;
    [imageView setContentMode:UIViewContentModeScaleToFill];
    [loadView addSubview:imageView];
    [imageView.layer addAnimation:animation forKey:nil];
    [view addSubview:loadView];
}

+ (void)showRotateleView:(UIView *)view withTime:(float)time {
   
    loadView = [[ZYLoadingView alloc] initWithFrame:CGRectMake(0, 0, view.bounds.size.width, view.bounds.size.height)];
    loadView.backgroundColor = [UIColor blackColor];
    loadView.center = view.center;
    
    CATransform3D rotationTransform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue = [NSValue valueWithCATransform3D:rotationTransform];
    animation.autoreverses = YES;
    animation.duration = time;
    animation.cumulative = NO;
    animation.repeatCount = MAXFLOAT;
    animation.fillMode = kCAFillModeForwards;
    //定义动画的样式 渐入式   timingFunction 控制动画运行的节奏
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    imageView.image = [UIImage imageNamed:@"亮"];
    imageView.layer.position = CGPointMake(0, 0);
    imageView.center = loadView.center;
    [imageView setContentMode:UIViewContentModeScaleToFill];
    [loadView addSubview:imageView];
    [imageView.layer addAnimation:animation forKey:nil];
    [view addSubview:loadView];
}

- (void)loadViewWith:(UIView *)view withType:(LoadingViewType)type {
    loadView = [[ZYLoadingView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height) type:type];
    loadView.backgroundColor = [UIColor whiteColor];
    loadView.center = view.center;
    [view addSubview:loadView];
}

+ (void)hide {
    if (loadView) {
        [loadView removeFromSuperview];
    }
}
#pragma mark -- 创建动画
- (void)creatCircleAnimation {
    //创建一个relicatorLayer对象
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.bounds = CGRectMake(0, 0, 100, 100);
    replicatorLayer.cornerRadius = 10.0;
    replicatorLayer.masksToBounds = YES;
    replicatorLayer.position = self.center;
    replicatorLayer.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.2].CGColor;
    [self.layer addSublayer:replicatorLayer];
    //添加一个点
    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 0, 10, 10);
    layer.position = CGPointMake(50, 20);
    layer.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.6].CGColor;
    layer.cornerRadius = 5;
    [replicatorLayer addSublayer:layer];
    //设置relicatorLayer对象子视图的个数 及其位置
    CGFloat count = 10;
    replicatorLayer.instanceCount = count;
    CGFloat angle = 2 * M_PI / count;
    replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1);
    //添加动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 1.0;
    animation.fromValue = @1;
    animation.toValue = @0.1;
    animation.repeatCount = MAXFLOAT;
    [layer addAnimation:animation forKey:nil];
    //设置延迟值
    replicatorLayer.instanceDelay = 1.0 / count;
    //防止动画太卡初始化dotLayer的transform
    layer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1);
}
- (void)creatDotAnimation {
    //创建一个relicatorLayer对象
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.bounds = CGRectMake(0, 0, 100, 100);
    replicatorLayer.cornerRadius = 10.0;
    replicatorLayer.masksToBounds = YES;
    replicatorLayer.position = self.center;
    replicatorLayer.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.2].CGColor;
    [self.layer addSublayer:replicatorLayer];
    //添加一个点
    CALayer *dotLayer = [CALayer layer];
    dotLayer.bounds = CGRectMake(0, 0, 15, 15);
    dotLayer.position = CGPointMake(15, replicatorLayer.frame.size.height * 0.5);
    dotLayer.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.6].CGColor;
    dotLayer.cornerRadius = 7.5;
    [replicatorLayer addSublayer:dotLayer];
    //设置relicatorLayer对象子视图的个数 及其位置
    replicatorLayer.instanceCount = 3;
    replicatorLayer.instanceTransform = CATransform3DMakeTranslation(replicatorLayer.frame.size.width / 3, 0, 0);
    //添加动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 1.0;
    animation.fromValue = @1;
    animation.toValue = @0;
    animation.repeatCount = MAXFLOAT;
    [dotLayer addAnimation:animation forKey:nil];
    //设置延迟值
    replicatorLayer.instanceDelay = 1.0 / 3;
    //防止动画太卡初始化dotLayer的transform
    dotLayer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1);
    
}
- (void)creatLineAnimation {
    //创建一个relicatorLayer对象
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.bounds = CGRectMake(0, 0, 100, 100);
    replicatorLayer.cornerRadius = 10.0;
    replicatorLayer.masksToBounds = YES;
    replicatorLayer.position = self.center;
    replicatorLayer.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.2].CGColor;
    [self.layer addSublayer:replicatorLayer];
    CGFloat lineH = 60;
    CGFloat lineX = 20;
    CGFloat lineW = 5;
    //添加一条直线
    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 0, lineW, lineH);
    layer.position = CGPointMake(lineX, replicatorLayer.frame.size.height - 30);
    layer.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.6].CGColor;
    [replicatorLayer addSublayer:layer];
    //设置relicatorLayer对象子视图的个数及其位置
    CGFloat count = 6;
    replicatorLayer.instanceCount = count;
    CGFloat lineInter = 10;
    replicatorLayer.instanceTransform = CATransform3DMakeTranslation(lineInter, 0, 0);
    //添加动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    animation.duration = 0.5;
    animation.toValue = @(lineH *0.4);//结束值
    animation.autoreverses = YES;//动画结束时是否执行逆动画
    animation.repeatCount = MAXFLOAT;
    [layer addAnimation:animation forKey:nil];
    //设置延迟值
    replicatorLayer.instanceDelay = 0.5 / count;
    //防止动画太卡初始化Layer的transform
    layer.transform = CATransform3DMakeScale(1.0, 1.0, 1.0);
    
}
- (void)creatCircleJoinAnimation {
    //创建一个relicatorLayer对象
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.bounds = CGRectMake(0, 0, 100, 100);
    replicatorLayer.cornerRadius = 10.0;
    replicatorLayer.masksToBounds = YES;
    replicatorLayer.position = self.center;
    replicatorLayer.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.2].CGColor;
    [self.layer addSublayer:replicatorLayer];
    //添加一个点
    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 0, 10, 10);
    layer.position = CGPointMake(50, 20);
    layer.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.6].CGColor;
    layer.cornerRadius = 5;
    [replicatorLayer addSublayer:layer];
    //设置relicatorLayer对象子视图的个数 及其位置
    CGFloat count = 100;
    replicatorLayer.instanceCount = count;
    CGFloat angle = 2 * M_PI / count;
    replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1);
    //添加动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 0.8;
    animation.fromValue = @1;
    animation.toValue = @0;
    animation.repeatCount = MAXFLOAT;
    [layer addAnimation:animation forKey:nil];
    //设置延迟值
    replicatorLayer.instanceDelay = 0.8 / count;
    //防止动画太卡初始化dotLayer的transform
    layer.transform = CATransform3DMakeScale(0, 0, 0);
}


@end
