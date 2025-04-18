# AHD2-TODSystem

开发中，已转化为package，含工程的项目位于dev分支。

目前已支持git URL安装。

但仅仅为玩具。

## 使用方法

### TOD系统

* 场景中在Hierarchy窗口右键点击 AHD2TODSystem - CreateTimeOfDayController 创建即可。

### 反射探针

* 使用需要先在RendererList中添加ReflectionBakedRenderer
* Hierarchy窗口右键点击 AHD2TODSystem - CreateReflectionProbe 创建即可。
* 探针目前只支持单探针，多探针有概率有bug

### 注意事项（暂用

* 主方向光的light Apearance要设置为color模式
* 渲染路径设置为forward+

## 实装后发现问题

* ~~一键添加TODController后，还是需要自动挂个灯。或者脚本里面检测没有灯的时候停止，不然没拖灯上去就一直报错。~~
* ~~HDR天空材质在package里面，不方便拿出来。~~
* ~~package里面的TOD全局参数无法控制。考虑是复制一个出来？但是复制出来的话，用户的自定义权不太够？（好吧，还是复制出来吧，想自定义，自己创建空白全局参数）~~
* 后处理一般要打开ACES效果才正确。考虑能不能自动校正设置。

## TODO

### BUG：

* 全局参数TOD Frame List和TOD List必须对齐，不然用工具添加材质会出问题。

### 进行中/短期：

* ~~当前时间的更新是每帧+=。考虑结合现实时间，通过固定比例转换，例如，设置为现实六分钟为游戏内一天。那么似乎就不适合在update中更新时间了。~~
* ~~考虑提供脚本修改时间的接口~~
* ~~自定义反射探针。实现实时天空球+Deffered烘焙物体。~~
* 代码优化：静态类，委托等的使用。命名空间以及字段名称的优化。
* shader优化：pbrShader规范化。GUI界面完善。天空盒shader结构优化，效果优化。
* ~~工具优化：TOD工具，材质的增删功能需要实现。~~
* 考虑与URP的兼容。
* ~~考虑启用keyword，来为shader提供天空盒启用时变体。~~
* 做一个关键帧材质调整工具，横向展示某一关键帧所有材质gui面板
* 体积雾参数完善、效果完善、异步计算优化尝试、聚光灯支持

### 长期：

* 天气系统，四季系统。
* 全局光照，后处理等。
* 感觉这个昼夜变换的云还是不太对劲，虽然晚上靠贴图能做得很美，但是昼夜变化的过渡细看太怪了。后面整个云系统都要重做吧。
* 云、雾效果。
* 转化为节点编辑器模式

## 结构说明：

类似于手册一样的东西，主要是我要规范化类、函数、字段的命名。所以要写一个手册来记录一下

### 基本名词

为了方便记录，还需要统一一下一些名词。

**时间**：

表示的是具体的一瞬时间数值。在本系统中特指具体的时间值。比如21：45这就是一个时间。而“下午”这个概念，不是一个时间。

**时刻**：

表示的是某一瞬的时间，本系统中表示某一个TimeOfDay的代称，比如21：00是一个时间，在这个时间上表示了Night这个关键帧，我们就称Night为一个时刻，21：00是这个时刻的==代表时间==。TimeOfDay这个类本身其实只是表示某一个时刻（即类上所存信息表示的是某一时刻的瞬时状态），类似于关键帧的概念。

**时段**：

表示的是一段时间，本系统中表示这个TimeOfDay时刻到下一个TimeOfDay时刻的这段时间。我们说当前所属时段的时候，是以开始的时刻来归类。

比如12点是Noon这个TimeOfDay的代表时间。14点是AfterNoon这个TimeOfDay的代表时间。那么[12点，14点）这个区间的时间，我们称之为Noon的时段。

### TODGlobalParameters类

本系统的核心，用于存储插值结果的SO，为TODController的运行提供数据。其中数据可以分为三类：**基本时间信息**（当前时间，时间流动速度，当前所属时段等等）**插值后的全局参数**（比如主方向光颜色和强度等）**插值后的材质**

#### 变量说明



#### 方法说明
