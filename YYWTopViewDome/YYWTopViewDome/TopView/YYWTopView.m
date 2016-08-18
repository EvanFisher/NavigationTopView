//
//  YYWTopView.m
//  Deme
//
//  Created by Fisher on 16/8/11.
//  Copyright © 2016年 YuYiwei. All rights reserved.
//

#import "YYWTopView.h"

@interface YYWTopView()

@property (weak, nonatomic) UIScrollView *scroll;

/** 按钮文字中心的X值 */
@property (assign, nonatomic) CGFloat btnTitleCenterX;

/** ContentView's cell与TopView's bottomLine移动的比例 */
@property (assign, nonatomic) float scale;

@property (weak, nonatomic) UIButton *selectedBtn;

@property (weak, nonatomic) UIButton *currentBtn;

@property (weak, nonatomic) UIButton *nextBtn;

@property (assign, nonatomic) int btnW;

@end

@implementation YYWTopView

static YYWTopView *_instance;
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    
    return _instance;
}




-(instancetype)initWithButtonArray:(NSArray *)array
{
    if (self = [super init]) self.buttonArray = array;
    return self;
}


+(instancetype)topViewWithButtonArray:(NSArray*)array
{
    return [[self alloc] initWithButtonArray:array];
}



- (void)setButtonArray:(NSArray *)buttonArray
{
    _buttonTitleArray = buttonArray;
    
    self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    
    UIScrollView *scroll = [[UIScrollView alloc] init];
    
    scroll.showsHorizontalScrollIndicator = NO;
    
    
    _titleChangeType = kGradualChange;
    
    _bottomLineType = kEqualToTitle;
    
    
    
    for (int i = 0; i < _buttonTitleArray.count; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        //设置按钮文字
        [btn setTitle:_buttonTitleArray[i] forState:UIControlStateNormal];
        //默认常态为黑色, 选中为红色
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        // 设置按钮字体
        btn.titleLabel.font = [UIFont systemFontOfSize:17];
        
        //默认第一个按钮被点击
        if (!i)  _selectedBtn = btn;
        
        [scroll addSubview:btn];
        
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self addSubview:scroll];
    
    _scroll = scroll;
    
    _selectedBtn.selected = YES;
    
    //添加按钮底部条
    [self setBottomLine];
    
    //获取当前类下的所有按钮
    _button = [UIButton appearanceWhenContainedIn:self.class, nil];
    
}

#pragma mark - 选中按钮
/** 选中按钮 */
- (void)selectButton:(UIButton *)button
{
    _selectedBtn.selected = NO;
    button.selected = YES;
    _selectedBtn = button;
}


/** 加载底部线 */
- (void)setBottomLine
{
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = [UIColor redColor];;
    [_scroll addSubview:bottomLine];
    _bottomLine = bottomLine;
}

//设置底部线颜色
- (void)setBottomLineColor:(UIColor *)color
{
    _bottomLine.backgroundColor = color;
}


/** 点击按钮方法 */
- (void)clickBtn:(UIButton *)btn
{
    if (_titleChangeType == kEndDeceleratingChange)
        _gradualChangeTitleEndClicking = NO;
    
    //先让点击按钮被选中
    if (_gradualChangeTitleEndClicking)    _selectedBtn = btn;
    else    [self selectButton:btn];
    
    //再让底部条滚到对应位置
    if (_bottomLineType && !_gradualChangeTitleEndClicking)
        [UIView animateWithDuration:0.15 animations:^{
            
            switch ((int)_bottomLineType)
            {
                    //如果底部线和按钮的文字一样宽
                case kEqualToTitle:
                    
                    _bottomLine.width_yyw = _selectedBtn.titleLabel.width_yyw;
                    _bottomLine.centerX_yyw = _selectedBtn.centerX_yyw;
                    break;
                    
                    //如果底部线和按钮一样宽
                case kEqualToButton:
                    
                    _bottomLine.x_yyw = _selectedBtn.x_yyw;
                    break;
            }
        }];
    
    //然后调用block, 让CollectionView滚到对应位置
    if (_moveContentView)    _moveContentView(_selectedBtn.x_yyw / _btnW);
    
    //最后让选中的title滚到中间
    CGFloat currentBtnMidX = _gradualChangeTitleEndClicking ? _selectedBtn.centerX_yyw : _currentBtn.centerX_yyw;
    
    [self moveScrollViewWhenEndDecelerating:currentBtnMidX];
    
}



/** 外部的Scroll滚动时, 底部线也跟着移动 */
- (void)moveBottomLineWithcontentOffset:(float)contentOffsetX
{
    
    const float lineX = contentOffsetX / _scale;
    
    const int btnIndex = (contentOffsetX - _scroll.width_yyw * 0.5) / _scroll.width_yyw + 0.5;
    
    //拿到当前点击的按钮
    _currentBtn = _scroll.subviews[btnIndex];
    
    //拿到下一个按钮
    _nextBtn = _scroll.subviews[btnIndex+1];
    
    //容错
    if (![_scroll.subviews[btnIndex+1] isKindOfClass:_currentBtn.class])
        _nextBtn = _scroll.subviews[btnIndex-1];
    
    //变换底部线X轴和宽度
    if (_bottomLineType && _titleChangeType != kEndDeceleratingChange)
    {
        switch ((int)_bottomLineType)
        {
                
            case kEqualToTitle:
                
                _bottomLine.centerX_yyw = lineX + _btnTitleCenterX;
                
                //让底部线的宽度随按钮title的宽度变化
                _bottomLine.width_yyw  =
                ({
                    const CGFloat difference = _nextBtn.titleLabel.width_yyw - _currentBtn.titleLabel.width_yyw;
                    
                    const CGFloat variable = lineX - _btnW * btnIndex;
                    
                    variable * difference / _btnW + _currentBtn.titleLabel.width_yyw;
                });
                break;
                
            case kEqualToButton:
                
                _bottomLine.x_yyw = lineX;
                break;
                
        }
        
        
        //变换title颜色
        if ((int)_titleChangeType == kMidwayChange)
        {
            //根据移动的x轴, 拿到选中的按钮
            NSInteger index = lineX / _btnW + 0.5;
            
            [self selectButton:_scroll.subviews[index]];
        }
        else if ((int)_titleChangeType == kGradualChange)
        {
            
            CGFloat gradulValueUp = (contentOffsetX / _scroll.width_yyw - btnIndex);
            
            _currentBtn.titleLabel.textColor = [UIColor colorWithRed:1 - gradulValueUp green:0 blue:0 alpha:1];
            
            _nextBtn.titleLabel.textColor = [UIColor colorWithRed:gradulValueUp  green:0 blue:0 alpha:1];
            
            
        }
        
    }
    
}


- (void)moveScrollViewWhenEndDecelerating:(CGFloat)currentBtnMidX
{

    if (!currentBtnMidX)    currentBtnMidX = _currentBtn.centerX_yyw;
    CGFloat offset;
    CGFloat halfWidth = _scroll.width_yyw * 0.5;
    CGFloat contentWidth = _scroll.contentSize.width;
    
    if (currentBtnMidX < halfWidth)    offset = 0;
    
    else if (currentBtnMidX > contentWidth - halfWidth)
        offset = contentWidth - _scroll.width_yyw;
    
    else    offset = currentBtnMidX - halfWidth;
    
    [_scroll setContentOffset:CGPointMake(offset, 0) animated:YES];
    
    [self selectButton:_currentBtn];

    
    if (_titleChangeType == kEndDeceleratingChange)
        [UIView animateWithDuration:0.15 animations:^{
            
            if (_bottomLineType == kEqualToTitle)
                _bottomLine.width_yyw = _currentBtn.titleLabel.width_yyw;
            else if (_bottomLineType == kEqualToButton)
                _bottomLine.width_yyw = _btnW;
            
            _bottomLine.centerX_yyw = _currentBtn.centerX_yyw;
        }];
}



-(void)layoutSubviews
{
    //不要忘记这一步
    [super layoutSubviews];
    
    
    _scroll.contentSize = CGSizeMake(self.width_yyw, 0);
    
    if (self.width_yyw > screenW_yyw)
        _scroll.frame = CGRectMake(0, 0, screenW_yyw, self.height_yyw);
    else
        _scroll.frame = CGRectMake(0, 0, self.width_yyw, self.height_yyw);
    
    //按钮的位置是根据contentSize计算的
    _btnW = _scroll.contentSize.width / _buttonTitleArray.count;
    
    for (int i = 0; i < _buttonTitleArray.count; i++)
    {
        UIButton *btn = _scroll.subviews[i];
        btn.frame = CGRectMake(i * _btnW, 0, _btnW, self.height_yyw);
    }
    
    if (_bottomLineType)
        switch ((int)_bottomLineType)
    {
        case kEqualToTitle:
            
            //设置底部线的frame
            _bottomLine.frame = CGRectMake(_selectedBtn.titleLabel.x_yyw,  self.height_yyw - 2, _selectedBtn.titleLabel.width_yyw, 2);
            _bottomLine.centerX_yyw = _selectedBtn.centerX_yyw;
            _btnTitleCenterX = _selectedBtn.titleLabel.centerX_yyw;
            break;
            
        case kEqualToButton:
            
            //设置底部线的frame
            _bottomLine.frame = CGRectMake(_selectedBtn.x_yyw, self.height_yyw - 2, _selectedBtn.width_yyw, 2);
            break;
    }
    
    _scale = _buttonTitleArray.count * screenW_yyw / _scroll.contentSize.width;
    
}



@end

