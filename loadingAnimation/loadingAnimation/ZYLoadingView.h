//
//  ZYLoadingView.h
//  loadingAnimation
//
//  Created by 张永强 on 16/10/14.
//  Copyright © 2016年 张永强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYLoadingView : UIView
/**
 * 加载圆形动画
 * view 加载到那个视图上
 */
+ (void)showCircleView:(UIView *)view;
/**
 * 加载直线类型动画
 * view 加载到那个视图上
 */
+ (void)showLineView:(UIView *)view;

/**
 * 加载原点动画
 * view 加载到那个视图上
*/
+ (void)showDotView:(UIView *)view;

/**
 * 加载圆圈动画
 * view 加载到那个视图上
 */
+ (void)showCircleJoinView:(UIView *)view;
/**
 * 加载闪烁动画
 * view 加载到那个视图上
 * time 闪烁持续时间
 */
+ (void)showTwinkleView:(UIView *)view withTime:(float)time;
/**
 * 加载旋转动画
 * view 加载到那个视图上
 * time 旋转持续时间
 */
+ (void)showRotateleView:(UIView *)view withTime:(float)time;

/** 隐藏视图 */
+ (void)hide;


@end
