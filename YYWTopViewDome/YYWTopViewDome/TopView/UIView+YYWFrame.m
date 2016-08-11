//
//  UIView+YYWFrame.m
//  BuDeJie
//
//  Created by Fisher on 16/7/3.
//  Copyright © 2016年 YuYiwei. All rights reserved.
//

#import "UIView+YYWFrame.h"

@implementation UIView (YYWFrame)


- (CGFloat)centerX_yyw
{
    return self.center.x;
    
}


- (void)setCenterX_yyw:(CGFloat)centerX_yyw
{
    CGPoint center = self.center;
    center.x = centerX_yyw;
    self.center = center;
}



- (CGFloat)centerY_yyw
{
    return self.center.y;
}

- (void)setCenterY_yyw:(CGFloat)centerY_yyw
{
    CGPoint center = self.center;
    center.y = centerY_yyw;
    self.center = center;
}






- (CGFloat)x_yyw
{
    return self.frame.origin.x;
}

- (void)setX_yyw:(CGFloat)x_yyw
{
    CGRect frame = self.frame;
    frame.origin.x = x_yyw;
    self.frame = frame;
}

- (CGFloat)y_yyw
{
    return self.frame.origin.y;
}

- (void)setY_yyw:(CGFloat)y_yyw
{
    CGRect frame = self.frame;
    frame.origin.y = y_yyw;
    self.frame = frame;
}

- (CGFloat)width_yyw
{
    return self.frame.size.width;
}

- (void)setWidth_yyw:(CGFloat)width_yyw
{
    CGRect frame = self.frame;
    frame.size.width = width_yyw;
    self.frame = frame;
}

- (CGFloat)height_yyw
{
    return self.frame.size.height;
}

- (void)setHeight_yyw:(CGFloat)height_yyw
{
    CGRect frame = self.frame;
    frame.size.height = height_yyw;
    self.frame = frame;
}


@end
