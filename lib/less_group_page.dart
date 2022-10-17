import 'package:flutter/material.dart';
import 'package:my_app/data_type.dart';
import 'package:my_app/generic_learn.dart';
import 'package:my_app/oop_learn.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';

void main() {
  runApp(const LessGroupPage());
}

/// StatelessWidget: 内部不需要状态管理
/// 是一个不需要状态管理的组件
/// 不需要根据自身的状态来重新渲染自己
class LessGroupPage extends StatelessWidget {
  const LessGroupPage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(fontSize: 20);
    return MaterialApp(
      title: 'StatelessWidget与基础插件',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('StatelessWidget与基础插件')),
        body: Container(
          decoration: const BoxDecoration(color: Colors.white),
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Text('I am a text', style: textStyle),
              const Text('I am a text'),
              const Icon(Icons.android, size: 50, color: Colors.red),
              const CloseButton(),
              const BackButton(),
              const Chip(
                avatar: Icon(Icons.photo),
                label: Text('StatelessWidget与基础插件'),
              ),
              const Divider(
                height: 50, // 容器的高度
                indent: 50, // 左边距
                color: Colors.orange,
              ),

              /// Card : 带有圆角、阴影、边框效果的卡片
              Card(
                color: Colors.blue,
                elevation: 10,  // 阴影
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Text('I am a Card', style: textStyle),
                ),
              ),
              const AlertDialog(
                title: Text('盘他！'),
                content: Text('你这个糟老头子坏得很'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
