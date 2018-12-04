# LeeTagView
### 例图

##### 屏幕截图
 ![demo截图](https://github.com/leeboo741/ImageRepository/blob/master/LeeTagViewImage/leeTagView_Screen.png)
##### 初始化
 ![初始化](https://github.com/leeboo741/ImageRepository/blob/master/LeeTagViewImage/leeTagView_init.png)
##### 添加
 ![添加标签](https://github.com/leeboo741/ImageRepository/blob/master/LeeTagViewImage/leeTagView_viewModel.png)
##### 点击事件
 ![点击事件回调](https://github.com/leeboo741/ImageRepository/blob/master/LeeTagViewImage/leeTagView_delegate.png)
  
### 要做什么

想要做个标签选择页

### 做到了什么

  * 实现了标签的单选，多选，无法选择
  * 实现了normal，selected，highlighted，disable等状态下不同的字体颜色，背景颜色，背景图片，图标，layer的样式
  
### 学到了什么
 
  * intrinsicContentSize 属性的使用
    * 一直以来有些页面的大小自适应，都要自己计算所有元素，然后给定高度什么的
    * 终于发现了这么个神奇属性，变大变小自由掌握
    * instrinisicContentSize （固有大小）我知道自己的大小，如果你没有为我指定大小，我就按照自有大小排列
    * UILabel/UIImageView/UIButton等这些组件以及某些包含他们的系统组件都具有此属性，遇到这些组件，你只需要为其指定位置即可。大小就使用Intrinsic Content Size就行了。
    * 上述系统控件都重写了UIView 中的 -(CGSize)intrinsicContentSize: 方法。
    * 并且在需要改变这个值的时候调用：invalidateIntrinsicContentSize 方法，通知系统这个值改变了
    * 编写继承自UIView的自定义组件时，也想要有Intrinsic Content Size的时候，就可以通过这种方法来轻松实现。
  * 别的，别的就没什么了吧，都是一些很常见的东西
  
### 接下来还有什么

  * 不同状态下的 字体，文字内容 暂时还不能变化，会有文字溢出的问题。
  * 想模仿tableView的方式，通过delegate和datasource来设置tagView
  
### 想要什么

  * 我承认，只是一个小例子，没事写着玩，不算很好
  * 但是，作为长期潜水索取，从不主动付出的潜水员。
  * 我也要厚着脸皮为我在Github贡献的第一小项目跪求各位走过路过的大佬赏个Star。
  * 这很微不足道。
  * 但我会继续努力。
  * 谢谢
  * |Orz|
  
