# TTCollectionView
collectionView 自定义 layout 五种实现方式

## 自定义layout几种实现

### 1. 无限轮播

优点，相比ScrollView,可以重用cell，优化性能

#### 实现
1. 严格意义上说并没有自定义layout，而是使用的UICollectionViewFlowLayout，设置水平滚动方向，设置minimumLineSpacing为0
2. collectionView：设置pagingEnabled为YES
3. 以上可以达到轮播的目的，无限轮播实现方式，就是在第一张轮播视图的前面插入最后一张轮播，最后一张轮播视图的后面插入第一张轮播，这样在滑动到第一个或最后一个位置的时候，分别无动画的切换到原始数据的最后一张或第一张。再加入timer定时滚动。

### 2. 瀑布流（CHTCollectionViewWaterfallLayout）

瀑布流比较有代表的是app是Pinterest。特点是，每个元素都是等宽不等高，而且每当排列一个元素的时候，都是从最短的那一列开始排。这里我就不重复造轮了，因为有一个比较好的开源项目(CHTCollectionViewWaterfallLayout，注释也很充分)。但是作者有一个地方有欠缺(CHTFloorCGFloat)，但是可以忽略不计。

#### 实现
1. prepareLayout
计算好每一列的高度，计算每一个元素的Layout Attributes。作者在此方法最后有一个亮点，就是将Attributes每20个分组，后面调用layoutAttributesForElementsInRect:的时候使用，可以省掉一些运算，从而优化性能。
2. collectionViewContentSize
算出真个内容的高度，也就是最后一个section的列的高度(最后保持一致，因为已经展示完了)
3. layoutAttributesForElementsInRect:
先锁定Attributes组的范围，然后再具体求解，优化了性能。

### 3. 弹性header

下拉collectionView的时候，header可以被拉伸，从而可以更全面地查看图片更多细节，手势松开，又可以反弹到初始状态。

#### 实现
1. 展示时，在layoutAttributesForElementsInRect:方法中获取header的attributes
2. 然后设置attributes的y和height值，从而达到相应的效果
3. 弹性：调用collectionView的setAlwaysBounceVertical:，参数为YES
4. 设置图片展示方式为UIViewContentModeScaleAspectFill

### 4. 水平滚动放大

水平滚动cell，当到屏幕中间的时候，放到最大，并会自动校正位置

#### 实现

1. 展示时，layoutAttributesForElementsInRect:，设置每个item的Attributes，通过item中心点x和collectionView屏幕中心点的x值的间距来设置item的缩放
2. 校正位置：重写targetContentOffsetForProposedContentOffset:withScrollingVelocity:，在item不在中心位置的时候自动居中

### 5. 拖动item

手动长按item的时候，item稍微放大一些，提示用户当前可以做出拖动操作。然后移动item，可以将item任意的移动位置。iOS9已经有相应的API支持，而且比较简单，这里为了兼容iOS7以上，所以需要自定义layout。由于也有相应的轮子LXReorderableCollectionViewFlowLayout，这里就不重新造轮子了，局限是不适用于自定义layout。

### 实现

1. 添加长按手势，有可能手势冲突，比如iOS9添加长按手势实现移动元素，所以需要设置我们自定义长按手势优先级高(requireGestureRecognizerToFail:)。
2. 长按手势开始时，基于原有item的frame创建view，添加正常、高亮时的截图，然后放到view到1.1呗；长按手势结束时，view缩放到正常大小，然后view设置nil，拖动结束；两次相应的委托调用。
3. 拖动需要添加pan手势，拖动改变时，改变view的中心点即可。
4. 在layoutAttributesForElementsInRect:中，判断如果是当前操作的item，Attributes的hidden设为YES，从而隐藏原有的item。
5. invalidateLayoutIfNecessary，实现没有操作在item上面时不生效，及其相应的删除、插入操作，及其相应的委托方法。

## License

TTCollectionView is released under the MIT license. See LICENSE for details.
