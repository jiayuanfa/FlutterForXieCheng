import 'package:flutter/material.dart';
import 'package:my_app/data_type.dart';
import 'package:my_app/generic_learn.dart';
import 'package:my_app/oop_learn.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';

void main() {
  runApp(const FlutterLayoutPage());
}

class FlutterLayoutPage extends StatefulWidget {
  const FlutterLayoutPage({Key? key}) : super(key: key);

  @override
  State<FlutterLayoutPage> createState() => _FlutterLayoutPageState();
}

class _FlutterLayoutPageState extends State<FlutterLayoutPage> {
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(fontSize: 20);
    return MaterialApp(
      title: '如何进行Flutter布局开发？',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('如何进行Flutter布局开发？')),
        body: Container(
          decoration: const BoxDecoration(color: Colors.white),
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  /// 圆角
                  ClipOval(
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: Image.network(
                          'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fi.qqkou.com%2Fi%2F0a2425698567x1999344470b253.jpg&refer=http%3A%2F%2Fi.qqkou.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1668591799&t=5ad64a19b1044f34595c951fb65dd7da'
                      ),
                    ),
                  )
                ],
              ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

