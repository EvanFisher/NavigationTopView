//
//  UIView+YYWFrame.h
//  BuDeJie
//
//  Created by Fisher on 16/7/3.
//  Copyright © 2016年 YuYiwei. All rights reserved.
//

#import <UIKit/UIKit.h>

#define screenW_yyw [UIScreen mainScreen].bounds.size.width
#define screenH_yyw [UIScreen mainScreen].bounds.size.height

@interface UIView (YYWFrame)
/** 快速取center.x的值 */
@property (assign, nonatomic) CGFloat centerX_yyw;
/** 快速取center.y的值 */
@property (assign, nonatomic) CGFloat centerY_yyw;
/** 快速取x的值 */
@property (assign, nonatomic) CGFloat x_yyw;
/** 快速取y的值 */
@property (assign, nonatomic) CGFloat y_yyw;
/** 快速取width的值 */
@property (assign, nonatomic) CGFloat width_yyw;
/** 快速取height的值 */
@property (assign, nonatomic) CGFloat height_yyw;

@end
