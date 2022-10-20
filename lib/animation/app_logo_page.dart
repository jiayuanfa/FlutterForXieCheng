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
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
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
    return Container(
      padding: const EdgeInsets.all(50),
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              animationController?.reset();
              animationController?.forward();
            },
            child: const Text('Start'),
          ),
          Text(
            'State: ${animationStatus.toString()}',
            style: const TextStyle(fontSize: 20),
          ),
          Text('Value: ${animationValue.toString()}',
              style: const TextStyle(fontSize: 20)),
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
