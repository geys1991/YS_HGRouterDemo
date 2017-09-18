# HGRouter
## 设计要求
	1. 跳转方式全部使用 URL 的方式，这一方面主要是为了兼容 HGURLManager 的 openUrl 这种方式。统一成一种方式。
	2. 基于 CTMediator，并且不修改源代码

## 部分说明

* URL 生成：目前项目中使用的 URL 完整的格式为 ：higo://<font color=red>xxx1xxx</font>.higo?json_params={<font color=red>2</font>}。红字 1代表的是我们需要跳转的目标页面（需要配置），2代表的是传递的参数
	* 关于1处的配置，在HGRouterTargetHostMap.plist文件中配置.具体参数为
		- key: target Name 
		- value: 目标视图，view...
		- <font color=red>需要注意的是 如果在 url 的 host 参数设置为目标文件的文件名，则不需要对 plist 文件配置。某些情况下必须设置（外部跳转）</font>
	* 关于2处，这个 是跳转目标需要的额外参数。
* block 回调
	* block 的回调会在 API 的 Complete 中实现，通过 params 作为参数传递给目标视图。目前只能实现一个 block ，有多个回调的情况，请使用 delegate。
* delegate 
	* delegate 为了完全解耦合。所以，delegate 和 主体完全分离，在使用的时候，需要在 API 在传递参数 isSetDelegate。
* 自定义视图 CustomView 介绍
	* 自定义视图需要 关注的是 在弹出自定义View 的时候，统一确定 CustomView 的弹出的方法为 <font color=red>-(void)show;</font>
	* 也就是说，在自定义 View 的时候一定要注意的两点：
		1. 弹出方法<font color=red>-(void)show;</font>
		2. 参数设置 参考视图控制器的参考，需要实现 params 的 setter 方法。
		3. 回调方面，统一使用 <font color=red>@property (nonatomic, copy) void(^completeCallback)(NSDictionary *info);</font>来完成回调，回调数据 统一使用字典来包装。在有多个回调的情况下，现在看来是使用回调参数 ***info*** 来做判断（目前的想法是这样的，当然也可以使用 delegate）。
	
## 遇到的问题
	1. string 转换成 NSURL 的时候，需要注意 string 是否含有特殊字符。
	2. 在对 url string 的特殊字符转换的过程中(在看看)
		[url stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding] ios 9失效，但是能够解析出 host 等值。
		但是 新的 api stringByReplacingPercentEscapesUsingEncoding 解析不出来
	3. Target_Action 的命名
	4. 关于 一个页面 含有多个 回调的情况

	
	json_params%3D%7B%22model%22:%22%7B%5C%22number%5C%22:100%2C%5C%22name%5C%22:%5C%22Geys%5C%22%2C%5C%22vctype%5C%22:1%7D%22%2C%22btnTitle%22:%22Geys%22%7D
	
	
	
	
# CTMediator

## 重点 
	1. 解耦  模块之间解耦
	2. 跳转风险 如果使用字符串确定跳转目标，如何确定目标准确
	3. 关于 API，设计合适的 API




##### CTMediator  整体思路

![CTMediator](https://raw.githubusercontent.com/geys1991/ImageRepository/master/CTMediator/CTMediator%E6%B5%81%E7%A8%8B%E5%9B%BE.png)
 


	

## 参考
1. [Casa 的iOS应用架构谈 组件化方案](https://casatwy.com/iOS-Modulization.html)
2. [Casa 在现有工程中实施基于CTMediator的组件化方案](https://casatwy.com/modulization_in_action.html)
3. [HHRouter github](https://github.com/Huohua/HHRouter)
4. [JLRoutes](https://github.com/joeldev/JLRoutes)
5. [iOS 利用机制进行动态跳转ViewController](http://www.jianshu.com/p/481d95229f76)
6. [iOS Router设计](http://scorpiolin.github.io/2016/11/03/iOS-router/)
7. [蘑菇街 组件化之路](http://www.360doc.com/content/16/0316/13/25724933_542663459.shtml)
8. [组件化架构漫谈](http://www.jianshu.com/p/67a6004f6930)
9. [iOS组件化思路－大神博客研读和思考](http://www.jianshu.com/p/afb9b52143d4)
10. [iOS应用架构谈 组件化方案](https://casatwy.com/iOS-Modulization.html)