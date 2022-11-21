
import 'package:flutter/material.dart';

import 'package:flutter_splash_screen/flutter_splash_screen.dart';


void main() {
  runApp(const FullScreenFit());
}

class FullScreenFit extends StatefulWidget {
  const FullScreenFit({Key? key}) : super(key: key);

  @override
  State<FullScreenFit> createState() => _FullScreenFitState();
}

class _FullScreenFitState extends State<FullScreenFit> {

  @override
  void initState() {
    super.initState();
    hideScreen();
  }

  ///hide your splash screen
  Future<void> hideScreen() async {
    Future.delayed(const Duration(milliseconds: 3600), () {
      FlutterSplashScreen.hide();
    });
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white
      ),
      home: const ContentPage(),
    );
  }
}

/// MediaQuery不能直接在MaterialApp使用，否则报错
/// 所以我们创建一个ContentPage来实现对padding的获取
class ContentPage extends StatelessWidget {
  const ContentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final EdgeInsets padding = MediaQuery.of(context).padding;

    return  Container(
      padding: EdgeInsets.fromLTRB(0, padding.top, 0, padding.bottom),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text('顶部', style: TextStyle(fontSize: 25, color: Colors.red),),
          Text('底部', style: TextStyle(fontSize: 25, color: Colors.red),)
        ],
      ),
    );
  }
}


