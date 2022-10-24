
import 'package:flutter/foundation.dart';
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

  int _count = 0;

  /// 2: initState
  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      print('-------initState--------');
    }
  }

  /// 当依赖的State对象发生改变的时候被调用
  /// 在第一次构建Widget的时候，当initState方法被调用之后立即调用此方法
  @override
  void didChangeDependencies() {
    if (kDebugMode) {
      print('--------didChangeDependencies-------');
    }
    super.didChangeDependencies();
  }

  /// 这是一个必须实现的方法：在这里实现你要呈现的内容
  /// 它会在didChangeDependencies()之后立即调用
  /// 另外当调用setStates之后也会立即调用此方法
  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('-----build------');
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget生命周期变化'),
        leading: const BackButton(),
      ),
      body: Column(
        children: <Widget>[
          ElevatedButton(
              onPressed: (){
                setState(() {
                  _count++;
                });
              },
              child: const Text(
                '点我',
                style: TextStyle(fontSize: 26),
              )),
          Text(_count.toString()),
        ],
      ),
    );
  }

  /// 当父组件需要重绘的时候调用
  @override
  void didUpdateWidget(WidgetLifecycle oldWidget) {
      print('--------didUpdateWidget-------');
      super.didUpdateWidget(oldWidget);
  }

  /// 很少使用  组件被移除的时候调用 在dispose之前被调用
  @override
  void deactivate() {
    print('---------deactivate---------');
    super.deactivate();
  }

  /// 组件被销毁的时候调用
  @override
  void dispose() {
    print('---------dispose---------');
    super.dispose();
  }
}
