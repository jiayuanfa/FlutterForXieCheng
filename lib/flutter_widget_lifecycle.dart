
import 'package:flutter/material.dart';

/// 生命周期
class WidgetLifecycle extends StatefulWidget {
  const WidgetLifecycle({Key? key}) : super(key: key);

  /// 1: createState 当我们构建一个新的Widget的时候，这个方法会被立即调用
  /// 必须被覆盖重写的方法
  @override
  State<WidgetLifecycle> createState() => _WidgetLifecycleState();
}

class _WidgetLifecycleState extends State<WidgetLifecycle> {

  /// 2: initState
  @override
  void initState() {
    super.initState();
    print('-------initState--------');
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
