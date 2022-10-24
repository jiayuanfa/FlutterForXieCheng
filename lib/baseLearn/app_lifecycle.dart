
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// 如何获取Flutter应用维度的生命周期
/// WidgetBindingObserver: 是一个Widget绑定观察器，通过它我们可以监听应用的生命周期
class AppLifecycle extends StatefulWidget {
  const AppLifecycle({Key? key}) : super(key: key);

  @override
  State<AppLifecycle> createState() => _AppLifecycleState();
}

class _AppLifecycleState extends State<AppLifecycle> with WidgetsBindingObserver{

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App 的生命周期'),
        leading: BackButton(),
      ),
      body: Container(
        child: Text('App 的生命周期'),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('state = $state');
    }
    switch (state) {
      case AppLifecycleState.resumed:
        if (kDebugMode) {
          print('App进入前台');
        }
        break;
      case AppLifecycleState.inactive:
        // 不常用，比如来了个电话
        if (kDebugMode) {
          print('App变得不活跃');
        }
        break;
      case AppLifecycleState.paused:
        if (kDebugMode) {
          print('App进入后台');
        }
        break;
      case AppLifecycleState.detached:
        if (kDebugMode) {
          print('App detached');
        }
        break;
    }
  }
  
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
