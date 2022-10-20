import 'package:flutter/material.dart';

class AnimationWidgetPage extends StatefulWidget {
  const AnimationWidgetPage({Key? key}) : super(key: key);

  @override
  State<AnimationWidgetPage> createState() => _AnimationWidgetPageState();
}

class AnimatedLogo extends AnimatedWidget {

  /// 实现其构造方法
  const AnimatedLogo({Key? key, required Animation<double> animation})
      : super (key: key, listenable: animation);

  /// build会根据animation的值的变化重新渲染
  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        width: animation.value,
        height: animation.value,
        child: const FlutterLogo(),
      ),
    );
  }
}

class _AnimationWidgetPageState extends State<AnimationWidgetPage>
    with SingleTickerProviderStateMixin {
  Animation<double>? animation;
  AnimationController? animationController;
  AnimationStatus? animationStatus;
  double? animationValue;

  @override
  void initState() {
    super.initState();
    /// 动画控制器
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    /// 动画参数范围设定器
    /// 使用动画参数设定器+动画控制器初始化一个Animation
    animation = Tween<double>(begin: 0, end: 300).animate(animationController!);
    animationController?.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation'),
      ),
      body: AnimatedLogo(animation: animation!),
    );
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }
}
