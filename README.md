# NavigationTopView
自定义的多按钮可拖动导航条(有类似网易新闻, 和知乎发现栏顶部效果). 

<br />
###框架优点:
- 封装完善, 内部结构逻辑清晰, 简单易读.
- 接口丰富, 可实现高度自定义.
- 极其易用! 控制器中只需写极少代码, 就可以实现功能.

<br />
###使用方法:
1. 导入Deme中的"TopView" 文件夹.
2. 让需要添加TopView的控制器, 继承自"YYWViewController".
3. 在控制器中, 创建"YYWTopView"类(推荐用自定义类工厂方法), 并传入存储String(title的字典).
4. 在控制器中调用父类"YYWViewController"中的方法, 添加子控件.

	
	
<br />
###实现效果:

- **title颜色和底部线渐变, 类似知乎发现栏顶部效果.**

```Object-C 
topView.titleChangeType = kGradualChange;// 默认效果
```


![Mou icon](https://github.com/EvanFisher/NavigationTopView/raw/master/Image/gradual.gif)

<br />
<br />

- **title颜色在拖动中途改变.**

```Object-C 
topView.titleChangeType = kMidwayChange;
```

![Mou icon](https://github.com/EvanFisher/NavigationTopView/raw/master/Image/half.gif)

<br />
<br />

- **title颜色在拖动完成后改变.**

```Object-C 
topView.titleChangeType = kEndDeceleratingChange;
```

![Mou icon](https://github.com/EvanFisher/NavigationTopView/raw/master/Image/after.gif)

<br />
<br />


- **底部线宽度和按钮宽度一致.**

```Object-C 
topView.bottomLineType = kEqualToButton;
```

![Mou icon](https://github.com/EvanFisher/NavigationTopView/raw/master/Image/width.gif)

<br />
<br />


- **点击后让title的颜色渐变.**

```Object-C 
topView.gradualChangeTitleEndClicking = YES;
```

![Mou icon](https://github.com/EvanFisher/NavigationTopView/raw/master/Image/bool.gif)

<br />
<br />


> 其他具体细节参考Demo中的注释吧...

