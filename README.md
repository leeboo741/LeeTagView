# LeeTagView2.0
### 例图

##### 屏幕截图
 ![demo截图](https://github.com/leeboo741/ImageRepository/blob/master/LeeTagViewImage/LeeTagView%E6%95%88%E6%9E%9C.png)
##### View 属性
 ![View属性](https://github.com/leeboo741/ImageRepository/blob/master/LeeTagViewImage/LeeTagView%E5%B1%9E%E6%80%A7.png)
##### View 方法
 ![View方法](https://github.com/leeboo741/ImageRepository/blob/master/LeeTagViewImage/LeeTagView%E6%96%B9%E6%B3%95.png)
##### Item 属性
 ![Item属性](https://github.com/leeboo741/ImageRepository/blob/master/LeeTagViewImage/LeeTagItem%E5%B1%9E%E6%80%A7.png)
##### 使用方法
 ![使用方法](https://github.com/leeboo741/ImageRepository/blob/master/LeeTagViewImage/LeeTagView%E4%BD%BF%E7%94%A8%E5%AE%9E%E4%BE%8B.png)
##### 点击事件
 ![点击事件回调](https://github.com/leeboo741/ImageRepository/blob/master/LeeTagViewImage/LeeTagView%E7%82%B9%E5%87%BB%E5%9B%9E%E8%B0%83.png)
  
### 要做什么

想要做个标签选择页,可以实现多选，单选，在各种状态下，显示不同的内容，字体，颜色，图片，富文本等等...

### 做到了什么

  * 实现了标签的单选，多选，无法选择
  * 实现了标签的未选中，选中，禁用，选中禁用四种状态，以及四种状态下不同的显示
  * 内容自适应
  * 可以固定宽高
  * 基本满足日常的各种需求
  
### 学到了什么
 
  * intrinsicContentSize 属性的使用
    * 一直以来有些页面的大小自适应，都要自己计算所有元素，然后给定高度什么的
    * 终于发现了这么个神奇属性，变大变小自由掌握
    * instrinisicContentSize （固有大小）我知道自己的大小，如果你没有为我指定大小，我就按照自有大小排列
    * UILabel/UIImageView/UIButton等这些组件以及某些包含他们的系统组件都具有此属性，遇到这些组件，你只需要为其指定位置即可。大小就使用Intrinsic Content Size就行了。
    * 上述系统控件都重写了UIView 中的 -(CGSize)intrinsicContentSize: 方法。
    * 并且在需要改变这个值的时候调用：invalidateIntrinsicContentSize 方法，通知系统这个值改变了
    * 编写继承自UIView的自定义组件时，也想要有Intrinsic Content Size的时候，就可以通过这种方法来轻松实现。
  * Button的各种EdgeInsets
  * 不依赖Masonry的代码约束
  * 捋顺了layoutSubViews/layoutIfNeeds/setNeedsLayout
  
### 接下来还有什么

  * 很长时间没有更新过，非常感谢MR.王提出的Issuse，给了我升级版本的动力，会在后续根据使用情况继续更新完善
  * 想模仿tableView的方式，通过delegate和datasource来设置tagView
  * 试试能不能提炼接口
  * 尝试别的设计模式
  
### 想要什么

  * 我承认，只是一个小例子，没事写着玩，不算很好
  * 但是，作为长期潜水索取，从不主动付出的潜水员。
  * 我也要厚着脸皮为我在Github贡献的第一小项目跪求各位走过路过的大佬赏个Star。
  * 这很微不足道。
  * 但我会继续努力。
  * 谢谢
  * |Orz|
  * 再次感谢给我star的各位，还有提出问题的各位，让我有动力有意愿继续跟进完善该项目，非常感谢。
  * 非常希望大家积极反馈使用中所遇到的问题，我会尽可能快的反馈及修复。
  
