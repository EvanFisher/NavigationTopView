//
//  YYWViewController.h
//  Deme
//
//  Created by Fisher on 16/8/11.
//  Copyright © 2016年 YuYiwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYWViewController : UIViewController
/**
 *  添加子控制器方法
 *
 *  @param VC    子控制器
 *  @param title 即是子控制器的title, 也是topView里Button的title.
 *
 *  @return 一个装着title字符串的可变数组, 初始化topView时, 可以接收的这个数组, 然后传递给自定义类工厂方法.
 */
- (NSMutableArray *)addOneChildVC:(UIViewController *)VC withTitle:(NSString *)title;

@end
