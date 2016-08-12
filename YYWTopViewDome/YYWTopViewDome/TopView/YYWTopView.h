//
//  YYWTopView.h
//  Deme
//
//  Created by Fisher on 16/8/11.
//  Copyright © 2016年 YuYiwei. All rights reserved.
//



/*********************************************************************
 
 使用方法:
 
 1. 将"TopView"文件夹拖入工程中.
 2. 让需要添加TopView的控制器, 继承自YYWViewController.
 3. 具体细节可参考ViewController.m中的代码.
 
 
 *********************************************************************/

typedef enum {
    
    /** 没有底部线 */
    kNone = 0,
    
    /** 底部线宽度和文字的相等, 默认就是这个. */
    kEqualToTitle = 1,
    
    /** 底部线宽度和按钮相等 */
    kEqualToButton = 2
    
    
} BottomLineType;

typedef enum {
    
    
    /** 拖动CollectionView时, 逐渐改变title的颜色, 默认就是这个. */
    kGradualChange = 1,
    
    /** 拖动CollectionView时, 中途改变title的颜色. */
    kMidwayChange = 2,
    
    /** CollectionView减速完毕后, 改变title的颜色.
     如果设置了这个枚举值, 那么"gradualChangeTitleEndClicking"这个布尔属性无效. */
    kEndDeceleratingChange = 3
    
} TitleChangeType;




#import <UIKit/UIKit.h>
#import "UIView+YYWFrame.h"


@interface YYWTopView : UIView

/**  这是一个枚举, 可以选择底部线的宽度.*/
@property (assign, nonatomic) BottomLineType bottomLineType;

/**  这是一个枚举, 当拖动CollectionView时, 选择title变换样式.*/
@property (assign, nonatomic) TitleChangeType titleChangeType;


/**  是否在点击后让title渐变, 或让CollectionView移动时加动画, 默认是NO. */
@property (assign, nonatomic) BOOL gradualChangeTitleEndClicking;




/** 传递当前点击按钮的Index, 在点击按钮时让Collection的cell移动到对应位置. */
@property (copy, nonatomic) void(^moveContentView)(int);

/** 用于让外界传递按钮的内容 */
@property(strong, nonatomic)NSArray *buttonTitleArray;

/** 用来让外界设置所有按钮的属性, 主要用来设置颜色和字体.
 默认为17号字体; 正常状态为黑色, 选中状态为红色. */
@property (weak, nonatomic) UIButton *button;

/** 设置底部线颜色 */
@property (strong, nonatomic) UIColor *bottomLineColor;

/** 可自定义底部线 */
@property (weak, nonatomic) UIView *bottomLine;




-(instancetype)initWithButtonArray:(NSArray*)array;
+(instancetype)topViewWithButtonArray:(NSArray*)array;


/**
 *  Scroll滚动时, 底部线也跟着移动.
 *
 *  @param contentOffsetX Scroll的contentOffset的X值!
 */
- (void)moveBottomLineWithcontentOffset:(float)contentOffsetX;

/** 外部的CollectionView滚动完毕后, 让当前选中的按钮滚到中间. */
- (void)moveTopViewWhenEndDecelerating;

@end
