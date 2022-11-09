import 'package:flutter/material.dart';

/// 使用Animation Builder分离动画视图与逻辑的过程

/// 动画视图
class LogoWidget extends StatelessWidget {
  const LogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: const FlutterLogo(),
    );
  }
}

/// 变大的视图逻辑
class GrowTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;
  const GrowTransition({Key? key, required this.child, required this.animation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) => SizedBox(
          height: animation.value,
          width: animation.value,
          child: child,
        ),
        child: child,
      ),
    );
  }
}

class AnimationBuilderPage extends StatefulWidget {
  const AnimationBuilderPage({Key? key}) : super(key: key);

  @override
  State<AnimationBuilderPage> createState() => _AnimationBuilderPageState();
}

class _AnimationBuilderPageState extends State<AnimationBuilderPage>
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
      body: GrowTransition(
        animation: animation!,
        child: const LogoWidget(),
      ),
    );
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }
}
