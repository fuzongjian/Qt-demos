### 自动布局
- SizePolicy属性
>控件的sizePolicy说明控件在布局管理中的缩放方式。常见属性值如下：

| 属性值 | 说明 |
|:-----:|:-----:|
| Fixed| 控件不能放大或缩小，控件的大小就是他们的sizeHint |
| Minimum | 控件的sizeHint为控件的最小尺寸，控件不能小于这个sizeHint，但是可以放大 |
| Maximum | 控件的sizeHint为控件的最大尺寸，控件不能放大，但是可以缩小打他的最小允许的尺寸 |
| Preferred | 控件的sizeHint是它的sizeHint，但是可以放大或者缩小 |
| Expandint | 控件可以自行增大或缩小 |
`注：`sizeHint（布局管理中的控件默认尺寸，如果控件不在布局管理中就为无效的值）
- layoutStretch属性
>布局中的layoutStretch表明了在该布局中的控件所占比例的分配。默认是0。当设置了大于0的数字后，其余为0的控件默认只占最小的大小，剩下的控件则按比例分配给数字大于0的控件。

![](/images/layout_a.png)
![](/images/layout_b.jpg)

`总结`

```
1、设置控件的SizeHint属性。
2、设置顶级布局。
```
