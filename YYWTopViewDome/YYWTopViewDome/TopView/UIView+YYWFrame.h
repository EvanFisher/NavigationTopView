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
@property (assign, nonatomic) CGFloat centerX_yyw;
@property (assign, nonatomic) CGFloat centerY_yyw;
@property (assign, nonatomic) CGFloat x_yyw;
@property (assign, nonatomic) CGFloat y_yyw;
@property (assign, nonatomic) CGFloat width_yyw;
@property (assign, nonatomic) CGFloat height_yyw;

@end
