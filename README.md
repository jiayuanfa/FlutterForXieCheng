# my_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
# FlutterForXieCheng


# Dart基础
- 常用数据类型 (data_type.dart)
- 常用数据类型之字符串、以及字符串的API（data_type.dart）
- bool类型的用法
- 集合list的用法
- map的用法
- dynamic、var、Object三者的却别，以及和数据类型的关系
- 类
- 类的构造函数
- 类的命名构造函数
- 类的工厂命名构造函数
- 类的get set方法
- 类的重载方法
- 抽象类、抽象方法
- mixin(with) 多继承
- 方法、私有方法、匿名方法
- 泛型、泛型约束
- 常见的一些编程技巧：安全调用、为表达式设置默认值、简化判断

# Flutter基础
- Flutter插件的使用（plugin_use.dart）
- StatelessWidget与基础组件
- StatefulWidget与基础组件
- Flutter布局开发（纵向拉伸填满高度、
- PageView：可设置内边距、圆角等、下拉刷新组件、Card组件、悬浮按钮组件、AlertDialog组件、Image组件、
- Chip组件：可设置左边图片、右边文字
- Warp组件：从左到右自动排列组件，可自动换行
- Stack组件：支持叠加布局，类似于Android的FrameLayout组件
- 创建和使用Flutter的路由以及导航（main.dart）
- 手势检测：点击、双击、长按、滑动（gesture_page.dart）
- Flutter第三方APP跳转
- Flutter Widget 生命周期 (flutter_widget_lifecycle.dart)
- Flutter App 维度的生命周期 (app_lifecycle.dart)
- Flutter 夜间模式和白天模式动态切换功能 (main.dart)
- Flutter 字体的更换 (main.dart)
- Flutter 相册APP的开发（photo_app_page.dart）
- Image网络图片加载带加载器的淡入淡出效果（Image_placeholder_page.dart）
- Image网络图片缓存

# Flutter动画
- Animation、AnimationController、AnimationState配合实现AppLogo动画（app_logo_page.dart）
- 使用AnimationWidget和AnimationBuilder来重构我们的动画
- AnimationWidget动画（animation_widget_page.dart）
- AnimationBuilder分离动画（animation_widget_page.dart）分离动画
- 使用SingleChildScrollView嵌套Column组件，解决Column内容过多造成的渲染溢出问题，SingleChildScrollView只能有一个child（main.dart）
- Hero动画（两个页面都有，hero元素在两个页面之间飞翔）
- 标准Hero动画的实现（通过tag来标识，两个页面之间识别传递）
- Hero RectTween 动画实现

# 携程APP开发
- 主页面 main.dart
- 框架搭建 tab_navigator.dart
- 首页轮播图实现（home_page.dart）
- 首页上下滑动轮播图渐变效果的实现

# HTTP
- 使用HTTP框架实现GET网络请求、JSON解析、Model转换
- 使用Future进行网络请求
- 使用FutureBuilder包装Future实现网络请求，并监听网络各阶段的状态
- 使用Utf8Decoder对response.body进行解析，解决中文乱码问题（http_future_builder_page.dart）
- 本地化持久存储：SharedPreferences的使用 (sp_page.dart)
- 复杂JSON转模型示例（test_model.dart）

# ListView
- 垂直滚动的ListView（list_view_page.dart）
- 水平滚动的ListView (list_view_horizontal.page.dart)
- 可折叠的列表ListView（expansion_list_view_page.dart）