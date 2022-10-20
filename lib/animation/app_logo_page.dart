import 'package:flutter/material.dart';

class AppLogoAnimation extends StatefulWidget {
  const AppLogoAnimation({Key? key}) : super(key: key);

  @override
  State<AppLogoAnimation> createState() => _AppLogoAnimationState();
}

class _AppLogoAnimationState extends State<AppLogoAnimation>
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
    animation = Tween<double>(begin: 0, end: 300).animate(animationController!)
      ..addListener(() {
        /// 动画每调用一次就会回调我们的监听器
        setState(() {
          animationValue = animation?.value;
        });
      })
      ..addStatusListener((status) {
        setState(() {
          animationStatus = status;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation'),
      ),
      body: _contentWidget(),
    );
  }

  _contentWidget() {
    return Container(
      padding: const EdgeInsets.all(50),
      decoration: const BoxDecoration(color: Colors.white),
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              animationController?.reset();
              animationController?.forward();
            },
            child: const Text('Start', style: TextStyle(fontSize: 30),),
          ),
          Text(
            'State: ${animationStatus.toString()}',
            style: const TextStyle(fontSize: 20),
          ),
          Text(
              'Value: ${animationValue.toString()}',
              style: const TextStyle(
                fontSize: 20,
              )),
          SizedBox(
            width: animation?.value,
            height: animation?.value,
            child: const FlutterLogo(),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }
}
