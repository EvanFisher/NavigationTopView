//
//  YYWViewController.m
//  Deme
//
//  Created by Fisher on 16/8/11.
//  Copyright © 2016年 YuYiwei. All rights reserved.
//

#import "YYWViewController.h"
#import "YYWTopView.h"

static NSString * const CollectionCell = @"CollectionCell";

@interface YYWViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property(strong, nonatomic)NSMutableArray *topBtnArray;
@property (weak, nonatomic) YYWTopView *topView;
@property (weak, nonatomic) UICollectionView *contentView;

@end

@implementation YYWViewController

- (NSMutableArray *)topBtnArray
{
    if (!_topBtnArray) _topBtnArray = [NSMutableArray array];
    
    return _topBtnArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //先添加内容View
    [self setupContentView];
    
    [self setUpTopView];
    
}




- (void)setUpTopView
{
    
    YYWTopView *topView = [[YYWTopView alloc] init];
    
    
    //在block方法里移动ContentView
    __weak YYWTopView* weakTopView = topView;
    topView.moveContentView = ^(int btnIndex)
    {
        [_contentView setContentOffset:CGPointMake(btnIndex * screenW_yyw, 0)animated:weakTopView.gradualChangeTitleEndClicking];
    };
    _topView = topView;
    
    
}




/** 添加一个子控制器 */
- (NSMutableArray *)addOneChildVC:(UIViewController *)VC withTitle:(NSString *)title
{
    VC.title = title;
    [self.topBtnArray addObject:VC.title];
    [self addChildViewController:VC];
    
    return _topBtnArray;
}


#pragma mark - 添加内容view
/** add content view*/
- (void)setupContentView
{
    //CollectionView的重复利用机制可以避免离屏渲染. ScrollView无法做到这一点.
    UICollectionViewFlowLayout *flowLayer =
    ({
        
        flowLayer = [[UICollectionViewFlowLayout alloc]init];
        //每个cell的大小
        flowLayer.itemSize = CGSizeMake(screenW_yyw, screenH_yyw);
        // 滚动方向:bug
        flowLayer.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //设置每个格子最小间隔
        flowLayer.minimumInteritemSpacing = 0;
        //设置列间距
        flowLayer.minimumLineSpacing = 0;
        
        flowLayer;
        
    });
    
    
    // UICollectionView:占据全屏
    UICollectionView *contentView =
    ({
        contentView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, screenW_yyw, screenH_yyw) collectionViewLayout:flowLayer];
        
        _contentView = contentView;
        contentView.dataSource = self;
        contentView.delegate = self;
        // 开启分页
        contentView.pagingEnabled = YES;
        //取消弹簧效果
        contentView.bounces = NO;
        // 注册cell
        [contentView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CollectionCell];
        
        contentView;
        
    });
    
    
    [self.view addSubview:contentView];
    
}




#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.childViewControllers.count;
}

// 每当有新的cell出现的时候就会调用,把对应的子控制器的view添加上去
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionCell forIndexPath:indexPath];
    
    // 移除之前子控制器View
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UIViewController *VC = self.childViewControllers[indexPath.row];
    VC.view.frame = CGRectMake(0, 0, screenW_yyw, screenH_yyw);
    // 往contentView添加子控件
    [cell.contentView addSubview:VC.view];
    
    return cell;
}


#pragma mark - UICollectionViewDelegate
//当Collection滚动时, 调用Button的方法, 让底部线跟着移动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.topView moveBottomLineWithcontentOffset:_contentView.contentOffset.x];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    [_topView moveScrollViewWhenEndDecelerating:0];
    
}





@end

