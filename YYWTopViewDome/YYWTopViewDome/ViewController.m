//
//  ViewController.m
//  YYWTopViewDome
//
//  Created by Fisher on 16/8/11.
//  Copyright © 2016年 YuYiwei. All rights reserved.
//

#import "ViewController.h"


#import "YYWTopView.h"

@interface ViewController ()

@property(nonatomic, strong)NSMutableArray *topBtnArray;
@property (weak, nonatomic) YYWTopView *topView;

@end

@implementation ViewController
- (NSMutableArray *)topBtnArray
{
    if (!_topBtnArray)    _topBtnArray = [NSMutableArray array];
    
    return _topBtnArray;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    //先添加内容View
    
    //给内容View添加所有子控制器
    [self setupAllChildViewController];
    
    [self setTopView];
    
}

- (void)setTopView
{
    
    YYWTopView *topView = [YYWTopView topViewWithButtonArray:_topBtnArray];

    topView.frame = CGRectMake(0, 20, screenW_yyw + 200, 44);

//    topView.bottomLineType = kEqualToTitle;
    
//    topView.titleChangeType = kMidwayChange;
    
//    topView.gradualChangeTitleEndClicking = YES;
    
    [self.view addSubview:topView];
    
    
    _topView = topView;
    
}


/** 添加所有子控制器 */
- (void)setupAllChildViewController
{
    UIViewController *VC1 = [[UIViewController alloc] init];
    VC1.view.backgroundColor = [UIColor purpleColor];
    [self addOneChildVC:VC1 withTitle:@"Object-C"];
    
    
    UIViewController *VC2 = [[UIViewController alloc] init];
    VC2.view.backgroundColor = [UIColor whiteColor];
    [self addOneChildVC:VC2 withTitle:@"C#"];
    
    
    UIViewController *VC3 = [[UIViewController alloc] init];
    VC3.view.backgroundColor = [UIColor whiteColor];
    [self addOneChildVC:VC3 withTitle:@"Java"];
    
    UIViewController *VC4 = [[UIViewController alloc] init];
    VC4.view.backgroundColor = [UIColor whiteColor];
    [self addOneChildVC:VC4 withTitle:@"Javascript"];
    
    UIViewController *VC5 = [[UIViewController alloc] init];
    VC5.view.backgroundColor = [UIColor greenColor];
    [self addOneChildVC:VC5 withTitle:@"C"];
    //
    UIViewController *VC6 = [[UIViewController alloc] init];
    VC6.view.backgroundColor = [UIColor grayColor];
    [self addOneChildVC:VC6 withTitle:@"C++"];
    
    //接收返回的数组
    [self.topBtnArray addObjectsFromArray:[self addOneChildVC:[[UIViewController alloc] init] withTitle:@"Python"]];
    
    
}


@end
